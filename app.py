# -*- coding: utf-8 -*-

from flask import Flask, request, jsonify
import requests
from urllib.parse import urlparse

app = Flask(__name__)

def contains_domain(url):
    # Verifica se a URL contém o dominio permitido
    return "domain.com" in url

@app.route('/proxy', methods=['GET'])
def proxy_request():
    try:
        url_original = request.args.get('url')

        if not url_original:
            raise ValueError('É necessário fornecer uma URL')

        if not contains_domain(url_original):
            raise ValueError('A URL não contém o domínio permitido')

        response = requests.get(url_original)

        if response.status_code == 200:
            return '{}'.format(response.text), 200
        else:
            return 'A requisição falhou com o código de status {}'.format(response.status_code), response.status_code

    except ValueError as e:
        return str(e), 400

    except requests.exceptions.RequestException as e:
        return 'Erro ao fazer a requisição: {}'.format(str(e)), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5454)
