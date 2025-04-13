from flask import Blueprint, request, jsonify
from deepl_translate import translate
from model import get_gamjadory_response

api_bp = Blueprint('api', __name__)

@api_bp.route("/generate", methods=["POST"])
def generate():
    user_input = request.json.get("input", "")

    # 영어일 경우 → 한국어로 번역
    if user_input.encode().isalpha():
        korean_input = translate(user_input, source_lang="EN", target_lang="KO")
    else:
        korean_input = user_input

    # 모델 호출 (한국어 입력 → 영어 응답)
    english_response = get_gamjadory_response(korean_input)

    # 영어 응답 → 한국어 번역
    korean_response = translate(english_response, source_lang="EN", target_lang="KO")

    return jsonify({"response": korean_response})