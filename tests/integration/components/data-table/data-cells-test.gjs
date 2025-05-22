import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import DataCells from '../../../../app/components/data-table/data-cells.gjs';

module('Integration | Component | data-table/data-cells', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><DataCells /></template>);

    assert.dom(this.element).hasText('');

    // Template block usage:
    await render(
      <template>
        <DataCells>
          template block text
        </DataCells>
      </template>,
    );

    assert.dom(this.element).hasText('template block text');
  });
});
