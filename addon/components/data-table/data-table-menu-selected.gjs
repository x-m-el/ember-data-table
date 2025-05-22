import Component from '@glimmer/component';

export default class DataTableMenuSelectedComponent extends Component {
  get selectionCount() {
    return this.args.dataTable.selection.length;
  }

  get copiedSelection() {
    return [...this.args.dataTable.selection];
  }
}

{{!-- Used in: data-table/data-table-menu --}}
{{yield (hash
    selectionIsEmpty=@dataTable.selectionIsEmpty
    selectionCount=@dataTable.selection.length
    clearSelection=@dataTable.clearSelection
    selection=this.copiedSelection
    dataTable=@dataTable)}}

{{!-- TODO: must we pass the data table itself?  It is shared with the consumers. --}}