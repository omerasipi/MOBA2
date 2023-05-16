import * as React from 'react';
import {Button, View, StyleSheet, Text, SafeAreaView, TextInput} from 'react-native';
import {TypeAnimation} from 'react-type-animation';
import {useState} from "react";

const styles = StyleSheet.create({
    View: {
        flex: 1,
        alignSelf: 'center',
        alignItems: 'center',
        justifyContent: 'center',
        borderWidth: 1,
        borderColor: 'black',
        margin: 15,
        padding: 10,
        borderRadius: 10,
        width: '50%',
    },
    Text: {
        fontSize: 40,
        fontWeight: 'bold',
        margin: 15
    },
    TextInput: {
        height: 40,
        borderColor: 'gray',
        borderWidth: 1,
        margin: 15,
        padding: 10,
        fontWeight: '500',
        color: 'black',
    },
});

export function MainPage({navigation}) {
    const [textInputValue, setTextInputValue] = useState('');
    const onChangeText = (text) => {
        setTextInputValue(text);
    };

    return (
        <SafeAreaView>
            <View style={styles.View}>
                <Text style={styles.Text}>Check the Weather in <TypeAnimation
                    sequence={[
                        'Zürich', 1000,
                        'Bern', 1000,
                        'Basel', 1000,
                        'Geneva', 1000,
                        'Lausanne', 1000,
                        'Winterthur', 1000,
                        'St. Gallen', 1000,
                        'Lugano', 1000,
                        'Biel/Bienne', 1000,
                        'Thun', 1000,
                        'Köniz', 1000,
                        'La Chaux-de-Fonds', 1000,
                        'Fribourg', 1000,
                        'Schaffhausen', 1000,
                        'Vernier', 1000,
                        'Chur', 1000,
                        'Neuchâtel', 1000,
                        'Uster', 1000,
                        'Sion', 1000,
                        'Luzern', 1000,
                        'Zug', 1000,
                        'Rapperswil-Jona', 1000,
                        'Yverdon-les-Bains', 1000,
                        'Dübendorf', 1000,
                        'Dietikon', 1000,
                        'Montreux', 1000,
                        'Frauenfeld', 1000,
                        'Wetzikon', 1000,
                        'Baar', 1000,
                        'Wil', 1000,
                        'Meyrin', 1000,
                        'Carouge', 1000,
                        'Wädenswil', 1000,
                        'Allschwil', 1000,
                        () => {
                            console.log('Sequence completed');
                        }
                    ]}
                    wrapper="span"
                    cursor={true}
                    repeat={Infinity}
                />
                </Text>
                <TextInput
                    style={styles.TextInput}
                    // add style to placeholder
                    placeholder="Choose wisely" placeholderTextColor={'lightgrey'}
                    value={textInputValue}
                    onChangeText={onChangeText}
                />
                <Button title="Search Weather in "
                        onPress={() => navigation.navigate('DetailPage', {inputCity: textInputValue})}/>
            </View>
        </SafeAreaView>
    );
}
