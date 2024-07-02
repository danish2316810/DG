using DangerousgoodsService as service from '../../srv/dangerousgoodsservice';
annotate service.DecisionMatrixSet with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'MaterialIsHaz',
                Value : MaterialIsHaz,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaterialIsLeak',
                Value : MaterialIsLeak,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaterialIsReclam',
                Value : MaterialIsReclam,
            },
            {
                $Type : 'UI.DataField',
                Label : 'HazType',
                Value : HazType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Container',
                Value : Container,
            },
            {
                $Type : 'UI.DataField',
                Label : 'IsContainerRequired',
                Value : IsContainerRequired,
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
            Label : 'MaterialIsReclam',
            Value : MaterialIsReclam,
        },
        {
            $Type : 'UI.DataField',
            Label : 'MaterialIsLeak',
            Value : MaterialIsLeak,
        },
        {
            $Type : 'UI.DataField',
            Label : 'MaterialIsHaz',
            Value : MaterialIsHaz,
        },
        {
            $Type : 'UI.DataField',
            Label : 'HazType',
            Value : HazType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Container',
            Value : Container,
        },
    ],
);

