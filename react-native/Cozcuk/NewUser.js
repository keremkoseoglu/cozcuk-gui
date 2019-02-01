import React, {Component} from "react";
import {View, Alert, AsyncStorage} from "react-native";
import styles from "./styles";
import {Button, FormInput, FormLabel, Text} from 'react-native-elements'

export default class NewUser extends Component {

    constructor(props) {
        super(props);
        this.state = {
            username: '',
            password: '',
            password2: '',
            email: '',
            url: ''
        };
    }

    alert(title, text) {

        Alert.alert(
            title,
            text,
            [
                {text: 'OK', onPress: () => console.log('OK Pressed')},
            ],
            {cancelable: false},
        );

    }

    onPressSave = () => {

        if (!this.validate_form()) return;

        AsyncStorage.getItem('url', (err, result) => {
                this.setState({url: result});
            }
        )
            .then(() => {

                let url = this.state.url + '/json/add_user';

                console.log(url);

                fetch(url, {
                    method: 'POST',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json',
                    }
                })
                    .then((response) => response.json())
                    .then(responseJson => {

                        var alertText = "";

                        if (responseJson.success === 'True') {
                            AsyncStorage.setItem('username', this.state.username, () => {
                            });
                            AsyncStorage.setItem('password', this.state.password, () => {
                            });

                            alertText = 'Kayıt başarılı, giriş yapabilirsiniz';
                        } else {
                            alertText = 'Kayıt hatası: ' + responseJson.error;
                        }

                        this.alert('Sonuç', alertText);
                    })
                    .catch((error) => {
                        console.error(error);
                        this.alert('Sonuç', 'Kullanıcı kaydında bir hata oluştu');
                    });
            });


    };

    validate_form() {
        if (this.state.username === '') {
            this.alert('Hata', 'Kullanıcı adını girin');
            return false;
        }

        if (this.state.password === '') {
            this.alert('Hata', 'Parola girin');
            return false;
        }

        if (this.state.password != this.state.password2) {
            this.alert('Hata', 'Şifreler aynı olmalıdır');
            return false;
        }

        if (this.state.email === '') {
            this.alert('Hata', 'E-Posta girin');
            return false;
        }

        return true;
    };

    render() {
        return <View style={styles.form}>
            <Text h4>Yeni kullanıcı</Text>
            <FormLabel>Kullanıcı adı</FormLabel>
            <FormInput placeholder={this.state.username} onChangeText={(text) => this.setState({username: text})}
                       value={this.state.username}/>
            <Text>&nbsp;</Text>
            <FormLabel>Şifre</FormLabel>
            <FormInput secureTextEntry={true} placeholder='***' onChangeText={(text) => this.setState({password: text})}
                       value={this.state.password}/>
            <Text>&nbsp;</Text>
            <FormLabel>Şifre (tekrar)</FormLabel>
            <FormInput secureTextEntry={true} placeholder='***'
                       onChangeText={(text) => this.setState({password2: text})}
                       value={this.state.password2}/>
            <Text>&nbsp;</Text>
            <FormLabel>E-Posta</FormLabel>
            <FormInput placeholder={this.state.email} onChangeText={(text) => this.setState({email: text})}
                       value={this.state.email}/>
            <Text>&nbsp;</Text>
            <Button title='Kaydet' onPress={this.onPressSave}/>
        </View>;
    }
}