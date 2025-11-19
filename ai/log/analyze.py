import openai
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

with open("sample.log", "r") as f:
    logs = f.read()

prompt = f"""
You are an SRE.
Analyze these logs and provide:

- key errors
- likely root causes
- recommendations

Logs:
{logs}
"""

response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}],
    max_tokens=400
)

print("=== AI LOG INSIGHTS ===")
print(response["choices"][0]["message"]["content"])