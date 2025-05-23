import { action } from '@ember/object';
import { cancel, debounce } from '@ember/runloop';
import Component from '@glimmer/component';
import { hash } from '@ember/helper';

/* Used in: data-table.hbs */
export default class TextSearchComponent extends Component {
  <template>
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
  </template>
  enteredValue = undefined;

  autoDebouncePid = undefined;

  @action
  handleAutoInput(event) {
    this.enteredValue = event.target.value;
    this.autoDebouncePid = debounce(
      this,
      this.submitCurrent,
      this.args.searchDebounceTime,
    );
  }

  @action
  handleInput(event) {
    this.enteredValue = event.target.value;
    if (this.args.autoSearch !== false) {
      this.autoDebouncePid = debounce(
        this,
        this.submitCurrent,
        this.args.searchDebounceTime,
      );
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

  @action
  handleDirectInput(event) {
    this.enteredValue = event.target.value;
  }

  @action
  submitForm(event) {
    event.preventDefault();
    this.submitCurrent();
  }
}
