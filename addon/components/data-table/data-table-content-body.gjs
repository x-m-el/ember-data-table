import { action } from '@ember/object';
import Component from '@glimmer/component';

export default class DataTableContentBodyComponent extends Component {

  get offset() {
    var offset = 1; //to avoid having 0. row
    var page = this.args.dataTable.page; // TODO: pass on page directly?
    var size = this.args.dataTable.size; // TODO: pass on size directly?
    if (page && size) {
      offset += page * size;
    }
    return offset;
  }

  @action
  updateSelection(item, event) {
    if( event.target.checked )
      this.args.dataTable.addItemToSelection(item);
    else
      this.args.dataTable.removeItemFromSelection(item);
  }
}
