import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | number pagination', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    this.set('page', 0);
    this.set('meta', {
      pagination: {
        first: { number: 1 },
        last: { number: 10 },
      },
    });

    await render(hbs`
      <RawDataTable
        @page={{this.page}}
        @meta={{this.meta}}
      />
    `);

    assert.dom('.raw-data-table .data-table-pagination').exists({ count: 1 });
  });
});
