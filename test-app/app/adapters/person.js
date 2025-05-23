import Adapter from '@ember-data/adapter';
import { inject as service } from '@ember/service';
export default class LocalAdapter extends Adapter {
  @service createData;

  async query(store, type, query) {
    return this.createData.queryPeople(query);
  }
}
