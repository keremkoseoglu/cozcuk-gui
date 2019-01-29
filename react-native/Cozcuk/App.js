/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {createBottomTabNavigator, createAppContainer, createStackNavigator} from 'react-navigation';

import Oyun from './Oyun';
import Ayar from './Ayar';

const TabNavigator = createBottomTabNavigator({
    Oyun: {screen: Oyun},
    Ayarlar: {screen: Ayar}
})

const StackNavigator = createStackNavigator({
    MyTab: {
        screen: TabNavigator,
        navigationOptions: {
            title: "Çözcük",
            headerTitleStyle: {fontWeight: "bold"}
        }
    }
})

const App = createAppContainer(StackNavigator);
export default App;

