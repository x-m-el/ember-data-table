
import { template } from '@ember/template-compiler';
import Component from '@glimmer/component';
import '@ember/helper';

var _DataTableMenuSelectedComponent;
/* Used in: data-table/data-table-menu */
class DataTableMenuSelectedComponent extends Component {
  get selectionCount() {
    return this.args.dataTable.selection.length;
  }
  get copiedSelection() {
    return [...this.args.dataTable.selection];
  }
}
_DataTableMenuSelectedComponent = DataTableMenuSelectedComponent;
template(`
    {{yield
      (hash
        selectionIsEmpty=@dataTable.selectionIsEmpty
        selectionCount=@dataTable.selection.length
        clearSelection=@dataTable.clearSelection
        selection=this.copiedSelection
        dataTable=@dataTable
      )
    }}

    {{! TODO: must we pass the data table itself?  It is shared with the consumers. }}
  `, {
  component: _DataTableMenuSelectedComponent,
  eval() {
    return eval(arguments[0]);
  }
});

export { DataTableMenuSelectedComponent as default };
//# sourceMappingURL=data-table-menu-selected.js.map
