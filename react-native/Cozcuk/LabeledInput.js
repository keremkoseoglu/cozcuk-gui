import {Text, TextInput, View} from "react-native";
import React, {Component} from "react";
import styles from './styles.js';

export default class LabeledInput extends Component {

  constructor(props) {
    super(props);
    this.state = { text_val: props.text_val };
  }

  render() {
    return (
    <View style={styles.labelTextForm} >
      <Text>{this.props.label_text}: </Text>
      <TextInput
          onChangeText={(text_val) => this.setState( {text_val: text_val})}
          value={this.state.text_val}
      />
    </View>
    );
  }
}