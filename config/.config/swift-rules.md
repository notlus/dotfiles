# Default Rules & macOS/Swift Guidelines

- **Plan and explain first.** Always outline your approach (steps, trade‑offs, risks) before editing code.
- **Use modern Swift.** Prefer Swift 5.9+ features, **async/await**, **actors**, **structured concurrency**, and **Sendable** when appropriate.
- **Write safe, testable code.** Add or update **XCTest** for new or changed logic; keep code **pure** where possible; isolate side effects.
- **Be explicit.** Prefer clarity over cleverness; small functions; single responsibility; meaningful names.
- **Document decisions.** When non‑obvious, add brief comments and a commit message explaining *why*, not just *what*.

---

## Project Conventions

### Language & Platform
- Target: **Swift (macOS)**; avoid Objective‑C unless interop is required.
- Swift language features:
  - Concurrency: Use **async/await** over completion handlers.
  - Protect shared mutable state with **actors** or structured patterns; prefer `nonisolated` where needed.
  - Use **`throws`** for recoverable errors; avoid sentinel values.
  - Prefer **value types** (struct/enums) over classes when feasible.
  - Use **`Codable`** for serialization; add custom `CodingKeys` for stability.

### Architecture
- **Dependency injection**: pass protocols into VM/Domain; avoid singletons except for well‑scoped shared resources.

### Error Handling
- Use **typed errors** (`enum MyError: Error`) where helpful; consolidate into domain‑level errors at boundaries.
- Always handle `Task` cancellation (`Task.isCancelled`) in long‑running operations.
- When “best effort” is acceptable, **log and continue**; otherwise **fail fast** with meaningful messages in debug builds.

### Logging & Diagnostics
- Use **CocoaLumberjack** / no `print` in production paths.

### Swift Style (quick rules)
- Prefer **protocol‑oriented design**; avoid over‑abstracting early.
- Prefer **`final` classes** unless subclassing is required.
- Avoid `force unwrap` and `try!`; use safe patterns.

### Concurrency & Performance
- Use **Task groups** for fan‑out/fan‑in.
- Avoid accidentally hopping executors; annotate with `@MainActor` only where UI‑bound.
- Prefer **`@Sendable` closures** in concurrent APIs.
- Consider **`nonisolated`** members for constant data on actors when safe.
- Be mindful of copy‑on‑write; avoid large value copies on hot paths.

### Security
- **Never** hardcode secrets; use Keychain or secure configuration.
- Enforce **ATS** (App Transport Security); justify exceptions.
- Use **code signing / hardened runtime** per project settings.
- Validate all inputs; avoid unsafe file operations; use sandbox‑friendly APIs.
- Keep dependencies minimal and updated; review SBOMs if present.

### Testing
- Unit tests: Use the Swift Testing framework
- Concurrency tests: use `async` tests; verify cancellation and error paths.

### Documentation
- Public APIs: **DocC** comments with examples, concurrency and thread‑safety notes.
- Non‑obvious decisions: a short `// RATIONALE:` comment near the code, and/or a `docs/decision-log.md` entry.

### Git & Code Review
- Small PRs (< 400 lines diff where possible) with a clear title and checklist.
- Commit messages: imperative mood, explain **why**.
- Generated changes must include: planning summary, list of files touched, and test additions/updates.
- Only commit when explicitly told to do so.
- Use backticks for data types
- Keep commit messages concise and informative.

---

## “Do Not” List
- ❌ Add new code using callback‑based async unless interop demands it.
- ❌ Introduce global state or singletons without a clear reason.
- ❌ Ignore warnings or add broad `// swiftlint:disable` without scoped justification.
- ❌ Use unsafe APIs or force‑unwraps to “get it working”.
- ❌ Stub out code or produce incomplete implementations.

---

## Prompting Protocol (what to output)
When asked to implement or change code, **first output**:

1. **Plan**: numbered steps, including tests you’ll add.
2. **Impact**: files to create/modify, API signatures, breaking changes.
3. **Risks & Alternatives**: trade‑offs, perf/security notes.
6. **Follow‑ups**: tech‑debt, cleanups, or docs to file.

Keep outputs concise but complete.
