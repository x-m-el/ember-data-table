import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import { isEmpty } from '@ember/utils';
import Component from '@glimmer/component';
import { typeOf } from '@ember/utils';
import {
  toComponentSpecifications,
  definitionsToArray,
} from '../utils/string-specification-helpers';
import attributeToSortParams from '../utils/attribute-to-sort-params';
import get from '../utils/get';
import { hash } from '@ember/helper';
import DataTableTextSearch from './data-table/text-search.js';
import DataTableDataTableContent from './data-table/data-table-content.js';
import DataTableNumberPagination from './data-table/number-pagination.js';
import DataTableDataTableMenu from './data-table/data-table-menu.js';

const DEFAULT_DEBOUNCE_TIME = 2000;
export default class DataTable extends Component {
  <template>
    {{! TODO: supply both meta and @content.meta or supply @content.meta only when @meta is not supplied to be in line with readme }}

    {{yield
      (hash
        Search=(component
          DataTableTextSearch
          filter=this.filter
          placeholder=this.searchPlaceholder
          autoSearch=this.autoSearch
          updateFilter=this.updateFilter
          searchDebounceTime=this.searchDebounceTime
        )
        Content=(component
          DataTableDataTableContent
          content=@content
          noDataMessage=this.noDataMessage
          enableSelection=@enableSelection
          selectionProperty=@selectionProperty
          enableLineNumbers=@enableLineNumbers
          onClickRow=@onClickRow
          sort=this.sort
          updateSort=this.updateSort
          customHeaders=this.customHeaders
          fields=this.fields
          links=@links
          linksModelProperty=this.linksModelProperty
          rowLink=@rowLink
          rowLinkModelProperty=this.rowLinkModelProperty
          dataTable=this
        )
        Pagination=(component
          DataTableNumberPagination
          page=this.page
          size=this.size
          itemsOnCurrentPage=@content.length
          sizeOptions=this.sizeOptions
          total=@total
          meta=@content.meta
          updatePage=this.updatePage
          updateSize=this.updatePageSize
          backendPageOffset=@backendPageOffset
        )
        Menu=(component
          DataTableDataTableMenu enableSelection=@enableSelection dataTable=this
        )
        content=@content
        enableSearch=this.enableSearch
        dataTable=this
      )
    }}
  </template>
  @tracked _selection = undefined;

  get filter() {
    return this.args.filter;
  }

  get sort() {
    return this.args.sort;
  }

  get selection() {
    if (
      this._selection === undefined &&
      this.args.initialSelection === undefined
    )
      return [];
    else if (this._selection !== undefined) return this._selection;
    else return this.args.initialSelection;
  }

  set selection(newSelection) {
    this._selection = newSelection; // also triggers dependent properties
  }

  get noDataMessage() {
    return this.args.noDataMessage === undefined
      ? 'No data'
      : this.args.noDataMessage;
  }

  get isLoading() {
    return this.args.isLoading;
  }

  /**
   * Calculates the search debounce time.
   *
   * A shorthand form is supported in which the user supplies a
   * number to autoSearch in which case we use that.  This would not
   * work with 0 (which is a strange debounce time in itself) so this
   * option exists for now.
   */
  get searchDebounceTime() {
    return isNaN(this.args.autoSearch)
      ? DEFAULT_DEBOUNCE_TIME
      : this.args.autoSearch;
  }

  get enableSelection() {
    return this.args.enableSelection;
  }

  get selectionIsEmpty() {
    return this.selection.length === 0;
  }

  get page() {
    return this.args.page || 0;
  }

  get size() {
    return this.args.size || 5;
  }

  get sizeOptions() {
    const sizeOptions =
      this.args.sizes === undefined
        ? [5, 10, 25, 50, 100]
        : definitionsToArray(this.args.sizes).map((nrOrStr) =>
            parseInt(nrOrStr),
          );
    if (isEmpty(sizeOptions)) {
      return null;
    } else {
      if (!sizeOptions.includes(this.size) && this.size) {
        sizeOptions.push(this.size);
      }
      sizeOptions.sort((a, b) => a - b);
      return sizeOptions;
    }
  }

  get enableSearch() {
    return this.args.enableSearch === undefined
      ? this.filter !== undefined
      : this.args.enableSearch;
  }

  get autoSearch() {
    return this.args.autoSearch === undefined ? true : this.args.autoSearch;
  }

