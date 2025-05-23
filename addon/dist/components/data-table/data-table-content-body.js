
import { a as _applyDecoratedDescriptor } from '../../_rollupPluginBabelHelpers-Cd88SXj0.js';
import { template } from '@ember/template-compiler';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import '@ember/helper';
import 'ember-truth-helpers/helpers/and';
import 'ember-truth-helpers/helpers/or';
import './row.js';

var _class, _DataTableContentBodyComponent;
/* Used in: data-table/data-table-content */
let DataTableContentBodyComponent = (_class = (_DataTableContentBodyComponent = class DataTableContentBodyComponent extends Component {
  get offset() {
    var offset = 1; //to avoid having 0. row
    var page = this.args.dataTable.page; // TODO: pass on page directly?
    var size = this.args.dataTable.size; // TODO: pass on size directly?
    if (page && size) {
      offset += page * size;
    }
    return offset;
  }
  updateSelection(item, event) {
    if (event.target.checked) this.args.dataTable.addItemToSelection(item);else this.args.dataTable.removeItemFromSelection(item);
  }
}, template(`
    {{yield
      (hash
        isLoading=@dataTable.isLoading
        content=@content
        offset=this.offset
        enableLineNumbers=@enableLineNumbers
        hasClickRowAction=(and (or @onClickRow @rowLink) true)
        toggleSelected=this.updateSelection
        selection=@dataTable.selection
        enableSelection=@enableSelection
        linkedRoutes=@linkedRoutes
        rowLink=@rowLink
        rowLinkModelProperty=@rowLinkModelProperty
        noDataMessage=@noDataMessage
        fields=@fields
        Row=(component
          DataTableRow
          dataTable=@dataTable
          enableLineNumbers=@enableLineNumbers
          enableSelection=@enableSelection
          selectionProperty=@selectionProperty
          selection=@dataTable.selection
          offset=this.offset
          hasClickRowAction=(and (or @onClickRow @rowLink) true)
          onClickRow=@onClickRow
          linkedRoutes=@linkedRoutes
          rowLink=@rowLink
          rowLinkModelProperty=@rowLinkModelProperty
          fields=@fields
          toggleSelected=this.updateSelection
        )
      )
    }}
  `, {
  component: _DataTableContentBodyComponent,
  eval() {
    return eval(arguments[0]);
  }
}), _DataTableContentBodyComponent), _applyDecoratedDescriptor(_class.prototype, "updateSelection", [action], Object.getOwnPropertyDescriptor(_class.prototype, "updateSelection"), _class.prototype), _class);

export { DataTableContentBodyComponent as default };
//# sourceMappingURL=data-table-content-body.js.map
