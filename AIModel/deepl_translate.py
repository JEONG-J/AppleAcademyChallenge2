import deepl
import os
from dotenv import load_dotenv

load_dotenv()  # .env 파일 읽기

DEEPL_API_KEY = os.getenv("DEEPL_API_KEY")
translator = deepl.Translator(DEEPL_API_KEY)

def translate(text: str, source_lang: str = None, target_lang: str = "KO") -> str:
    result = translator.translate_text(text, source_lang=source_lang, target_lang=target_lang)
    return result.text