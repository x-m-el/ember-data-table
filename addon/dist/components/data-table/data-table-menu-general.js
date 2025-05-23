
import { template } from '@ember/template-compiler';
import { hash } from '@ember/helper';

hash();
/* Used in: data-table/data-table-menu */
var dataTableMenuGeneral = template(`
  {{yield
    (hash dataTable=@dataTable selectionIsEmpty=@dataTable.selectionIsEmpty)
  }}
`, {
  eval() {
    return eval(arguments[0]);
  }
});

export { dataTableMenuGeneral as default };
//# sourceMappingURL=data-table-menu-general.js.map
