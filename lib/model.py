import base64
from google import genai
from google.genai import types
import PIL.Image

# from kaggle_secrets import UserSecretsClient

# user_secrets = UserSecretsClient()
GOOGLE_API_KEY = "AIzaSyA8VPfs5AH4Ftzfthc8EJtEIoZDeZ1mA6M"
client = genai.Client(api_key=GOOGLE_API_KEY)
MODEL_ID = "models/gemini-2.0-flash-exp"
def describeImage(filename):
    
    image = PIL.Image.open("assets/Plants/")   


    # Generate content
    response = client.models.generate_content(
        model="gemini-2.0-flash", contents = ["Describe this image", image]

    )
    return response.text