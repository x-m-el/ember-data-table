
import { template } from '@ember/template-compiler';
import './data-table-menu-general.js';
import './data-table-menu-selected.js';
import '@ember/helper';

/* Used in: data-table.hbs */
var dataTableMenu = template(`
  {{#let
    (component DataTableDataTableMenuGeneral dataTable=@dataTable)
    (component DataTableDataTableMenuSelected dataTable=@dataTable)
    as |general selected|
  }}
    {{yield
      (hash
        General=general
        Selected=selected
        enableSelection=@dataTable.enableSelection
      )
    }}
  {{/let}}
`, {
  eval() {
    return eval(arguments[0]);
  }
});

export { dataTableMenu as default };
//# sourceMappingURL=data-table-menu.js.map
