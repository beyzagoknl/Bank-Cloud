import openai
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

architecture_context = """
NovaBank PoC Architecture:
- API Gateway → Lambda → PostgreSQL RDS
- Fully private VPC subnets
- S3 logging bucket with encryption + lifecycle
- CloudWatch logs (400-day retention)
- SSM Parameter Store for database password
"""

prompt = f"""
Explain the following system to banking leadership.
Avoid technical jargon. Focus on safety, simplicity, and cost efficiency.

Architecture:
{architecture_context}
"""

response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}],
    max_tokens=400
)

print("=== AI ARCHITECTURE EXPLANATION ===")
print(response["choices"][0]["message"]["content"])