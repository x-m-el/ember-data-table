import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from '../../../app/components/raw-data-table.gjs';

module('Integration | Component | data table menu', function (hooks) {
  setupRenderingTest(hooks);
  test('it renders', async function (assert) {
    await render(<template><RawDataTable /></template>);

    assert
      .dom('.data-table-menu')
      .exists({ count: 1 }, 'Menu container exists');

    // Template block usage:
    await render(
      <template>
        <RawDataTable>
          <:menu>
            template block text
          </:menu>
        </RawDataTable>
      </template>,
    );

    assert.dom('.raw-data-table').containsText('template block text');
  });
});
