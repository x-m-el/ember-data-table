import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import Row from '../../../../app/components/data-table/row.js';

module('Integration | Component | data-table/row', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const self = this;
    this.set('onClickRow', () => undefined);
    this.set('toggleSelected', () => undefined);

    await render(
      <template>
        <Row
          @onClickRow={{self.onClickRow}}
          @toggleSelected={{self.toggleSelected}}
        />
      </template>,
    );

    assert.dom(this.element).hasText('');

    // Template block usage:
    await render(
      <template>
        <Row
          @onClickRow={{self.onClickRow}}
          @toggleSelected={{self.toggleSelected}}
        >
          template block text
        </Row>
      </template>,
    );

    assert.dom(this.element).hasText('template block text');
  });
});
