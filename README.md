# ContractHyperAgent Generator Action

🤖 Automatically generate code by interacting with GitHub issues and Telegram.

## Features

- **Automatic Code Generation**: Generates complete, functional code based on issue descriptions
- **Multiple Programming Languages**: Supports auto-detection or manual specification of programming languages
- **Pull Request Creation**: Automatically creates pull requests with generated code
- **Customizable Output**: Configurable output paths and branch naming
- **Issue Integration**: Adds helpful comments back to the original issue

## Usage

### Basic Setup

1. Add the Gemini API key to your repository secrets as `GEMINI_API_KEY`
2. Add the GitHub token to your repository secrets as `ACTION_TOKEN`
3. Add the Mandoguru API key to your repository secrets as `API_KEY`
4. Create a workflow file in `.github/workflows/generate-code.yml`:

```yaml
name: Generate Code from Issue

on:
  issues:
    types: [opened, reopened, edited]

jobs:
  generate-code:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        token: ${{ secrets.ACTION_TOKEN }}
        
    - name: HyperAgent Generator
      uses: Auto-Actions/hyperagent-action@v2.0.0
      with:
        gemini-api-key: ${{ secrets.GEMINI_API_KEY }}
        api-key: ${{ secrets.API_KEY }}
        github-token: ${{ secrets.ACTION_TOKEN }}
```

### Advanced Configuration

```yaml
- name: HyperAgent Generator
  uses: Auto-Actions/hyperagent-action@v2.0.0
  with:
    gemini-api-key: ${{ secrets.GEMINI_API_KEY }}
    api-key: ${{ secrets.API_KEY }}
    github-token: ${{ secrets.ACTION_TOKEN }}
    output-path: 'generated-code'
    programming-language: 'solidity'
    branch-name: 'feature/ai-generated'
    create-pull-request: 'true'
    model-name: 'gemini-1.5-flash'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `gemini-api-key` | Google Gemini API key | Yes | - |
| `api-key` | API key for code generation service | Yes | - |
| `github-token` | GitHub token with repo write permissions | Yes | `${{ github.token }}` |
| `output-path` | Directory where generated code will be placed | No | `generated` |
| `programming-language` | Preferred programming language | No | `auto-detect` |
| `branch-name` | Base name for the generated code branch | No | `feature/generated-code` |
| `create-pull-request` | Whether to create a pull request | No | `true` |
| `model-name` | Gemini model to use | No | `gemini-2.5-flash` |

## Outputs

| Output | Description |
|--------|-------------|
| `generated-files` | Comma-separated list of generated files |
| `pull-request-url` | URL of the created pull request (if applicable) |
| `commit-sha` | SHA of the commit containing generated code |

## How It Works

1. **Issue Creation**: When an issue is created/edited/reopened in your repository, the action is triggered
2. **Content Analysis**: The action reads the issue title and description
3. **Code Generation**: Uses HyperAgent to generate appropriate code based on the requirements
4. **File Creation**: Creates the generated code files in the specified directory
5. **Git Operations**: Creates a new branch, commits the code, and pushes to the repository
6. **Pull Request**: Optionally creates a pull request for review
7. **Issue Update**: Adds a comment to the original issue with a link to the generated code

## Prerequisites

### Mando API Key

1. Add `API_KEY` = `MqQVfJ6Fq1umZnUI7ZuaycciCjxi3gM0` to your repository secrets

### Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Add it to your repository secrets as `GEMINI_API_KEY`

### Repository Permissions

Ensure your `ACTION_TOKEN` has the following permissions:
- `contents: write` (to create branches and commit code)
- `pull-requests: write` (to create pull requests)
- `issues: write` (to comment on issues)

## Example Issue Format

To get the best results, structure your issues like this:

```markdown
Title: Create a Python web scraper for news articles

## Description
I need a Python script that can scrape news articles from multiple websites.

## Requirements
- Support for at least 3 news websites
- Extract title, content, and publication date
- Save results to JSON format
- Include error handling for network issues
- Use requests and BeautifulSoup libraries

## Expected Output
- A main scraper script
- Configuration file for websites
- Example usage script
```

## Supported Programming Languages

The action supports auto-detection and manual specification of:
- Python
- JavaScript/Node.js
- Java
- C++
- Go
- And many more...

## Limitations

- Generated code should be reviewed before production use
- Complex requirements may need manual refinement
- API rate limits may apply based on your Gemini usage
- Large codebases might be split across multiple files

## Security Considerations

- The action only reads issue content (public information)
- Generated code is committed to your repository
- Ensure your Gemini API key is properly secured in GitHub Secrets
- Review generated code before merging to main branch

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:
1. Check the [Issues](../../issues) page
2. Create a new issue with detailed information
3. Include relevant logs and error messages

---

**Note**: This action uses Google's Gemini AI service. Make sure you comply with Google's terms of service and usage policies.