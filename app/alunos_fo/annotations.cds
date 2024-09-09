using AdminService as service from '../../srv/service';
annotate service.Estudantes with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Nome',
                Value : Nome,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Data de Aniversario',
                Value : DtAniversario,
            },
            {
                $Type : 'UI.DataField',
                Value : Telefone,
                Label : 'Telefone',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : 'E-mail',
            },
                        {
                $Type : 'UI.DataField',
                Label : 'Curso',
                Value : curso_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : critico,
                Label : 'critico',
            },
            {
                $Type : 'UI.DataField',
                Value : observacao,
                Label : 'observacao',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Informações Gerais',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Nome',
            Value : Nome,
        },
        //Arte Felipe - inicio
                {
            $Type : 'UI.DataField',
            Label : 'Curso',
            Value : curso_ID,
        },
        //Arte Felipe - Fim
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.notificaAluno',
            Label : 'Notifica Aluno',
            Criticality: #Positive,
        },

    ],
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.inativaAluno',
            Label : 'Inativa Aluno',![@UI.Hidden]: {
                $edmJson: {$If: [
                    {$Eq: [
                        {$Path: 'IsActiveEntity'},
                        false // IsactiveEntity=false se estiver em modo EDIT esconde
                    ]},
                    true, // se não estiver em mode EDIT mostra.
                    false
                ]}
            }
        },
    ],
);

annotate service.Estudantes with {
    curso @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Cursos',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : curso_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Nome',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MaxEstudantes',
                },
            ],
        },
        Common.Text : {
            $value : curso.Nome,
            ![@UI.TextArrangement] : #TextOnly
        },
    )
};

annotate service.Estudantes with {
    critico @Common.FieldControl : #ReadOnly
};

annotate service.Estudantes with {
    observacao @(
        UI.MultiLineText : true,
        Common.FieldControl : #ReadOnly,
    )
};

