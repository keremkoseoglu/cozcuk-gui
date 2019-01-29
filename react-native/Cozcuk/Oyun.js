import {Alert, AsyncStorage, View} from "react-native";
import React, {Component} from "react";
import styles from './styles.js';
import {Button, FormInput, Text} from 'react-native-elements'

export default class Oyun extends Component {

    constructor(props) {
        super(props);
        this.state = {
            answer: '',
            hint: '',
            question: '',
            question_txt: '(yeni soru yükleyin)',
            url: '',
            username: '',
            password: '',
            status: ''
        };
    }

    async reload_settings() {
        this.setState({status: '❔'});
        await AsyncStorage.getItem('url', (err, result) => {
            this.setState({url: result})
        });
        await AsyncStorage.getItem('username', (err, result) => {
            this.setState({username: result})
        });
        await AsyncStorage.getItem('password', (err, result) => {
            this.setState({password: result})
        });
    }

    onPressAnswer = () => {

        let url = this.state.url + '/json/check_answer';

        fetch(url, {
            method: 'POST',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: this.state.username,
                password: this.state.password,
                question: this.state.question,
                answer: this.state.answer
            }),
        })
            .then((response) => response.json())
            .then(responseJson => {

                if (responseJson.error != null) {
                    Alert.alert(
                        'Onay', responseJson.error,
                        [
                            {text: 'OK', onPress: () => console.log('OK Pressed')},
                        ],
                        {cancelable: false},
                    );
                    return
                }

                if (responseJson.success === 'True') {
                    this.setState({status: '✅'});
                } else {
                    this.setState({status: '🔴'});
                }
            })
            .catch((error) => {
                console.error(error);
            });
    }

    onPressHint = () => {
        this.setState({question_txt: this.state.hint})
    }

    onPressLoad = () => {

        this.reload_settings().then(() => {

            let url = this.state.url + '/json/get_puzzle';

            this.setState({
                answer: '',
                hint: '',
                question: '',
                question_txt: ''
            });

            fetch(url, {
                method: 'POST',
                headers: {
                    Accept: 'application/json',
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    username: this.state.username,
                    password: this.state.password
                }),
            })
                .then((response) => response.json())
                .then(responseJson => {
                    this.setState({
                        question: responseJson.question,
                        question_txt: responseJson.question,
                        hint: responseJson.hint
                    })
                })
                .catch((error) => {
                    console.error(error);
                });

        });

    }

    render() {
        return <View style={styles.container}>
            <Text>{this.state.question_txt}</Text>
            <FormInput
                placeholder='Cevap'
                value={this.state.answer}
                onChangeText={(text) => this.setState({answer: text})}
            />
            <Text>&nbsp;</Text>
            <Text>{this.state.status}</Text>
            <Text>&nbsp;</Text>
            <View style={{flexDirection: 'row'}}>
                <Button title="Yeni soru" onPress={this.onPressLoad}/>
                <Button title="İpucu" onPress={this.onPressHint}/>
                <Button title="Gönder" onPress={this.onPressAnswer}/>
            </View>
        </View>;
    }
}