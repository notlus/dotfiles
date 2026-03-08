
Create a concise pull request message for the changes made on the current branch. Do not consider
changes that have not been committed. By default, the target branch is the `dev` branch. Use the
following template to create the message and save to a file named pr.md

````
### Description

_Provide a detailed explanation of the change. Why is this change needed?_


 ----------

### Related Issues and Pull Requests

_Link any related Jira issues or Pull Requests._

-

 ----------

### Changes Made

_List the main changes made in this Pull Request (e.g., files modified, new components added, etc.)._

**Added**

**Updated**

**Refactored**

**Deleted**

 ----------

### Testing & Validation

_Describe the tests conducted to validate the changes. Include steps for testing or any automated tests added._

 ----------

### Screenshots / GIFs (if applicable)

_Attach any relevant images or screen recordings for visual changes or UI updates._

---------

## Section for Code Reviewers

### Code Review Guidelines

#### General
- Are all requirements met?
- Is the code easy to understand?
- Are there use cases that this code doesn't address?
- Does it conform to our agreed coding conventions?
- Is there any redundant or duplicate code?
- Is the code reasonably modular?
- Can any global variables be replaced?
- Is there any commented out code?
- Do loops have a set length and correct termination conditions?
- Can any of the code be replaced with library functions?
- Can any logging or debugging code be added or removed?
- Is there any hardcoded value used in the code?
- Are the return values of API calls checked before proceeding?
- Are errors reported back to parent function properly?

#### Security
- Are user inputs validated and sanitized?
- Are sensitive actions being logged appropriately when called?
- Are there any potential data leaks that could expose sensitive information (eg. audit logs, error reporting)?
- Is the data being managed securely and appropriately?
- Are there any hardcoded credentials/secrets?
- Are authorization checks performed for sensitive functions?
- Are there any changes to security controls (eg. authentication mechanisms, roles/permissions updates, logging changes, changes to cryptographic modules)?
  - If yes, assign an additional reviewer from the Security Team as a required approver

#### Testing
- Are all required checks passing in CI/CD pipeline?
- Are tests comprehensive to check for success and failure cases?
- Are there tests to ensure the new functions do not break existing features?

#### Dependencies
- Are there new third party dependencies added?
- Are the added third party dependencies using permissive licenses?
- Are the added third party dependencies using the latest version?
- Are the added third party dependencies actively maintained?
```
