            using { treinamento, sap.common } from '../db/schemas';

            service AdminService {

                type inText : {
                    comment: String;
                };

                entity Estudantes as projection on treinamento.Alunos_FO actions {
                  @Common.IsActionCritical
                  action notificaAluno(); 
                  @Common.IsActionCritical
                  action inativaAluno(text:inText:comment);
                };
                annotate Estudantes with @odata.draft.enabled;
                annotate Estudantes @odata.draft.bypass;

            entity Cursos as projection on treinamento.Cursos; 
            annotate Cursos with @odata.draft.enabled;
            annotate Cursos @odata.draft.bypass;      
                }

            service EstudantesService{

            view EstudantesByCursos as 
            select from treinamento.Cursos as CursosEstudantes {

                key ID,
                Nome,
                estudantes.Nome as NomeEstudantes,
                estudantes.DtAniversario as DataAniversario,
                MaxEstudantes as MaxEstudantes,
                estudantes.email as email
            }
        }

        annotate AdminService.inText:comment with @Common.Label : 'Deseja Realizar a Inativacao? Incluir Observacoes:'; 
        annotate AdminService.inText:comment with @UI.MultiLineText:true;
