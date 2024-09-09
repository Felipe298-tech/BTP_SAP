using EstudantesService as service from '../../srv/service';
annotate service.EstudantesByCursos with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Label : 'Nome',
                Value : Nome,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NomeEstudantes',
                Value : NomeEstudantes,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaxEstudantes',
                Value : MaxEstudantes,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : 'email',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Curso',
            Value : Nome,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Estudantes',
            Value : NomeEstudantes,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Maximo',
            Value : MaxEstudantes,
        },
    ],
);

