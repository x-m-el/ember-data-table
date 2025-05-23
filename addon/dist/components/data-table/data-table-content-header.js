
import { template } from '@ember/template-compiler';
import '@ember/helper';
import './th-sortable.js';

/* Used in: data-table/data-table-content */
var dataTableContentHeader = template(`
  {{yield
    (hash
      enableSelection=@enableSelection
      enableLineNumbers=@enableLineNumbers
      sort=@sort
      updateSort=@updateSort
      hasLinks=@hasLinks
      customHeaders=@customHeaders
      fields=@fields
      dataHeadersInfo=(hash
        fields=@fields
        customHeaders=@customHeaders
        sort=@sort
        updateSort=@updateSort
      )
      ThSortable=(component
        DataTableThSortable fields=@fields sort=@sort updateSort=@updateSort
      )
    )
  }}
`, {
  eval() {
    return eval(arguments[0]);
  }
});

export { dataTableContentHeader as default };
//# sourceMappingURL=data-table-content-header.js.map
