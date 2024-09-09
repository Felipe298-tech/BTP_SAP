namespace treinamento;

using { managed, cuid } from '@sap/cds/common';
using { Attachments } from '@cap-js/attachments';


entity Alunos_FO : cuid, managed {
   // key ID : UUID;
    Nome   : String @mandatory
                    @assert.format: '[a-zA-Z]+ [a-zA-Z]';          
    DtAniversario : Date @mandatory;
    Telefone : String @assert.format: '[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]';  
    email : String @assert.format: '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]'; 
    curso : Association to Cursos;
    status : String(1) @assert.range enum {A; I; P;}; 
    critico: Integer; 
    attachments: Composition of many Attachments;
    observacao:  String  ;
}

entity Cursos : cuid, managed {
 //  Key ID : UUID;
    Nome : String @mandatory ;
    MaxEstudantes : Integer @mandatory
                            @assert.range: [0,30];
    estudantes : Association to many Alunos_FO on estudantes.curso = $self;
    
}
