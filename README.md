HyperAgent GitHub Action

This GitHub Action automatically generates source code based on the title and description of a newly created GitHub issue. It uses the Gemini API to understand the software idea and pushes the generated code to a new feature branch.
How It Works

    Trigger: The action is triggered when an issue is created in your repository.

    Analyze: It reads the issue's title and body to form a prompt.

    Generate: It sends the prompt to the Gemini API to generate the code, requesting a structured JSON output of file paths and their corresponding code.

    Commit: It creates a new branch (e.g., feature/issue-123) and commits the generated files to it.

    Notify: It posts a comment on the original issue with a link to the newly created branch.

Setup and Usage

To use this action, create a workflow file in your repository at .github/workflows/hyperagent-assistant.yml.
Example Workflow

name: 'HyperAgent Code Assistant'

on:
  issues:
    types: [opened]

jobs:
  generate_code:
    runs-on: ubuntu-latest
    permissions:
      contents: write  # Required to push code
      issues: write    # Required to comment on the issue
    steps:
      - name: 'Generate Code from Issue'
        uses: {your-github-username}/hyperagent-assistant-action@v1 # Replace with your action's path
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          gemini_api_key: ${{ secrets.GEMINI_API_KEY }}

Configuration
Action Inputs

    github_token (Required): The GitHub token used to interact with the repository on your behalf.

    gemini_api_key (Required): Your API key for the Gemini API.

    system_prompt (Optional): A custom system prompt to guide the model's behavior. If not provided, a default prompt is used to ensure JSON output.

Best Practices for Keys and Secrets

For security, your sensitive keys and tokens should always be stored as encrypted secrets, never as plain text in your workflow file.

1. Using the GITHUB_TOKEN

The GITHUB_TOKEN is a special access token that GitHub automatically provides to your workflow. You don't need to create this secret yourself.

    Usage: Simply pass it to the action using github_token: ${{ secrets.GITHUB_TOKEN }}.

    Permissions: For this action to work, you must grant the necessary permissions to the job in your workflow file, as shown in the example:

    permissions:
      contents: write  # Allows the action to create branches and commit code
      issues: write    # Allows the action to comment on the issue

2. Configuring the GEMINI_API_KEY

Your Gemini API key is a personal credential and must be kept private. You should add it as a repository secret.

    Go to your repository's Settings tab.

    In the left sidebar, navigate to Secrets and variables > Actions.

    Click the New repository secret button.

    Name the secret GEMINI_API_KEY.

    Paste your API key into the "Secret" field.

    Click Add secret.

Once added, you can securely access it in your workflow file using gemini_api_key: ${{ secrets.GEMINI_API_KEY }}.
Building the Action (for Developers)

If you've forked this repository and want to make changes, you'll need to package the Node.js code into a single file.

    Install dependencies: npm install

    Bundle the code: npm run build

This will use @vercel/ncc to compile index.js and all its node_modules into a single dist/index.js file, which is what the action's main property points to.