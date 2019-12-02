from django.shortcuts import render

# Create your views here.
def index(request):

    return render(request, 'ajax/index.html')

def ajax(request):
    search_key = request.GET['search_key']
    
    context = {
        'search_key':search_key
    }
    
    return render(request,'ajax/index.html',context)

