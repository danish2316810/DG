sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'dgdispodm/test/integration/FirstJourney',
		'dgdispodm/test/integration/pages/DecisionMatrixSetList',
		'dgdispodm/test/integration/pages/DecisionMatrixSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, DecisionMatrixSetList, DecisionMatrixSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('dgdispodm') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheDecisionMatrixSetList: DecisionMatrixSetList,
					onTheDecisionMatrixSetObjectPage: DecisionMatrixSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);