import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from '../../../app/components/raw-data-table.gjs';
import { fn } from '@ember/helper';

module('Integration | Component | text search', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders by default', async function (assert) {
    const self = this;

    this.set('filter', '');
    await render(
      <template>
        <RawDataTable
          @filter={{self.filter}}
          @updateFilter={{fn (mut self.filter)}}
        />
      </template>,
    );
    assert.dom('.raw-data-table .data-table-search').exists({ count: 1 });
  });

  test('it does not render if filter is not set', async function (assert) {
    await render(<template><RawDataTable /></template>);
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });

  test('it does not render if enableSearch is false', async function (assert) {
    const self = this;

    this.set('filter', '');
    await render(
      <template>
        <RawDataTable
          @enableSearch={{false}}
          @filter={{self.filter}}
          @updateFilter={{fn (mut self.filter)}}
        />
      </template>,
    );
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });
});
