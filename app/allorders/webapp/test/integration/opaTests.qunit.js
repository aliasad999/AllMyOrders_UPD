sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ordermonitoring/allorders/test/integration/FirstJourney',
		'ordermonitoring/allorders/test/integration/pages/ResultsList',
		'ordermonitoring/allorders/test/integration/pages/ResultsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ResultsList, ResultsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ordermonitoring/allorders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheResultsList: ResultsList,
					onTheResultsObjectPage: ResultsObjectPage
                }
            },
            opaJourney.run
        );
    }
);