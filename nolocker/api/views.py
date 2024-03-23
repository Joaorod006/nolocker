
from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['POST'])
def create_contrato(request):
    # Aqui você pode acessar os dados enviados com request.data
    print(request.data)
    # Realize operações com os dados recebidos, se necessário
    
    # Retorne uma resposta
    return Response({"status": "Dados recebidos com sucesso"})
