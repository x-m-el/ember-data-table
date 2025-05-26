import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';

module('Integration | Component | number pagination', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const self = this;

    this.set('page', 0);
    this.set('meta', {
      pagination: {
        first: { number: 1 },
        last: { number: 10 },
      },
    });

    await render(
      <template>
        <RawDataTable @page={{self.page}} @meta={{self.meta}} />
      </template>,
    );

    assert.dom('.raw-data-table .data-table-pagination').exists({ count: 1 });
  });
});
