# --------------------------------------
# Test for StartupContexts (./contexts/startup)
# --------------------------------------
require '../globals'
assert = require('assert')
Target = require('../../src/components/index')


describe 'ComponentHelper', () ->
  it '#get', () ->
    component = Target.findFromTemplate('common/BootstrapFooter')
    assert.ok true  # stub
