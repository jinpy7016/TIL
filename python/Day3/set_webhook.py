import requests
from decouple import config
from pprint import pprint

token=config('TOKEN') #decouple library를 활용하여 .env의 token 값을 불러온다.
base_url = f"https://api.telegram.org/bot{token}"
#url = "44fc8b2d.ngrok.io"
url = "jinpy7016.pythonanywhere.com"
setweb_url=f'/setWebhook?url={url}'

#telegram server에 설정해달라고 요청
req = requests.get(base_url+setweb_url).json()
pprint(req)