window.addEventListener('DOMContentLoaded', event => {
    // Simple-DataTables
    // https://github.com/fiduswriter/Simple-DataTables/wiki

    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple);
    }
    
    const datatablesSimple2 = document.getElementById('datatablesSimple2');
    if (datatablesSimple2) {
        new simpleDatatables.DataTable(datatablesSimple2);
    }
    
    const datatablesSimple0 = document.getElementById('datatablesSimple0');
    if (datatablesSimple0) {
        new simpleDatatables.DataTable(datatablesSimple0,{
         	labels: {
            	  placeholder: "검색",
                  searchTitle: "검색",
                  pageTitle: "Page {page}",
                  perPage: "",
                  noRows: "선택된 거래처가 없습니다.",
                  info: "",
                  noResults: "검색결과가 없습니다",
              }   
        });
    }
    
    const nctBbs1 = document.getElementById('datatablesSimple-nctBbs1');
    if (nctBbs1) {
        new simpleDatatables.DataTable(nctBbs1,{
        	perPage: 5,
         	labels: {
            	  placeholder: "검색",
                  searchTitle: "검색",
                  pageTitle: "Page {page}",
                  perPage: "",
                  noRows: "선택된 거래처가 없습니다.",
                  info: "",
                  noResults: "검색결과가 없습니다",
              }   
        });
    }
});
