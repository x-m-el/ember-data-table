
import { b as _defineProperty, a as _applyDecoratedDescriptor } from '../../_rollupPluginBabelHelpers-Cd88SXj0.js';
import { template } from '@ember/template-compiler';
import { action } from '@ember/object';
import { debounce, cancel } from '@ember/runloop';
import Component from '@glimmer/component';
import '@ember/helper';

var _class, _TextSearchComponent;
/* Used in: data-table.hbs */
let TextSearchComponent = (_class = (_TextSearchComponent = class TextSearchComponent extends Component {
  constructor(...args) {
    super(...args);
    _defineProperty(this, "enteredValue", undefined);
    _defineProperty(this, "autoDebouncePid", undefined);
  }
  handleAutoInput(event) {
    this.enteredValue = event.target.value;
    this.autoDebouncePid = debounce(this, this.submitCurrent, this.args.searchDebounceTime);
  }
  handleInput(event) {
    this.enteredValue = event.target.value;
    if (this.args.autoSearch !== false) {
      this.autoDebouncePid = debounce(this, this.submitCurrent, this.args.searchDebounceTime);
    }
  }
  submitCurrent() {
    if (!this.isDestroying && !this.isDestroyed) {
      this.args.updateFilter(this.enteredValue);
      this.autoDebouncePid = undefined;
    }
  }
  willDestroy() {
    super.willDestroy(...arguments);
    cancel(this.autoDebouncePid);
  }
  handleDirectInput(event) {
    this.enteredValue = event.target.value;
  }
  submitForm(event) {
    event.preventDefault();
    this.submitCurrent();
  }
}, template(`
    {{yield
      (hash
        filter=@filter
        placeholder=@placeholder
        autoSearch=@autoSearch
        submitForm=this.submitForm
        handleInput=this.handleInput
        handleAutoInput=this.handleAutoInput
        handleDirectInput=this.handleDirectInput
      )
    }}
  `, {
  component: _TextSearchComponent,
  eval() {
    return eval(arguments[0]);
  }
}), _TextSearchComponent), _applyDecoratedDescriptor(_class.prototype, "handleAutoInput", [action], Object.getOwnPropertyDescriptor(_class.prototype, "handleAutoInput"), _class.prototype), _applyDecoratedDescriptor(_class.prototype, "handleInput", [action], Object.getOwnPropertyDescriptor(_class.prototype, "handleInput"), _class.prototype), _applyDecoratedDescriptor(_class.prototype, "handleDirectInput", [action], Object.getOwnPropertyDescriptor(_class.prototype, "handleDirectInput"), _class.prototype), _applyDecoratedDescriptor(_class.prototype, "submitForm", [action], Object.getOwnPropertyDescriptor(_class.prototype, "submitForm"), _class.prototype), _class);

export { TextSearchComponent as default };
//# sourceMappingURL=text-search.js.map
