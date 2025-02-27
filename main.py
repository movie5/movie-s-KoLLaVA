from PIL import Image
import io

from fastapi import FastAPI, UploadFile, File

from starlette.middleware.cors import CORSMiddleware

from model import eval_model

app=FastAPI()

origins= ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/dl/generation")
async def generation(images: UploadFile = File(...)):
    try:
        file_data = await images.read()
        infer_image = Image.open(io.BytesIO(file_data)).convert('RGB')
        file_name = images.filename
    except Exception:
        return {"message": "There was an error uploading file"}
    finally:
        result = eval_model(infer_image)
    return {"generation_result": {file_name:result}}

"""
@app.post("/dl/generation")
async def generation(images: bytes = File(...)):
        file_data = Image.open(io.BytesIO(images)).convert("RGB")
        try:
            result = eval_model(file_data)
            return {"result":result}
        except Exception:
            return {"message":"There was an error"}

"""