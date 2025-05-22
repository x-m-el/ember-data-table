import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | data table', function (hooks) {
  setupRenderingTest(hooks);
  test('it renders', async function (assert) {
    this.set('content', []);
    this.set('meta', {
      pagination: {
        first: { number: 1 },
        last: { number: 10 },
      },
    });

    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @meta={{this.meta}}
        @sizes=""
      />
    `);

    assert.dom('.raw-data-table').exists({ count: 1 }, 'renders a data table');
    assert.dom('.raw-data-table .data-table-content').exists({ count: 1 }, 'renders table inside content container');
  });
});
