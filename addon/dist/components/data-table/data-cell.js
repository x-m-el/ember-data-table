
import { template } from '@ember/template-compiler';
import Component from '@glimmer/component';
import '@ember/helper';

var _DataTableDataCellComponent;
/* Used in: data-table/data-cells */
class DataTableDataCellComponent extends Component {
  get isCustom() {
    return this.args.column.isCustom;
  }
  get hasCustomFields() {
    return this.args.fields.find(({
      isCustom
    }) => isCustom) || false;
  }
  get renderCustomBlock() {
    return this.args.hasCustomBlock && (this.isCustom || !this.hasCustomFields);
  }
}
_DataTableDataCellComponent = DataTableDataCellComponent;
template(`
    {{yield
      (hash
        firstColumnField=@firstColumnField
        otherColumnFields=@otherColumnFields
        item=@item
        rowLink=@rowLink
        rowLinkModel=@rowLinkModel
        rowClicked=@rowClicked
        label=@column.label
        fields=@fields
        isCustom=this.isCustom
        hasCustomFields=this.hasCustomFields
        attribute=@column.attribute
        renderCustomBlock=this.renderCustomBlock
        value=(get @item @column.attribute)
      )
    }}
  `, {
  component: _DataTableDataCellComponent,
  eval() {
    return eval(arguments[0]);
  }
});

export { DataTableDataCellComponent as default };
//# sourceMappingURL=data-cell.js.map
