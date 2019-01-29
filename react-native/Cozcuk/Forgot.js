import React, {Component} from "react";
import {View, Alert, AsyncStorage} from "react-native";
import styles from "./styles";
import {Button, FormInput, FormLabel, Text} from 'react-native-elements'

export default class Forgot extends Component {

    constructor(props) {
        super(props);
        this.state = {
            username: '',
            url: ''
        };
    }

    onPressSave = () => {

        AsyncStorage.getItem('url', (err, result) => {
                this.setState({url: result});
            }
        )
            .then(() => {

                let url = this.state.url + '/json/forgot_pwd?uname=' + this.state.username;

                console.log(url);

                fetch(url, {
                    method: 'GET',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json',
                    }
                })
                    .then((response) => response.json())
                    .then(responseJson => {

                        var alertText = "";

                        if (responseJson.success === 'True') {
                            alertText = 'Yeni şifre talep edildi';
                        }
                        else {
                            alertText = 'Talep hatası: ' + responseJson.error;
                        }

                        Alert.alert(
                            'Onay',
                            alertText,
                            [
                                {text: 'OK', onPress: () => console.log('OK Pressed')},
                            ],
                            {cancelable: false},
                        );
                    })
                    .catch((error) => {
                        console.error(error);
                        Alert.alert(
                            'Onay',
                            'Yeni şifre talep edilirken bir hata oluştu',
                            [
                                {text: 'OK', onPress: () => console.log('OK Pressed')},
                            ],
                            {cancelable: false},
                        );
                    });
            });


    };

    render() {
        return <View style={styles.form}>
            <Text h4>Yeni şifre</Text>
            <FormLabel>Kullanıcı adı</FormLabel>
            <FormInput placeholder={this.state.username} onChangeText={(text) => this.setState({username: text})}
                       value={this.state.username}/>
            <Text>&nbsp;</Text>
            <Button title='Talep' onPress={this.onPressSave}/>
        </View>;
    }
}