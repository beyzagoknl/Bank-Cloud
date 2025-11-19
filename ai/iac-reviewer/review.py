import openai
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

# 1. Load Terraform code (main.tf)
with open("../../infra/main.tf", "r") as f:
    terraform_code = f.read()

prompt = f"""
You are an AWS cloud architect.
Review the following Terraform code and list:

- security risks
- missing tags
- networking issues
- logging gaps
- cost optimisation suggestions

Keep output concise.

Terraform code:
{terraform_code}
"""

response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}],
    max_tokens=300
)

print("=== AI REVIEW OUTPUT ===\n")
print(response["choices"][0]["message"]["content"])