const express = require('express');
const bodyParser = require('body-parser');
const { ethers } = require('ethers');
const axios = require('axios');
require('dotenv').config();

const app = express();
const port = 8000;

// Estrutura em memória para armazenar os dados dos contratos temporariamente
const contratosTemporarios = {};

// Valores protegidos por variáveis de ambiente.
const providerUrl = process.env.PROVIDER_URL;
const privateKey = process.env.PRIVATE_KEY;
const contractAddress = process.env.CONTRACT_ADDRESS;
// Substitua a string vazia pela ABI real do seu contrato
const contractABI = []; 

app.use(bodyParser.json());

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

app.post('/contrato/aceitar/', async (req, res) => {
    const { walletAddress, aceiteContrato } = req.body;

    if (!aceiteContrato) {
        return res.status(400).json({ status: 'error', message: "O contrato não foi aceito." });
    }

    try {
        const dadosContrato = contratosTemporarios[walletAddress]; // Supondo que estes dados estejam armazenados em memória

        if (!dadosContrato) {
            return res.status(404).json({ status: 'error', message: "Dados do contrato não encontrados." });
        }

        const uriPinata = await enviarParaPinata(dadosContrato);
        console.log("URI do Pinata:", uriPinata);
        
        return res.status(200).json({ status: 'ok', message: "Contrato aceito e registrado na blockchain.", uri: uriPinata });
    } catch (error) {
        console.error("Erro ao processar a aceitação do contrato:", error);
        return res.status(500).json({ status: 'error', message: "Erro ao processar a aceitação do contrato" });
    }
});


const enviarParaPinata = async (dadosContrato) => {
  try {
    const data = JSON.stringify({
      "pinataOptions": {
        "cidVersion": 0
      },
      "pinataMetadata": {
        "name": "Contrato_" + dadosContrato.walletAddress, // Exemplo de nomeação dinâmica
        "keyvalues": {
          "id": dadosContrato.walletAddress, // Utilizando o walletAddress como ID
        }
      },
      "pinataContent": dadosContrato // Usando diretamente o objeto recebido
    });

    const res = await axios.post('https://api.pinata.cloud/pinning/pinJSONToIPFS', data, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.PINATA_JWT}`
      }
    });

    console.log(`Dados contratados enviados ao Pinata: https://gateway.pinata.cloud/ipfs/${res.data.IpfsHash}`);
    return `https://gateway.pinata.cloud/ipfs/${res.data.IpfsHash}`; // Retorna a URI do conteúdo no IPFS
  } catch (error) {
    console.error("Erro ao enviar para o Pinata:", error);
    throw error; // Repassar o erro para tratamento posterior
  }
};


/*
// Rota POST para criar um NFT
app.post('/nwt', async (req, res) => {
    const { buyerAddress, uri } = req.body;

    try {
        const transaction = await contract.secureCar(buyerAddress, uri);
        const receipt = await transaction.wait(); // Espera a transação ser concluída
        const nftId = receipt.events?.[0]?.args?.[0];

        res.status(201).json({ message: "NFT criado com sucesso", nftId });
    } catch (error) {
        console.error("Erro ao criar NFT:", error);
        res.status(500).json({ message: "Erro ao criar NFT", error: error.message });
    }
});
*/



// Iniciar servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
  });

