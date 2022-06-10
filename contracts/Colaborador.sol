// SPDX-License-Identifier: GPL-3.0
//pragma solidity >=0.4.16 <0.9.0;
pragma solidity >0.7.4;
pragma abicoder v2;

import "./Pieza.sol";

contract Colaborador {

    Pieza contratoPieza = new Pieza();

    // Propietario del contrato
    address contractOwner;
    address contractAddress;

    struct datosColaborador {
        address addr;
        string nombre;
        string NIF;
        string email;
        string tfno;
        bool activo;
    }

    // Para almacenar la lista de colaboradores
    datosColaborador[] private arrayColaboradores;
    mapping (address => datosColaborador) private colaboradores;

    // Eventos de colaboradores
    event evAltaColaborador(address _addr, string _nif);
    event evExisteColaborador(address _addr, string _nif);

    // Eventos de piezas
    event evPiezaInsertada(address _addr, uint256 codigoPieza, string tituloPieza);
    event evPiezaBorrada(address _addr, uint256 _codigoPieza);  
    event evPiezaPublicada(address _addr, uint256 _codigoPieza);
    event evPiezaPagada(address _addr, uint256 _codigoPieza, string _datos);

    // Errores
    error errPublicarPieza (uint256 _codigoNoticia);
    error errPagarPieza (uint256 _codigoNoticia);
    
    // Constructor
    // Se invoca una vez al desplegar el contrato
    // El ownwer es el que despliega el contrato
    constructor () {
        contractOwner   = msg.sender;
        contractAddress = address(this);
    }

    // Modificador para comprobar si es propietario
    modifier soloPropietario() {
        require(msg.sender==contractOwner, "No tienes permisos para realizar la peticion");
        _;
    }

    function getBalanceOwner() public view returns (uint256) {
        return contractOwner.balance;
    }
    function getAddressOwner() public view returns (address) {
        return contractOwner;
    }
    function getBalanceContract() public view returns (uint256) {
        return contractAddress.balance;
    }    
    function getAddressContract() public view returns (address) {
        return contractAddress;
    }
    function getBalanceAddr(address _addr) public view returns (uint256) {
        return _addr.balance;
    }
 
    // 
    // COLABORADORES
    //
    function existeColaborador(address _addr) public view returns (bool) {
        if ( colaboradores[_addr].activo == true) {
            return true;
        }
        else {
            return false;
        }
    }

    function obtenerTodosColaboradores() public view soloPropietario returns ( datosColaborador[] memory ){
    //function obtenerTodosColaboradores() public view returns (datosColaborador[] memory){
        return arrayColaboradores;
    }

    function obtenerColaborador(address _addr) public view returns (datosColaborador memory){
        return colaboradores[_addr];
    }

    //function altaColaborador(address _addr, string memory _nombre, string memory _nif,  string memory _email, string memory _tfno) public {
    function altaColaborador(address _addr, string memory _nombre, string memory _nif,  string memory _email, string memory _tfno) public soloPropietario {
        // Se da de alta el colaborador
        if (existeColaborador(_addr) == false) {
            datosColaborador memory data = datosColaborador(_addr, _nombre, _nif, _email, _tfno, true);
            colaboradores[_addr] = data;
            arrayColaboradores.push(data);

            // Notificacion de evento
            emit evAltaColaborador(_addr, _nif);
        }
        else {
            emit evExisteColaborador(_addr, _nif);
        }
    }

    // 
    // PIEZAS
    //
    function insertarPieza(address _addr, string memory _titulo, string memory _url) public {
        // Se da de alta la pieza
        Pieza.datosPieza memory p = contratoPieza.altaPieza(_addr, _titulo, _url);
        emit evPiezaInsertada(_addr, p.codigoPieza, p.tituloPieza);
    }

    function borrarPieza(address _address, uint256 _codigoPieza) public {
        bool ret = contratoPieza.eliminaPieza(_address, _codigoPieza);
        if (ret == true) {
            // Todo OK
            emit evPiezaBorrada(_address, _codigoPieza);
        }
    }

    function obtenerTodasPiezasColaborador(address addr) public view returns (Pieza.datosPieza[] memory){
        return contratoPieza.obtenerPiezasColaborador(addr);
    }

    function obtenerPieza(address addr, uint256 _codigoPieza) public view returns (Pieza.datosPieza memory){
        //address addr = msg.sender;
        return contratoPieza.obtenerPieza(addr, _codigoPieza);
    }


    function publicarPieza(address _addr, uint256 _codigoPieza) public soloPropietario returns (bool) {

        // Se obtiene la pieza y se verifican los datos
        Pieza.datosPieza memory p = obtenerPieza(_addr, _codigoPieza);

        // Para comprobar si la pieza esta activa
        if (p.activada != true) {
            revert('No existe la pieza...');
        }
        if ( p.publicada == true ) {
            revert('Pieza publicada');
        }
        if ( p.pagada == true ) {
            revert('Pieza pagada');
        }        
        if (p.addr != _addr) {
            revert('No es el propietario de la pieza');
        }
        if (p.codigoPieza != _codigoPieza) {
            revert('No es el codigo de la pieza');
        }

        // Condicion para poder pagar la pieza
        require(address(this).balance >= 0.5 ether, 'El contrato no tiene saldo suficiente');

        bool ret = contratoPieza.publicarPieza(_addr, _codigoPieza);
        if (ret == false) {
            revert errPublicarPieza({
                _codigoNoticia: _codigoPieza
            });
        }
        emit evPiezaPublicada(_addr, _codigoPieza);

        // Cuando la pieza esta publicada hay que pagarla
        bool resultado = pagarPublicacion(p.addr);

        // Comprobacion del pago
        if (resultado == false) {
            revert errPagarPieza({
                _codigoNoticia: _codigoPieza
            });
        }
        string memory datos = 'Pagado 1 ETH';
        emit evPiezaPagada(_addr, _codigoPieza, datos);

        // TODO seria mejor devolver el tipo de error: OK, ERR, ya publicado, ya pagado....
        return resultado;
    }

    // 
    // PAGOS
    //
    //function pagarPublicacion(address _addr) public returns (bool) {
    function pagarPublicacion(address _addr) private returns (bool) {
        require(address(this).balance >= 0.5 ether, 'No hay saldo suficiente');
        require(msg.sender == contractOwner, 'Solo el administrador puede pagar');

        (bool ret, ) = payable(_addr).call{value:1 ether}("");
        require(ret, 'Error al pagar !!!....');
        return ret;
    }

    // Para poder recibir pagos
    receive() external payable {}

    // Funcion de de fallback para gestion de errores genericos
    fallback() external payable {}

}