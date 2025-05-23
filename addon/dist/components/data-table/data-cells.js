
import { template } from '@ember/template-compiler';
import Component from '@glimmer/component';
import '@ember/helper';
import './data-cell.js';

var _DataTableDataCellsComponent;
/* Used in: data-table/row */
class DataTableDataCellsComponent extends Component {
  get firstColumnField() {
    return this.args.fields?.[0] || null;
  }
  get otherColumnFields() {
    if (this.args.fields?.length) {
      let [, ...fields] = this.args.fields;
      return fields;
    } else {
      return [];
    }
  }
}
_DataTableDataCellsComponent = DataTableDataCellsComponent;
template(`
    {{yield
      (hash
        firstColumnField=this.firstColumnField
        otherColumnFields=this.otherColumnFields
        item=@item
        rowLink=@rowLink
        rowLinkModel=@rowLinkModel
        rowClicked=@rowClicked
        fields=@fields
        DataCell=(component
          DataTableDataCell
          firstColumnField=this.firstColumnField
          otherColumnFields=this.otherColumnFields
          item=@item
          rowLink=@rowLink
          rowLinkModel=@rowLinkModel
          rowClicked=@rowClicked
          fields=@fields
        )
      )
    }}
  `, {
  component: _DataTableDataCellsComponent,
  eval() {
    return eval(arguments[0]);
  }
});

export { DataTableDataCellsComponent as default };
//# sourceMappingURL=data-cells.js.map
