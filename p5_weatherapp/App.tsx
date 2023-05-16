import * as React from 'react';
import {StyleSheet} from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {MainPage} from "./MainPage/MainPage"
import {DetailPage} from "./DetailPage/DetailPage"
import {useState} from "react";


const Stack = createNativeStackNavigator();

const App = () => {
    const [passedValue, setPassedValue] = useState('');

    const onTextInputValueChange = (value) => {
        setPassedValue(value);
    };

    return (
        <NavigationContainer>
            <Stack.Navigator>
                <Stack.Screen
                    name="MainPage"
                    component={MainPage}
                    initialParams={{onTextInputValueChange}}
                />
                <Stack.Screen name="DetailPage" component={DetailPage}/>
            </Stack.Navigator>
        </NavigationContainer>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
    },
    TextInput: {
        height: 40,
        borderColor: 'gray',
        borderWidth: 1

    }
});

export default App;
