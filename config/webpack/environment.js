const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')

environment.plugins.prepend('jquery', jquery)

const yamlLoader = {
  test: /\.ya?ml$/, 
  type: 'json', // Required by Webpack v4
  use: 'yaml-loader'
}
environment.loaders.append('yaml', yamlLoader)

module.exports = environment
