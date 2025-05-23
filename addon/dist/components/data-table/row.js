
import { a as _applyDecoratedDescriptor, _ as _initializerDefineProperty } from '../../_rollupPluginBabelHelpers-Cd88SXj0.js';
import { template } from '@ember/template-compiler';
import { get as get$1, action } from '@ember/object';
import Component from '@glimmer/component';
import { service } from '@ember/service';
import '@ember/helper';
import 'ember-math-helpers/helpers/add';
import { helper } from '@ember/component/helper';
import get from '../../utils/get.js';
import './data-cells.js';

// todo: change to normal function helper, instead of separate function, in ember 4
function includesBy(array, obj, byPath) {
  const valueByPath = get(obj, byPath);
  return !!array.find(a => get(a, byPath) === valueByPath);
}
helper(function includesByHelper([array, obj, byPath]) {
  return includesBy(array, obj, byPath);
});

var _class, _descriptor, _DataTableRowComponent;
/* Used in: data-table/data-table-content-body */
let DataTableRowComponent = (_class = (_DataTableRowComponent = class DataTableRowComponent extends Component {
  constructor(...args) {
    super(...args);
    _initializerDefineProperty(this, "router", _descriptor, this);
  }
  get linkedRoutes() {
    return this.args.linkedRoutes.map(linkedRoute => {
      const model = this.args.item;
      return Object.assign({
        model: linkedRoute.linksModelProperty ? get$1(model, linkedRoute.linksModelProperty) : model
      }, linkedRoute);
    });
  }
  get rowLinkModel() {
    const {
      item,
      rowLinkModelProperty
    } = this.args;
    return rowLinkModelProperty ? get$1(item, rowLinkModelProperty) : item;
  }
  rowClicked() {
    if (this.args.onClickRow) {
      this.args.onClickRow(...arguments);
    } else if (this.args.rowLink) {
      this.router.transitionTo(this.args.rowLink, this.rowLinkModel);
    }
  }
}, template(`
    {{! @item and @index come from consumer's data-table.hbs implementation }}
    {{yield
      (hash
        item=@item
        enableLineNumbers=@enableLineNumbers
        lineNumber=(add @index @offset)
        enableSelection=@enableSelection
        isSelected=(includesBy @selection @item @selectionProperty)
        toggleSelected=(fn @toggleSelected @item)
        linkedRoutes=this.linkedRoutes
        rowLink=@rowLink
        rowLinkModel=this.rowLinkModel
        hasClickRowAction=@hasClickRowAction
        rowClicked=this.rowClicked
        fields=@fields
        DataCells=(component
          DataTableDataCells
          fields=@fields
          item=@item
          rowLink=@rowLink
          rowLinkModel=this.rowLinkModel
          rowClicked=this.rowClicked
          linkedRoutes=this.linkedRoutes
          dataTable=@dataTable
        )
      )
    }}
  `, {
  component: _DataTableRowComponent,
  eval() {
    return eval(arguments[0]);
  }
}), _DataTableRowComponent), _descriptor = _applyDecoratedDescriptor(_class.prototype, "router", [service], {
  configurable: true,
  enumerable: true,
  writable: true,
  initializer: null
}), _applyDecoratedDescriptor(_class.prototype, "rowClicked", [action], Object.getOwnPropertyDescriptor(_class.prototype, "rowClicked"), _class.prototype), _class);

export { DataTableRowComponent as default };
//# sourceMappingURL=row.js.map
