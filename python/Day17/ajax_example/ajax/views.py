from django.shortcuts import render
from django.http import HttpResponse
import simplejson as json
# Create your views here.
def index(request):

    return render(request, 'ajax/index.html')

def ajax(request):
    # request.POST.get('json형식 안의 내용') from html
    from_html_text = request.POST.get('text')
    print(from_html_text)

    context = {
        'text_return': 'aaaaa',
        'text_return2': 'bbbb',
    }
    
    return HttpResponse(json.dumps(context), 'ajax/index.html')

