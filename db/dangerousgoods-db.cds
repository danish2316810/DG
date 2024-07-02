namespace dg;

using { managed,cuid } from '@sap/cds/common';


entity Haz_Waste_3E {
    
    key regio    : String(3) @title : 'Region';
    key matnr    : String(18) @title : 'Article Number';
        hazType  : String(20)@title : 'Hazwaste Nature';
        effDate : Date @title : 'Effective From Date';
        
}

entity Haz_Waste_3E_Hist {
    
    key regio    : String(3);
    key matnr    : String(18);
    key hazType  : String(20);
    key eff_Date : Date;
        end_Date : Date;
}

entity Haz_Tran_3E : managed{
    
    key matnr             : String(18) @title : 'Article Number';
    key un_hin           : String(24) @title : 'UN-Hazardous Identification Number';
        maktx             : String(40) @title : 'Article Description';
        rq               : Decimal(13) @title:'RQ';
        meinh             : String(3) @title : 'UOM';
        rq_tech_name     : String(255) @title : 'RQ Tech Name';
        ship_name        : String(255) @title : 'Proper Shipping Name';
        tech_name        : String(255) @title : 'Technical Name 1';
        tech_name_2      : String(255) @title : 'Technical Name 2';
        tech_name_3      : String(255) @title : 'Technical Name 3';
        hazclass         : String(5) @title : 'Hazard Class';
        hazclass1        : String(5) @title : 'Hazard Subclass';
        hazclass2        : String(5) @title : 'Hazard Subclass 2';
        pck_grp          : String(24) @title : 'Packing Group';
        basc_desc        : String(255) @title : 'Basic Description';
        mar_pollu        : String(1) @title : 'Marine Pollutants';
        mar_name         : String(255) @title : 'Marine Pollutant Name';
        waste_code       : String(25) @title : 'EPA Waste Code';
        ltd_qty          : Decimal(13,3) @title:'Threshold QTY';
        ltd_meinh        : String(3) @title : 'LTD QTY UOM';
        li_batt          : String(1) @title : 'Lithium Battery';
        erdat             : Date @title : 'Effective From Date'; 
        
        haz_flag         : String(1)  @mandatory @title : 'Hazmat Flag' ;
        un_hin_imdg      : String(24) @title : 'UN  Haz Identification Num';
        ship_name_imdg   : String(400) @title : 'Proper Shipping Name(IMDG)';
        tech_name_imdg   : String(255) @title : 'Technical Name 1(IMDG)';
        tech_name_2_imdg : String(255) @title : 'Technical Name 2 (IMDG)';
        tech_name_3_imdg : String(255) @title : 'Technical Name 3 (IMDG)';
        hazclass_imdg    : String(50) @title : 'Hazard Class (IMDG)';
        hazclass1_imdg   : String(50) @title : 'Hazard Subclass (IMDG)';
        hazclass2_imdg   : String(50) @title : 'Hazard Subclass2 (IMDG)';
        pck_grp_imdg     : String(24) @title : 'Packing Group (IMDG)';
        basc_desc_imdg   : String(255) @title : 'Basic Description (IMDG)';
        ltd_qty_imdg     : Decimal(13,3) @title : 'Threshold Qty(IMDG)';
        ltd_meinh_imdg   : String(3) @title : 'Ltd Qty UM(IMDG)';
        flash_pt         : Decimal(11,4) @title:'Flash Point in C (IMDG)';
        vessel           : String(50) @title : 'Vessel Storage(IMDG)';
        haz_flag_imdg    : String(1) @mandatory @title : 'Hazmat Flag(IMDG)';
        ocean_travel     : String(1) @mandatory  @title : 'Ocean Travel Status';


}

entity Haz_Tran_3E_Hist :managed {

    key matnr             : String(18);
    key un_hin           : String(24);
    key enddate           : Date;
        maktx             : String(40);
        rq               : Decimal(13);
        meinh             : String(3);
        rq_tech_name     : String(255);
        ship_name        : String(255);
        tech_name        : String(255);
        tech_name_2      : String(255);
        tech_name_3      : String(255);
        hazclass         : String(5);
        hazclass1        : String(5);
        hazclass2        : String(5);
        pck_grp          : String(24);
        basc_desc        : String(255);
        mar_pollu        : String(1);
        mar_name         : String(255);
        waste_code       : String(25);
        ltd_qty          : Decimal(13,3);
        ltd_meinh        : String(3);
        li_batt          : String(1);
        erdat             : Date;
        haz_flag         : String(1);
        un_hin_imdg      : String(24);
        ship_name_imdg   : String(400);
        tech_name_imdg   : String(255);
        tech_name_2_imdg : String(255);
        tech_name_3_imdg : String(255);
        hazclass_imdg    : String(50);
        hazclass1_imdg   : String(50);
        hazclass2_imdg   : String(50);
        pck_grp_imdg     : String(24);
        basc_desc_imdg   : String(255);
        ltd_qty_imdg     : Decimal(13,3);
        ltd_meinh_imdg   : String(3);
        flash_pt         : Decimal(11,4);
        vessel           : String(50);
        haz_flag_imdg    : String(1);
        ocean_travel     : String(1);


}

entity Un_Num_3E: managed {

    key un_hin       : String(24);
        ocean_travel : String(1) @mandatory;
        
}

entity Dispo_3E {
      key werks       : String(4) @title: 'Site';
    key scan_date   : Date @title: 'Scan Date';
    key scan_time   : Time @title: 'Scan Time';
    key uname       : String(12) @title: 'User Name';
    key matnr       : String(18) @title: 'Article Number';
        hazType     : String(20) @title: 'Nature of hazardous waste';
        scan_bin    : String(8) @title: 'Hazardous Waste Scan Bin';
        lp          : String(20) @title: 'Storage Unit Number';
        found_on_3e : String(1) @title: 'Found on 3E file indicator';
        reclamation : String(1) @title: 'Reclamation article indicator';
        leaking     : String(1) @title: 'Article leaking indicator';
}
entity HazTypes_3E : managed {
    key hazType: String(20) @title: 'Haz Waste Type';
    scan_bin: String(8) @assert.notNull @mandatory @title: 'Haz Bin';
}

entity disposition_Decision_matrix {
 key   MaterialIsHaz : String(10);
 key   MaterialIsLeak: String(10);
 key   MaterialIsReclam: String(10);
    HazType         : String(100);
    Container       : String(100);
    IsContainerRequired: String(30);
    
}

type   Article {
        article     : String(18);
        description : String(40);
        returnDisposition: String(60);
        hazType     : String(20);
        scan_bin    : String(8);
        Message     : String(500);
    }
