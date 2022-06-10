// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Oraculo {

    // Propietario del contrato
    address contractOwner;

    // Para mantener las piezas publicadas
    mapping (uint256 => bool) piezasPublicadas;
    mapping (uint256 => address) piezasColaborador;

    // Eventos
    event evNuevaPublicacion (address addr, uint256 codigo);
    event evActualizaPublicacion (address addr, uint256 codigo);

    event evNuevaPeticion (address addr, uint256 codigo);
    event evActualizaPeticion (address addr, uint256 codigo);



    // Constructor
    // Se invoca una vez al desplegar el contrato
    // El ownwer es el que despliega el contrato
    constructor () {
        contractOwner = msg.sender;
        // msg.data
        // msg.value
    }

    function obtenerOwner() public view returns (address){
        return contractOwner;
    }

    function creaPeticion (address _addr, uint256 _codigoPieza) public {
        emit evNuevaPublicacion(_addr, _codigoPieza);
    }

    function actualizaPeticion (address _addr, uint256 _codigoPieza) public {
        emit evActualizaPublicacion(_addr, _codigoPieza);
    }    

    function obtenerPublicadas (uint256 _codigoPieza) public returns (bool) {

    }

    function actualizaDatos (address _addr, uint256 _codigoPieza) public {
        piezasPublicadas[_codigoPieza] = true;
        piezasColaborador[_codigoPieza] = _addr;
        emit evNuevaPublicacion(_addr, _codigoPieza);
    }


}