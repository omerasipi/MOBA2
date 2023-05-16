import React from "react";
import {IonContent, IonHeader, IonPage, IonTitle, IonToolbar, IonButton, IonIcon, IonButtons} from '@ionic/react';
import {add, home, car} from 'ionicons/icons';

const goToHome = () => {
    window.location.href = '/home';
}

const About: React.FC = () => (
    <IonPage>
        <IonHeader>
            <IonToolbar>
                <IonTitle>About</IonTitle>
            </IonToolbar>
        </IonHeader>
        <IonContent className="ion-padding">
            <h1>About</h1>
            <IonButton color="primary">
                <IonIcon icon={add}/>
                This button does nothing
            </IonButton>
            <IonButtons>
                <IonButton color="primary">
                    <IonIcon icon={add}/>
                    This button does nothing either
                </IonButton>
                <IonButton color="secondary">
                    <IonIcon icon={car}/>
                    This is a secondary button
                </IonButton>
            </IonButtons>
            <IonButton color="primary" onClick={goToHome}>
                <IonIcon icon={home}/>
                Back to Home
            </IonButton>
        </IonContent>
    </IonPage>
);

export default About;


