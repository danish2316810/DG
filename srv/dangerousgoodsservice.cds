using dg as my from '../db/dangerousgoods-db';

// @requires: [
//     'ULTA_DG_CORP_READ',
//     'ULTA_DG_CORP_UPDATE'
// ]
service DangerousgoodsService {
    entity OceantravelSet           as projection on my.Un_Num_3E;
    entity HazWasteSet              as projection on my.Haz_Waste_3E;
    entity HazTranSet               as projection on my.Haz_Tran_3E;
    entity DistinctArticleSet       as select distinct matnr from my.Haz_Waste_3E;
    entity DistinctArticleTranSet   as select distinct matnr from my.Haz_Tran_3E;
    entity DistinctOceanFlgSet      as select distinct ocean_travel from my.Un_Num_3E;
    entity DistinctRegionSet        as select distinct regio from my.Haz_Waste_3E;
    entity DistinctHazTypeSet       as select distinct hazType from my.Haz_Waste_3E;
    entity DistinctHazNumSet        as select distinct un_hin from my.Haz_Tran_3E;
    entity DistinctHazmatFlagSet    as select distinct haz_flag from my.Haz_Tran_3E;
    entity DistinctOceanFlagSet     as select distinct ocean_travel from my.Haz_Tran_3E;
    entity DistinctHazmatImdgFlgSet as select distinct haz_flag_imdg from my.Haz_Tran_3E;
    entity HazWasteSet_MIA          as projection on my.Haz_Waste_3E;
    entity HazTranSet_MIA           as projection on my.Haz_Tran_3E;
    
    // Entity related to Disposition app...
    // @restrict: [{
    //     grant: 'READ',
    //     to: 'ULTA_DG_DISPO_READ'
    // }, {
    //     grant: '*',
    //     to: 'ULTA_DG_DISPO_MAINTAIN'
    // }]
    entity DispositionSet as projection on my.Dispo_3E;

    // Entity used to get value help for Disposition app...
    entity DispoSiteSet as select distinct werks from my.Dispo_3E;
    entity DispoUserNameSet as select distinct uname from my.Dispo_3E;
    entity DispoArticleSet as select distinct matnr from my.Dispo_3E;
    entity DispoHazTypeSet as select distinct hazType from my.Dispo_3E;
    entity DispoScanBinSet as select distinct scan_bin from my.Dispo_3E;
    entity DispoStrgUnitSet as select distinct lp from my.Dispo_3E;
    entity Dispo3EFoundSet as select distinct found_on_3e from my.Dispo_3E;
    entity DispoReclaimSet as select distinct reclamation from my.Dispo_3E;
    entity DispoLeakingSet as select distinct leaking from my.Dispo_3E;

    // @restrict: [{
    //     grant: 'READ',
    //     to: 'ULTA_DG_HAAZTYPE_READ'
    // }, {
    //     grant: '*',
    //     to: 'ULTA_DG_HAAZTYPE_MAINTAIN'
    // }]
    entity HazTypeDataSet as projection on my.HazTypes_3E;

    // Entity used to get value help for Hazardous Types App...
    entity HazTypeBinF4Set as select distinct scan_bin from my.HazTypes_3E;
    entity HazTypeF4Set as select distinct hazType from my.HazTypes_3E;
    entity HazTypeCreatedByF4Set as select distinct createdBy from my.HazTypes_3E;
    entity HazTypeModifiedByF4Set as select distinct modifiedBy from my.HazTypes_3E;
    entity DecisionMatrixSet as projection on my.disposition_Decision_matrix;

    // functions to create / update hazardous type table...
    // @restrict: [{
    //     grant: '*',
    //     to: 'ULTA_DG_HAAZTYPE_MAINTAIN'
    // }]
    action onCreateHazBin(Scanbin: String(8), HazType: String(20)) returns String;
    // @restrict: [{
    //     grant: '*',
    //     to: 'ULTA_DG_HAAZTYPE_MAINTAIN'
    // }]
    action onUpdateHazBin(Scanbin: String(8), HazType: String(20)) returns String;

     @cds.persistence.skip
    @odata.singleton
    entity Plant {
        werks  : String(4);
        Region : String(4);
    }


    // @cds.persistence.skip
    // @odata.singleton
//  @readonly   entity Article {
//         article     : String(18);
//         description : String(40);
//         returnDisposition: String(60);
//         hazType     : String(20);
//         scan_bin    : String(8);
//         Message     : String(500);
//     }
// type   Article {
//         article     : String(18);
//         description : String(40);
//         returnDisposition: String(60);
//         hazType     : String(20);
//         scan_bin    : String(8);
//         Message     : String(500);
//     }

action getArticles(Article: String) returns array of my.Article;
function fngetPlant() returns  String;
     @cds.persistence.skip
    @odata.singleton
    entity UserAuth {
        disableUpdate : Boolean;
    }

}

annotate DangerousgoodsService.HazTypeDataSet with @odata.draft.enabled;