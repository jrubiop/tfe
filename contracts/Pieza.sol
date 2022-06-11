// SPDX-License-Identifier: GPL-3.0
//pragma solidity >=0.4.16 <0.9.0;
pragma solidity >0.7.4;
pragma abicoder v2;

contract Pieza {

    // Propietario del contrato
    address contractOwner;
    address contractAddress;

    struct datosPieza {
        uint256 codigoPieza;
        address addr;
        string tituloPieza;
        string urlPieza;
        bool activada;
        bool publicada;
        bool pagada;
    }
    uint256 numeroPiezas;

    // Para almacenar las piezas y la asociacion con los colaboradores
    mapping (uint256 => datosPieza)     private piezas;
    mapping (uint256 => uint256)        private codigosPiezasIndice;
    mapping (address => uint256[])      private codigosPiezasColaboradores;
    mapping (address => datosPieza[])   private datosPiezasColaboradores;
    
    // Sin eventos...
    // No se emiten eventos porque se hacen desde el contrato Colaborador
    // que es el que controla el flujo

    // Constructor
    // Se invoca una vez al desplegar el contrato
    // El ownwer es el que despliega el contrato
    constructor () {
        contractOwner   = msg.sender;
        contractAddress = address(this);
        numeroPiezas = 0;
    }


    function getBalanceOwner() public view returns (uint) {
        return contractOwner.balance;
    }
    function getAddressOwner() public view returns (address) {
        return contractOwner;
    }
    function getBalanceContract() public view returns (uint) {
        return contractAddress.balance;
    }    
    function getAddressContract() public view returns (address) {
        return contractAddress;
    }

    function altaPieza(address _addr, string memory _titulo, string memory _url) external returns (datosPieza memory) {
        // Se autocalcula el codigo de la pieza
        //uint256 codigoPieza = block.timestamp;
        numeroPiezas++;

        // Se da de alta la pieza
        codigosPiezasColaboradores[_addr].push(numeroPiezas);
        
        datosPieza memory P = datosPieza(numeroPiezas, _addr, _titulo, _url, true, false, false);
        piezas[numeroPiezas] = P;

        datosPiezasColaboradores[_addr].push(P);
        codigosPiezasIndice[numeroPiezas] = datosPiezasColaboradores[_addr].length - 1;

        // Retorno de los datos almacenados
        return piezas[numeroPiezas];
    }

    function eliminaPieza(address _addr, uint256 _codigoPieza) external returns (bool) {
        require(msg.sender != _addr, "No tienes permisos para realizar la peticion");
        if (piezas[_codigoPieza].addr == _addr) {
            piezas[_codigoPieza].activada = false;
            return true;
        }
        else {
            revert("No eres el propietarios");
        }
    }

    function obtenerPieza(address _addr, uint256 _codigoPieza) public view returns (datosPieza memory) {
        // require(msg.sender != _addr, "No tienes permisos para realizar la peticion");
        if (piezas[_codigoPieza].addr == _addr) {
            return piezas[_codigoPieza];
        }
        else {
            return piezas[0];
        }
    }


    function obtenerCodigosPiezas(address _addr) public view returns (uint256[] memory) {
        // Obtener todos los codigos de pieza asociados a una direccion
        return codigosPiezasColaboradores[_addr];
    }

    function obtenerPiezasColaborador(address _addr) public view returns (datosPieza[] memory) {
        return datosPiezasColaboradores[_addr];
    }

    function publicarPieza(address _addr, uint256 _codigoPieza) public returns (bool) {

        // Comprobar que la pieza no esta ya publicada
        if ( piezas[_codigoPieza].publicada == true ) {
            revert('Pieza publicada');
        }

        uint256 indice = codigosPiezasIndice[_codigoPieza];
        if ( datosPiezasColaboradores[_addr][indice].publicada == true ) {
            revert('Pieza publicada 2');
        }

        // Se actualizan los datos de publicado y pagado
        piezas[_codigoPieza].publicada = true;
        piezas[_codigoPieza].pagada = true;

        datosPiezasColaboradores[_addr][indice].publicada = true;
        datosPiezasColaboradores[_addr][indice].pagada = true;

        return true;
    }

    // Para poder recibir pagos
    receive() external payable {}

    // Funcion de fallback para gestion de errores genericos
    fallback() external payable {}



}