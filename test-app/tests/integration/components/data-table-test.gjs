import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';

module('Integration | Component | data table', function (hooks) {
  setupRenderingTest(hooks);
  test('it renders', async function (assert) {
    const self = this;

    this.set('content', []);
    this.set('meta', {
      pagination: {
        first: { number: 1 },
        last: { number: 10 },
      },
    });

    await render(
      <template>
        <RawDataTable @content={{self.content}} @meta={{self.meta}} @sizes='' />
      </template>,
    );

    assert.dom('.raw-data-table').exists({ count: 1 }, 'renders a data table');
    assert
      .dom('.raw-data-table .data-table-content')
      .exists({ count: 1 }, 'renders table inside content container');
  });
});
