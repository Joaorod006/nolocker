const express = require('express');
const bodyParser = require('body-parser');
const { ethers } = require('ethers');
const axios = require('axios');
require('dotenv').config();
const contractABI = require('./ContratoABI');
const cors = require('cors');
let fetch;
const app = express();
const port = 8000;

// Estrutura em memória para armazenar os dados dos contratos temporariamente
const contratosTemporarios = {};

// Valores protegidos por variáveis de ambiente.
const providerUrl = process.env.PROVIDER_URL;
const privateKey = process.env.PRIVATE_KEY;
const contractAddress = process.env.CONTRACT_ADDRESS;




app.use(bodyParser.json());
app.use(cors())

// Configuração do provider e do contrato
const provider = new ethers.JsonRpcProvider(providerUrl);
const wallet = new ethers.Wallet(privateKey, provider);
const contract = new ethers.Contract(contractAddress, contractABI, wallet);



// Método POST recebido para Calcular Prêmio
app.post('/contrato/elaborar/', async (req, res) => {
    const dadosContrato = {
        walletAddress: req.body.walletAddress,
        nome: req.body.nome,
        idade: req.body.idade,
        cnh: req.body.cnh,
        estado: req.body.estado,
        fabricante: req.body.fabricante,
        modelo: req.body.modelo,
        anoVeiculo: req.body.anoVeiculo,
        placa: req.body.placa,
    };

    try {
        // Processo de cálculo do prêmio
        const valorCarro = 100000; // Valor exemplo genérico
        const premio = valorCarro * 0.25; // Cálculo genérico do prêmio

        // Adiciona o prêmio calculado aos dados do contrato
        dadosContrato.premio = premio;

        // Armazena os dados do contrato em memória usando o walletAddress como chave
        contratosTemporarios[dadosContrato.walletAddress] = dadosContrato;

        return res.status(200).json({ status: 'ok', premio: premio });
    } catch (error) {
        console.error("Erro ao processar a requisição:", error);
        return res.status(500).json({ status: 'error', message: "Erro ao processar a requisição" });
    }
});


// Envio do contrato ao Piñata e Criação do NFT

app.post('/contrato/aceitar/', async (req, res) => {
    const { walletAddress, aceiteContrato } = req.body;

    if (!aceiteContrato) {
        return res.status(400).json({ status: 'error', message: "O contrato não foi aceito." });
    }

    try {
        const dadosContrato = contratosTemporarios[walletAddress];

        if (!dadosContrato) {
            return res.status(404).json({ status: 'error', message: "Dados do contrato não encontrados." });
        }

        // Chama a função que envia os dados para o Pinata e espera pela URI de retorno
        const uriPinata = await enviarParaPinata(dadosContrato);
        
        // Enviar a URI e o walletAddress para a blockchain para criar o NFT
        const transaction = await contract.secureCar(uriPinata);
        console.log(transaction)
        const receipt = await transaction.wait(5); // Espera a transação ser concluída
        //console.log(receipt)

        // Após a criação do NFT, pode ser uma boa ideia limpar os dados temporários
        delete contratosTemporarios[walletAddress];

        return res.status(200).json({ status: 'ok', message: "Contrato aceito e NFT criado com sucesso.", uri: uriPinata });

    } catch (error) {
        console.error("Erro ao processar a aceitação do contrato e criação do NFT:", error);
        return res.status(500).json({ status: 'error', message: "Erro ao processar a aceitação do contrato e criação do NFT" });
    }
});


const enviarParaPinata = async (dadosContrato) => {
    try {
      const data = JSON.stringify({
        "pinataOptions": {
          "cidVersion": 0
        },
        "pinataMetadata": {
          "name": "Contrato_" + dadosContrato.walletAddress,
          "keyvalues": {
            "id": dadosContrato.walletAddress,
          }
        },
        "pinataContent": dadosContrato
      });
  
      const pinataResponse = await axios.post('https://api.pinata.cloud/pinning/pinJSONToIPFS', data, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${process.env.PINATA_JWT}`
        }
      });
  
      const uriPinata = `https://gateway.pinata.cloud/ipfs/${pinataResponse.data.IpfsHash}`;
      console.log('Dados contratados enviados ao Pinata:', uriPinata);
      return uriPinata; // Retorna a URI para ser usada na criação do NFT
    } catch (error) {
      console.error("Erro ao enviar para o Pinata:", error);
      throw error; // Lança o erro para ser tratado onde a função é chamada
    }
  };

app.get('/contrato/buscar/', async (req, res) => {
    // Obtém o endereço da carteira a partir dos parâmetros da query
    const walletAddress = req.query.walletAddress;

    if (!walletAddress) {
        return res.status(400).send('Endereço da carteira não fornecido.');
    }

    const url = `https://api.pinata.cloud/data/pinList?metadata={"wallet":"${walletAddress}"}`;
    const options = {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${process.env.PINATA_JWT}`
        }
    };

    try {
        // Carrega fetch dinamicamente se ainda não foi carregado
        if (!fetch) {
            fetch = (await import('node-fetch')).default;
        }

        const response = await fetch(url, options);
        const data = await response.json();
        res.json(data); // Envia os dados da resposta para o cliente
    } catch (error) {
        console.error('Erro ao buscar pins do Pinata:', error);
        res.status(500).send('Erro ao buscar pins do Pinata.');
    }
});

async function verificarSaldo() {
    try {
        // Obtém o saldo da carteira
        const balance = await provider.getBalance(wallet.address);
        console.log(`Saldo: ${ethers.formatEther(balance)} ETH`);

        // Obtém os dados de taxa atual
        const feeData = await provider.getFeeData();
        console.log("Dados da taxa atual:");

        // Imprime o preço do gás para transações legacy
        if (feeData.gasPrice) {
            console.log(`Preço do gás (legacy): ${ethers.formatUnits(feeData.gasPrice, 'gwei')} gwei`);
        }
        
        // Imprime o maxFeePerGas e maxPriorityFeePerGas para redes que suportam EIP-1559
        if (feeData.maxFeePerGas) {
            console.log(`Max Fee Per Gas: ${ethers.formatUnits(feeData.maxFeePerGas, 'gwei')} gwei`);
        }
        if (feeData.maxPriorityFeePerGas) {
            console.log(`Max Priority Fee Per Gas: ${ethers.formatUnits(feeData.maxPriorityFeePerGas, 'gwei')} gwei`);
        }

    } catch (error) {
    console.error("Erro ao verificar o saldo:", error);
}
};


// Chama a função para verificar o saldo
verificarSaldo();

// Iniciar servidor
app.listen(port, () => {
console.log(`Servidor rodando em http://localhost:${port}`);
});

