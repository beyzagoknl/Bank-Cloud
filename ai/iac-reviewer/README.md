# AI IaC Reviewer

This tool sends Terraform files to an LLM and receives:
- security risks
- missing tags
- networking gaps
- observability issues
- cost optimisation risks

This tool reads Terraform files and sends them to an LLM for analysis.

example usage:

```bash
cd ai/iac-reviewer
python3 review.py

