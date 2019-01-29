/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {createMaterialTopTabNavigator} from 'react-navigation';
import Ayarlar from './Ayarlar';
import Forgot from './Forgot';

const MyNavigator = createMaterialTopTabNavigator(
    {
        "Ayarlar": Ayarlar,
        "Yeni Şifre": Forgot,
        "Yeni Hesap": Forgot
    },
    {
        navigationOptions: ({navigation, screenProps}) => ({
            header: null,
            headerMode: 'none',
            tabBarVisible: true
        }),
        animationEnabled: false,
        swipeEnabled: true,
        tabBarOptions: {
            activeTintColor: 'rgb(12,157,197)',
            inactiveTintColor: 'black',
            indicatorStyle: {
                backgroundColor: 'rgb(102,134,205)',
            },
            labelStyle: {
                fontSize: 14,
                color: 'tomato',
            },
            tabStyle: {
                height: 48,
                alignItems: 'center',
                justifyContent: 'center',
            },
            style: {
                backgroundColor: 'white',
            },
            statusBarStyle: 'light-content',
        },
    },
);
type Props = {};
type State = {};

class Page extends React.Component<Props, State> {
    static router = MyNavigator.router;

    render() {
        return (
            <MyNavigator
                navigation={this.props.navigation}
            />
        );
    }
}

export default Page;

