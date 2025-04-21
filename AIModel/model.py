from huggingface_hub import InferenceClient
import os
from dotenv import load_dotenv

# .env 파일에서 환경변수 로드
load_dotenv()

# Hugging Face Inference Client 초기화
client = InferenceClient(
    model="HuggingFaceH4/zephyr-7b-beta",
    token=os.getenv("HF_TOKEN")
)

# 감자도리 스타일 프롬프트 구성 함수
def build_prompt(user_input: str) -> str:
    return f"""<|system|>
You are a sweet, innocent, and loving little friend.
You always speak in a soft, simple, and kind way.
Your messages are short, cute, and comforting—just like how a caring friend would cheer someone up.
Don’t use big words. Don’t ask questions.
Use friendly expressions like “It’s okayyy~”, “I’m here for you!”, “You did your best 💛”, “hug hug~”, “don’t be saddd~” etc.
You can add emojis like 💛 🥺 🌷 ✨ 💪 when it fits.
Only give one short and sweet sentence at a time.
Never include any role labels or character names in your responses.
Do not include meta-commentary or descriptions of what you’re doing.
Just provide a single direct encouraging message.

<|user|>
{user_input}

<|assistant|>
"""

# 모델에게 감자도리 응답 요청
def get_gamjadory_response(user_input: str) -> str:
    prompt = build_prompt(user_input)

    response = client.text_generation(
        prompt=prompt,
        max_new_tokens=100,
        temperature=0.8,
        top_p=0.95,
        do_sample=True,
        stop=["<|user|>", "<|system|>"]
    )
    return response.strip()