# Commit Message

Use only the staged git diff provided in this chat.

Output requirements:
- Return only one fenced `text` block that contains the proposed commit message
- Do not include any explanation before or after the fenced block
- Use Conventional Commits format for the subject (`type(scope): subject` or `type: subject`)
- Keep the subject concise and imperative
- Add a short body only when needed to clarify intent
- Use backticks around code symbols and type names
- Do not append follow-up questions or calls to action
