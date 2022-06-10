
// Datos del contrato
var myContractAddress = '0x04227bc794Fd82CA67c17b33A210201DfbF51e72'; // Smart Contract Colaborador
var myContractOwner   = '0xd504093E3b4043a589Ec8D4c7359B223031eFdbc'; // propietario del contrato (administrador)

var srcWalletAddr  = '0x9eb3CB5d6e421f876D7B3e7e527eFb40aF076442';
var destWalletAddr = '0x8Ce9f327bFa7B52508aFbf539663b59c826Fc690';

var myABI = [
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_codigoNoticia",
        "type": "uint256"
      }
    ],
    "name": "errPagarPieza",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_codigoNoticia",
        "type": "uint256"
      }
    ],
    "name": "errPublicarPieza",
    "type": "error"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "_nif",
        "type": "string"
      }
    ],
    "name": "evAltaColaborador",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "_nif",
        "type": "string"
      }
    ],
    "name": "evExisteColaborador",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      }
    ],
    "name": "evPiezaBorrada",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "codigoPieza",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "tituloPieza",
        "type": "string"
      }
    ],
    "name": "evPiezaInsertada",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "_datos",
        "type": "string"
      }
    ],
    "name": "evPiezaPagada",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      }
    ],
    "name": "evPiezaPublicada",
    "type": "event"
  },
  {
    "stateMutability": "payable",
    "type": "fallback",
    "payable": true
  },
  {
    "stateMutability": "payable",
    "type": "receive",
    "payable": true
  },
  {
    "inputs": [],
    "name": "getBalanceOwner",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "getAddressOwner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "getBalanceContract",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "getAddressContract",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      }
    ],
    "name": "getBalanceAddr",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      }
    ],
    "name": "existeColaborador",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "obtenerTodosColaboradores",
    "outputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "addr",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "nombre",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "NIF",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "email",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "tfno",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "activo",
            "type": "bool"
          }
        ],
        "internalType": "struct Colaborador.datosColaborador[]",
        "name": "",
        "type": "tuple[]"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      }
    ],
    "name": "obtenerColaborador",
    "outputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "addr",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "nombre",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "NIF",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "email",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "tfno",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "activo",
            "type": "bool"
          }
        ],
        "internalType": "struct Colaborador.datosColaborador",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "internalType": "string",
        "name": "_nombre",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_nif",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_email",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_tfno",
        "type": "string"
      }
    ],
    "name": "altaColaborador",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "internalType": "string",
        "name": "_titulo",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_url",
        "type": "string"
      }
    ],
    "name": "insertarPieza",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_address",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      }
    ],
    "name": "borrarPieza",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "addr",
        "type": "address"
      }
    ],
    "name": "obtenerTodasPiezasColaborador",
    "outputs": [
      {
        "components": [
          {
            "internalType": "uint256",
            "name": "codigoPieza",
            "type": "uint256"
          },
          {
            "internalType": "address",
            "name": "addr",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "tituloPieza",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "urlPieza",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "activada",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "publicada",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "pagada",
            "type": "bool"
          }
        ],
        "internalType": "struct Pieza.datosPieza[]",
        "name": "",
        "type": "tuple[]"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "addr",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      }
    ],
    "name": "obtenerPieza",
    "outputs": [
      {
        "components": [
          {
            "internalType": "uint256",
            "name": "codigoPieza",
            "type": "uint256"
          },
          {
            "internalType": "address",
            "name": "addr",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "tituloPieza",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "urlPieza",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "activada",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "publicada",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "pagada",
            "type": "bool"
          }
        ],
        "internalType": "struct Pieza.datosPieza",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_codigoPieza",
        "type": "uint256"
      }
    ],
    "name": "publicarPieza",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  }

];