  get linksModelProperty() {
    return this.args.linksModelProperty === undefined
      ? 'id'
      : this.args.linksModelProperty;
  }

  get rowLinkModelProperty() {
    return this.args.rowLinkModelProperty === undefined
      ? 'id'
      : this.args.rowLinkModelProperty;
  }

  get fieldsWithMeta() {
    return toComponentSpecifications(this.args.fields, [
      { raw: 'attribute' },
      { name: 'label', default: 'attribute' },
    ]);
  }

  attributeToSortParams(attribute) {
    if (this.args.attributeToSortParams) {
      return this.args.attributeToSortParams(attribute);
    } else {
      return attributeToSortParams(attribute);
    }
  }

  get fields() {
    return this.fieldsWithMeta.map(
      ({
        attribute,
        label,
        isSortable,
        hasCustomHeader,
        isCustom,
        sortParameters,
      }) => ({
        attribute,
        label,
        sortParameters:
          sortParameters || // custom format says it's sortable
          ((isSortable || // custom format says it's sortable
            this.sortableFields === null || // default: all fields are sortable
            this.sortableFields?.includes(attribute)) && // @sortableFields
            this.attributeToSortParams(attribute)),
        get isSortable() {
          return Object.keys(this.sortParameters || {}).length >= 1;
        },
        hasCustomHeader:
          hasCustomHeader || this.customHeaders.includes(attribute),
        isCustom: isCustom || this.customFields.includes(attribute),
        customFieldComponent: this.customFieldComponents[attribute] || null,
        customHeaderComponent: this.customHeaderComponents[attribute] || null,
      }),
    );
  }

  get customHeaders() {
    const headers = this.args.customHeaders;
    if (typeOf(headers) === 'object') {
      return Object.keys(headers).filter((attr) => isEmpty(headers[attr]));
    } else {
      return definitionsToArray(headers);
    }
  }

  get customFields() {
    const fields = this.args.customFields;
    if (typeOf(fields) === 'object') {
      return Object.keys(fields).filter((attr) => isEmpty(fields[attr]));
    } else {
      return definitionsToArray(fields);
    }
  }

  get customFieldComponents() {
    const fields = this.args.customFields;
    return typeOf(fields) === 'object' ? fields : {};
  }

  get customHeaderComponents() {
    const headers = this.args.customHeaders;
    return typeOf(headers) === 'object' ? headers : {};
  }

  get sortableFields() {
    const sortableFields = this.args.sortableFields;
    if (sortableFields || sortableFields === '')
      return definitionsToArray(sortableFields);
    // default: all fields are sortable
    else return null;
  }

  get searchPlaceholder() {
    return this.args.searchPlaceholder === undefined
      ? 'Search input'
      : this.args.searchPlaceholder;
  }

  @action
  updatePageSize(size) {
    const updater = this.args.updatePageSize;
    if (!updater) {
      console.error(
        `Could not update page size to ${size} because @updatePageSize was not supplied to data table`,
      );
    } else {
      this.updatePage(0);
      updater(size);
    }
  }

  @action
  updateFilter(filter) {
    const updater = this.args.updateFilter;

    if (!updater) {
      console.error(
        `Could not update filter to '${filter}' because @updateFilter was not supplied to data table`,
      );
    } else {
      this.updatePage(0);
      updater(filter);
    }
  }

  @action
  updateSort(sort) {
    const updater = this.args.updateSort;
    if (!updater) {
      console.error(
        `Could not update sorting to '${sort}' because @updateSort was not supplied to data table`,
      );
    } else {
      this.updatePage(0);
      updater(sort);
    }
  }

  @action
  updatePage(page) {
    const updater = this.args.updatePage;
    if (!updater) {
      console.error(
        `Could not update page to ${page} because @updatePage was not supplied to data table`,
      );
    } else {
      updater(page);
    }
  }

  @action
  addItemToSelection(item) {
    this.removeItemFromSelection(item); // in case the item was already selected
    this.selection = [...this.selection, item]; // create new array to trigger setter if `selection`
  }
  @action
  removeItemFromSelection(item) {
    const byPath = this.args.selectionProperty;
    this.selection = this.selection.filter(
      (x) => get(x, byPath) !== get(item, byPath),
    );
  }
  @action
  clearSelection() {
    this.selection = [];
  }
}
