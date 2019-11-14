from django.contrib import admin
from .models import Board, Subway

class BoardAdmin(admin.ModelAdmin):
    fields = ['content','title']
    list_display = ["title", "updated_at","created_at"]
    list_filter = ["updated_at"]
    search_fields = ["title", "content"]

class SubwayAdmin(admin.ModelAdmin):
    fields = ['name', 'sandwitch', 'date']
    list_display = ['id','name', 'sandwitch', 'date']


admin.site.register(Board, BoardAdmin)
admin.site.register(Subway, SubwayAdmin)




