import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | data table menu', function (hooks) {
  setupRenderingTest(hooks);
  test('it renders', async function (assert) {
    await render(hbs`<RawDataTable />`);

    assert.dom('.data-table-menu').exists({ count: 1 }, 'Menu container exists');

    // Template block usage:
    await render(hbs`
      <RawDataTable>
        <:menu>
          template block text
        </:menu>
      </RawDataTable>
    `);

    assert.dom('.raw-data-table').containsText('template block text');
  });
});
