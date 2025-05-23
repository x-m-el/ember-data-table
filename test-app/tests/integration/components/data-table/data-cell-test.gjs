import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import DataCell from '../../../../app/components/data-table/data-cell.gjs';

module('Integration | Component | data-table/data-cell', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><DataCell /></template>);

    assert.dom(this.element).hasText('');

    // Template block usage:
    await render(
      <template>
        <DataCell>
          template block text
        </DataCell>
      </template>,
    );

    assert.dom(this.element).hasText('template block text');
  });
});
