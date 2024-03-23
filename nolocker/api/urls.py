from django.urls import path
from .views import create_contrato

urlpatterns = [
    path('contrato/create/', create_contrato, name='create-contract'),
]


