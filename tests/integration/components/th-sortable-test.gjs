import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from '../../../app/components/raw-data-table.js';

module('Integration | Component | th sortable', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const self = this;

    this.set('fields', ['title']);
    this.set('sortableFields', ['title']);

    await render(
      <template>
        <RawDataTable
          @fields={{self.fields}}
          @sortableFields={{self.sortableFields}}
        />
      </template>,
    );

    assert.dom('.data-table .sortable').exists({ count: 1 });
  });
});
