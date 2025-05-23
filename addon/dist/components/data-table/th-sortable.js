
import { a as _applyDecoratedDescriptor } from '../../_rollupPluginBabelHelpers-Cd88SXj0.js';
import { template } from '@ember/template-compiler';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import '@ember/helper';

var _class, _ThSortableComponent;
/* Used in: data-table/data-table-content-header */
let ThSortableComponent = (_class = (_ThSortableComponent = class ThSortableComponent extends Component {
  get sortParameters() {
    return this.args.field.sortParameters;
  }
  get sortDirection() {
    for (const key in this.sortParameters) if (this.args.sort == this.sortParameters[key]) return key;
    return '';
  }
  get isAscending() {
    return this.sortDirection === 'asc';
  }
  get isDescending() {
    return this.sortDirection === 'desc';
  }
  get isSorted() {
    return this.sortDirection !== '';
  }
  get renderCustomBlock() {
    // render the custom block when this header is custom or when a
    // custom block was given and no specific headers were supplied to
    // be custom.
    //
    // Note: data table can't make this decision because it doesn't know
    // whether a custom block was supplied.
    return this.args.hasCustomBlock && (this.isCustom || !this.hasCustomHeaders);
  }
  get isCustom() {
    return this.args.field.hasCustomHeader;
  }
  get hasCustomHeaders() {
    return this.args.fields.find(({
      hasCustomHeader
    }) => hasCustomHeader) || false;
  }
  get availableSortOptions() {
    const options = [];
    Object.keys(this.sortParameters).sort() // for asc and desc, asc first then desc, the rest also sorted for now
    .map(key => options.push(key));
    options.push(''); // no sorting
    return options;
  }
  get nextSort() {
    // wrapping loop over availableSortOptions
    const opts = this.availableSortOptions;
    return opts[(opts.indexOf(this.sortDirection) + 1) % opts.length];
  }
  /**
  * Wraps around possible sorting directions.
  */
  toggleSort() {
    this.args.updateSort(this.sortParameters[this.nextSort]);
  }
}, template(`
    {{yield
      (hash
        label=@field.label
        attribute=@field.attribute
        isSortable=@field.isSortable
        isSorted=this.isSorted
        toggleSort=this.toggleSort
        nextSort=this.nextSort
        isAscending=this.isAscending
        isDescending=this.isDescending
        sortDirection=this.sortDirection
        renderCustomBlock=this.renderCustomBlock
        isCustom=this.isCustom
        hasCustom=this.hasCustom
      )
    }}
  `, {
  component: _ThSortableComponent,
  eval() {
    return eval(arguments[0]);
  }
}), _ThSortableComponent), _applyDecoratedDescriptor(_class.prototype, "toggleSort", [action], Object.getOwnPropertyDescriptor(_class.prototype, "toggleSort"), _class.prototype), _class);

export { ThSortableComponent as default };
//# sourceMappingURL=th-sortable.js.map
