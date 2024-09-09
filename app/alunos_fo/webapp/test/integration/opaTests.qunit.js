sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'treinamento/alunosfo/test/integration/FirstJourney',
		'treinamento/alunosfo/test/integration/pages/EstudantesList',
		'treinamento/alunosfo/test/integration/pages/EstudantesObjectPage'
    ],
    function(JourneyRunner, opaJourney, EstudantesList, EstudantesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('treinamento/alunosfo') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEstudantesList: EstudantesList,
					onTheEstudantesObjectPage: EstudantesObjectPage
                }
            },
            opaJourney.run
        );
    }
);