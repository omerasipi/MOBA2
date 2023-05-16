import React from 'react';
import {
    StyleSheet,
    Text,
    SafeAreaView,
    ScrollView,
    StatusBar, Image, Dimensions
} from 'react-native';

const App = () => {
    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <Text style={styles.header}>Cars</Text>
                <Image source={require('../../assets/images/cars.jpg')} style={styles.poster}/>
                <Text style={styles.text}> 2008 </Text>
                <Text style={styles.text}> Disney Pixar </Text>
                <Text style={styles.text}> more data from API </Text>
            </ScrollView>
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: StatusBar.currentHeight,
        width: Dimensions.get('window').width,
    },
    text: {
        fontSize: 24,
    },
    header: {
        fontSize: 72,
        textAlign: 'center',
    },
    poster: {
        width: Dimensions.get('window').width,
        height: Dimensions.get('window').height * 9 / 16,
    }
});

export default App;
