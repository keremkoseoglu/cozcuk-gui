import {Alert, AsyncStorage, View} from "react-native";
import React, {Component} from "react";
import styles from './styles.js';
import {Button, FormLabel, FormInput, Text} from 'react-native-elements'

const DEFAULT_URL = 'https://cozcuk-server.herokuapp.com';

export default class Ayarlar extends Component {

    constructor(props) {
        super(props);

        this.state = {
            url: '',
            username: '',
            password: ''
        };

        this.load_values();

    }

    componentDidMount(): void {
        this.load_values();
        this.props.navigation.addListener('willFocus', this.load_values)
    }

    load_values = () => {
        AsyncStorage.getItem('url', (err, result) => {
                if (result === null) {
                    this.setState({url: DEFAULT_URL});
                } else {
                    this.setState({url: result});
                }
            }
        );

        AsyncStorage.getItem('username', (err, result) => {
            this.setState({username: result})
        });
        AsyncStorage.getItem('password', (err, result) => {
            this.setState({password: result})
        });
    }

    onPressSave = () => {

        AsyncStorage.setItem('url', this.state.url, () => {
        });
        AsyncStorage.setItem('username', this.state.username, () => {
        });
        AsyncStorage.setItem('password', this.state.password, () => {
        });

        Alert.alert(
            'Onay',
            'Değişiklikler kaydedildi',
            [
                {text: 'OK', onPress: () => console.log('OK Pressed')},
            ],
            {cancelable: false},
        );
    };

    render() {
        return (
            <View style={styles.form}>
                <Text h4>Ayarlar</Text>
                <FormLabel>Sunucu</FormLabel>
                <FormInput placeholder={this.state.url} onChangeText={(text) => this.setState({url: text})}
                           value={this.state.url}/>
                <FormLabel>Kullanıcı</FormLabel>
                <FormInput placeholder={this.state.username} onChangeText={(text) => this.setState({username: text})}
                           value={this.state.username}/>
                <FormLabel>Parola</FormLabel>
                <FormInput secureTextEntry={true} placeholder='***'
                           onChangeText={(text) => this.setState({password: text})} value={this.state.password}/>

                <Text>&nbsp;</Text>
                <Button title='Kaydet' onPress={this.onPressSave}/>
            </View>
        );
    }
}