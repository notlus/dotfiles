// A tmux-style prefix key, ported from the herdr CLI's prefix mode (prefix = ctrl+a).
// keys.json opens this popup with `mod.open:prefix`. The next key runs its command and
// closes the popup. Any other key, or Escape, just closes it.
import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { focused, panes, hc, run, openOverlay, closeOverlay, props, theme } from "herdr";

const go = (direction) => () => run("pane.go", { direction });

function cyclePane(step) {
  const f = focused();
  const list = panes().filter((p) => p.tab === f?.tab);
  if (list.length < 2) return;
  const at = list.findIndex((p) => p.pane === f.pane);
  run("pane.focus", { pane: list[(at + step + list.length) % list.length].pane });
}

function newWorktree() {
  openOverlay({
    mod: "worktree",
    kind: "dialog",
    width: 460,
    height: 280,
    props: { space: focused()?.space, folder: panes().find((p) => p.focused)?.cwd, action: "new" },
  });
}

async function sendPrefix() {
  const terminal = focused()?.terminal;
  if (terminal) await hc(["keys", terminal, "ctrl+a"]);
}

/** Each group is a column in the popup. A row's `keys` are what to press, `label` what shows. */
const GROUPS = [
  {
    title: "Tabs",
    rows: [
      { label: "c", text: "New tab", keys: { c: () => run("tab.new") } },
      { label: "n / p", text: "Next / previous", keys: { n: () => run("tab.next"), p: () => run("tab.prev") } },
      {
        label: "1-9",
        text: "Go to tab",
        keys: Object.fromEntries([1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) => [String(i), () => run("tab.select", { index: i })])),
      },
      { label: "T", text: "Rename tab", keys: { T: () => run("tab.rename") } },
      { label: "X", text: "Close tab", keys: { X: () => run("tab.close") } },
    ],
  },
  {
    title: "Panes",
    rows: [
      { label: "v / -", text: "Split right / down", keys: { v: () => run("pane.split", { direction: "right" }), "-": () => run("pane.split", { direction: "down" }) } },
      { label: "h j k l", text: "Focus pane", keys: { h: go("left"), j: go("down"), k: go("up"), l: go("right") } },
      { label: "tab", text: "Next / prev (⇧)", keys: { tab: () => cyclePane(1), "shift-tab": () => cyclePane(-1) } },
      { label: "z", text: "Zoom pane", keys: { z: () => run("pane.zoom") } },
      { label: "x", text: "Close pane", keys: { x: () => run("pane.close") } },
    ],
  },
  {
    title: "Spaces",
    rows: [
      { label: "w / g", text: "Go to…", keys: { w: () => run("mod.open", { name: "picker" }), g: () => run("mod.open", { name: "picker" }) } },
      { label: "N", text: "New space", keys: { N: () => run("space.new") } },
      { label: "G", text: "New worktree", keys: { G: newWorktree } },
      { label: "W", text: "Rename space", keys: { W: () => run("space.rename") } },
      { label: "D", text: "Close space", keys: { D: () => run("space.close") } },
    ],
  },
  {
    title: "App",
    rows: [
      { label: "b", text: "Toggle sidebar", keys: { b: () => run("layout.toggle", { id: "sidebar" }) } },
      { label: "s", text: "Settings", keys: { s: () => run("app.settings") } },
      { label: "?", text: "Help", keys: { "?": () => run("app.help") } },
      { label: "ctrl-a", text: "Send ctrl-a", keys: { "ctrl-a": sendPrefix } },
    ],
  },
];

const ACTIONS = Object.assign({}, ...GROUPS.flatMap((g) => g.rows.map((r) => r.keys)));

/** Printable keys by the character they type (`?`, `N`, `-`), others by their chord (`tab`, `ctrl-a`). */
function keyName(e) {
  const m = e.modifiers;
  if (!m.control && !m.alt && !m.platform && e.key_char && e.key_char.trim().length === 1) return e.key_char;
  return e.keystroke;
}

export default class Prefix extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.handle.focus();
    cx.timer.after(16, () => this.handle.focus());
  }

  /** Closes the popup, then runs the key's action. `hc` starts before close cancels this copy's tasks. */
  press(name) {
    const action = ACTIONS[name];
    closeOverlay(props().overlay);
    action?.();
  }

  render() {
    const t = theme();
    const column = (g) =>
      v_flex().flex_1().gap(5).min_w(0).children([
        div().text_size(11).font_semibold().text_color(t.dim).child(g.title.toUpperCase()),
        ...g.rows.map((r) =>
          h_flex().gap(8).items_center()
            .child(div().w(52).flex_none().text_color(t.accent).font_semibold().child(r.label))
            .child(div().flex_1().truncate().text_color(t.foreground).child(r.text))),
      ]);

    return v_flex()
      .id("prefix")
      .track_focus(this.handle)
      .size_full()
      .p(16)
      .gap(12)
      .bg(t.popover)
      .text_size(12)
      .on_key_down((e, cx) => {
        cx.stop_propagation();
        this.press(keyName(e));
      })
      .child(
        h_flex().items_center()
          .child(div().flex_1().text_size(14).font_semibold().text_color(t.foreground).child("Prefix"))
          .child(div().text_size(11).text_color(t.dim).child("Esc to cancel")))
      .child(h_flex().gap(16).items_start().children(GROUPS.map(column)));
  }
}
