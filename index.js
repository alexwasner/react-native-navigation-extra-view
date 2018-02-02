import { processColor, NativeModules, AppRegistry } from 'react-native';
import React, { Component } from 'react';
// import React from 'react'
import flattenArray from './js/flattenArray';
const _resolveAssetSource = require('react-native/Libraries/Image/resolveAssetSource');
const { RNNExtraView } = NativeModules;
const registeredViews = {};
const ExtraViewClass = {name: 'ExtraView'}

let ExtraView = {
	registerComponent(viewId, generator, store = undefined, Provider = undefined, options = {}){
		if (store && Provider) {
		  return _registerComponentWithStore(viewId, generator, store, Provider, options);
		} else {
		  return _registerComponentWithoutStore(viewId, generator);
		}
	},
	init(viewId){
		var controller = registeredViews[viewId];
		if (controller === undefined) return;
		RNNExtraView.createView(viewId,{})
	}
}


function _registerComponentWithoutStore(viewId, generator) {
  const generatorWrapper = ()=>{
    const InternalComponent = generator();
    if (!InternalComponent) {
      // console.error(`Navigation: ${viewId} registration result is 'undefined'`);
    }
    return class extends Component {
      render() {
        return (
          <InternalComponent {...this.props} />
        );
      }
    };
  };
  _registerScreen(viewId, generatorWrapper);
  return generatorWrapper;
}

function _registerComponentWithStore(viewId, generator, store, Provider, options) {
  const generatorWrapper = ()=>{
    const InternalComponent = generator();
    if (!InternalComponent) {
      console.error(`Navigation: ${viewId} registration result is 'undefined'`);
    }
    return class extends Component {
      render() {
        return (
          <Provider store={store} {...options}>
            <InternalComponent {...this.props}  pointerEvents='none'/>
          </Provider>
        );
      }
    };
  };
  _registerScreen(viewId, generatorWrapper);
  return generatorWrapper;
}

function _registerScreen(viewId, generator) {
	registeredViews[viewId] = generator;
	AppRegistry.registerComponent(viewId, generator);
}


export default ExtraView;
