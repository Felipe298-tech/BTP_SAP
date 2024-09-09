
    const cds = require('@sap/cds')

    /**Service Estudantes implemention */
    module.exports = cds.service.impl(function() {

        this.before(['CREATE', 'UPDATE'], 'Estudantes', function(req){

            console.log("Estudantes called");

            if(req.data && !req.data.Nome){
    //req.info(200, 'info - Nome precisa ser preenchido');        
    req.error(400, 'Erro - Nome precisa ser preenchido');
    //req.warn(400, 'Erro - Nome precisa ser preenchido');
    //req.notify(400 - 412, 'Erro - Nome precisa ser preenchido');
    //**Code 412, Significa que é uma mensagens de pré-condição */
            }
        })
}) 
        /**Service Cursos implemention */   
        //exercicio Felipe - MxdeEstudantes.
        module.exports = cds.service.impl(function() {

            this.before(['CREATE', 'UPDATE'],'Cursos', function(req){
                console.log("Cursos called");
    
                if(req.data && !req.data.Nome){
                req.error(400, 'Erro - Nome precisa ser preenchido');
                }
                if(req.data.MaxEstudantes > 30){
                req.error(400, 'Erro - Numero maximo de estudantes atingido');
                }else {
                req.notify(412, 'Vagas definidas com Sucesso!!'); 
                }
            })
        })
                 // Botão de ação Notificação Aluno
                 module.exports = cds.service.impl(function() {

                    this.on('notificaAluno', async function(req){
                       // console.log("Notificar Aluno");
                       // req.info("Aluno notificado");
                       console.log("Notifica Aluno");

                       let id;
                       let alunos;
                       let query;
                       let Nome;
                       let curso_id;
                       let status;
                       let cursos;
                       let cursos_nome;

                       //recupera ID do Aluno atraves do params
                       const params = req.params;
                       if(params !=null){

                        let adms = await cds.connect.to('Admin.Service'); //> connected via OData

                        for (let i = 0;i < params.length; i++){
                            if (params[i].ID !=null){
                                id = params[i].ID;
                                console.log('ID: ' + id );

                                query = SELECT `ID,Nome,DtAniversario,curso,status` .from `Estudantes` .where `ID= ${id}`;
                                alunos = await adms.run(query);
                                    if (alunos){
                                        Nome = alunos[0].Nome;
                                        curso_id = alunos[0].curso_id;
                                        status = alunos[0].status
                                    }

                                    console.log('Nome: ' + Nome + ' - ID Curso: ' + curso_ID);

                                        query = SELECT `ID,Nome` .from `Cursos` .where `ID = ${curso_ID}`;
                                         cursos = await adms.run (query);
                                          if (cursos){
                                              curso_nome = cursos[0].Nome;
                                            }

                                            console.log('Nome Curso: ' + curso_nome);

                                              req.info(400, 'Aluno: ' + id + ' ' + Nome + ' cursando: ' + curso_nome + ' Satus: ' + status + ' notificado com sucesso!');
                            }
                        }
                       }
                    })  
                })

                module.exports = cds.service.impl(function() {

                    this.after('READ', 'Estudantes', function(data){

                        //entidade Estudantes
                        const alunos = Array.isArray(data) ? data : [data];

                        //le todos os registros para determinar a criticidade baseado nos status do Aluno
                        alunos.forEach(aluno => {
                        // atualiza criticidade
                        switch (alunos.status){
                            case 'A': //Ativo
                            alunos.critico = 1;
                            break;
                            case 'I': //Inativo
                            aluno.critico = 2;
                            break;
                            case 'P'://Pendente
                            aluno.critico = 3;
                            break;
                            default:
                                break;
                        }
                    
                        });
                    
                    })
                })

                module.exports = cds.service.impl(function() {

                    this.on('inativaAluno', async function(req){

                        console.log("Inativa Aluno");

                        const { Estudantes } = this.entities; // Entidade

                        //recupera ID do Aluno atraves do params
                        const params = req.params;
                        if(params != null){
                            for (let i = 0; i < params.length; i++){

                                await UPDATE.entity(Estudantes, params[i].ID).set({status:'I', observacao: req.data.text});

                                console.log('ID: ' + ' - Status: ' + params[i].status);
    
                                req.info(400, 'Aluno ' + params[i].ID + '' + req.data.text + 'Status atualizado com sucesso!');
                            }     
                        }
                        req.reply();
                    })
                })



