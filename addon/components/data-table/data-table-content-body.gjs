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

{{!-- Used in: data-table/data-table-content --}}
{{yield (hash
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
    Row=(component "data-table/row"
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
      toggleSelected=this.updateSelection))}}
