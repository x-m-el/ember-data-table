
import { template } from '@ember/template-compiler';
import Component from '@glimmer/component';
import { toComponentSpecifications } from '../../utils/string-specification-helpers.js';
import '@ember/helper';
import './data-table-content-header.js';
import './data-table-content-body.js';

var _DataTableContentComponent;
/* Used in: data-table.hbs */
class DataTableContentComponent extends Component {
  get hasLinks() {
    return this.linkedRoutes.length > 0;
  }
  /**
  * Accepts and transforms definitions for linked routes.
  *
  * Implementations may transform this at will.  The default
  * transformation splits on `:` assuming the first part is the route
  * and the second part is the label.  If no label is given, it is
  * passed as null.  If a label is given, all underscores are
  * transformed to spaces and double underscores are left as a single
  * _.  We split again on a third `:`, transforming in the same way for
  * the suggested icon.
  *
  * Behaviour for `___` is undefined.
  *
  * Can pass a space-separated string or an array.
  * The array can already contain an object with the transformed link
  *
  * Yields an array of objects to represent the linked routes.
  * [ { route: "products.show", label: "Show product", icon: "show-icon" } ]
  */
  get linkedRoutes() {
    return toComponentSpecifications(this.args.links || '', [{
      raw: 'route'
    }, 'label', 'icon']).map(spec => {
      spec.linksModelProperty = this.args.linksModelProperty;
      return spec;
    });
  }
}
_DataTableContentComponent = DataTableContentComponent;
template(`
    {{yield
      (hash
        Header=(component
          DataTableDataTableContentHeader
          enableSelection=@enableSelection
          enableLineNumbers=@enableLineNumbers
          sort=@sort
          updateSort=@updateSort
          hasLinks=this.hasLinks
          customHeaders=@customHeaders
          dataTable=@dataTable
          fields=@fields
        )
        Body=(component
          DataTableDataTableContentBody
          content=@content
          enableSelection=@enableSelection
          selectionProperty=@selectionProperty
          enableLineNumbers=@enableLineNumbers
          noDataMessage=@noDataMessage
          onClickRow=@onClickRow
          linkedRoutes=this.linkedRoutes
          rowLink=@rowLink
          rowLinkModelProperty=@rowLinkModelProperty
          dataTable=@dataTable
          fields=@fields
        )
        dataTable=@dataTable
      )
    }}
  `, {
  component: _DataTableContentComponent,
  eval() {
    return eval(arguments[0]);
  }
});

export { DataTableContentComponent as default };
//# sourceMappingURL=data-table-content.js.map
