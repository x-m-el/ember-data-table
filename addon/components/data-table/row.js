import { get } from '@ember/object';
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class DataTableRowComponent extends Component {
  @service router;

  get linkedRoutes() {
    return this.args.linkedRoutes.map( (linkedRoute) => {
      const model = this.args.item;
      return Object.assign( {
        model: linkedRoute.linksModelProperty
          ? get(model, linkedRoute.linksModelProperty)
          : model
      }, linkedRoute );
    } );
  }

  get rowLinkModel() {
    const { item, rowLinkModelProperty } = this.args;
    return rowLinkModelProperty
      ? get(item, rowLinkModelProperty)
      : item;
  }

  @action
  rowClicked() {
    if ( this.args.onClickRow ) {
      this.args.onClickRow(...arguments);
    } else if ( this.args.rowLink ) {
      this.router.transitionTo( this.args.rowLink, this.rowLinkModel );
    }
  }
}
