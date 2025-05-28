'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    sassOptions: {
      precision: 4,
      includePaths: [
        '../node_modules/ember-data-table/dist/styles',
      ],
    },
    'ember-cli-babel': {
      includePolyfill: true,
    },
    minifyCSS: {
      options: {
        advanced: false,
      },
    },
  });

  const { maybeEmbroider } = require('@embroider/test-setup');
  return maybeEmbroider(app, {
    skipBabel: [
      {
        package: 'qunit',
      },
    ],
  });
};
