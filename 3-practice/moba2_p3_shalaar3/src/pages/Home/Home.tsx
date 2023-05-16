import {
    IonContent,
    IonHeader,
    IonPage,
    IonTitle,
    IonToolbar,
    IonButton,
    IonIcon,
} from '@ionic/react';
import {add} from 'ionicons/icons';
import './Home.css';

const goToWebsite = (name: string) => {
    window.location.href = "/" + name;
}

const Home: React.FC = () => (
    <IonPage>
        <IonHeader>
            <IonToolbar>
                <IonTitle>My Ionic React App</IonTitle>
            </IonToolbar>
        </IonHeader>
        <IonContent className="ion-padding">
            <h1>Welcome to My Ionic React App</h1>
            <IonButton onClick={() => goToWebsite("about")}>Go to About</IonButton>
            <IonButton onClick={() => goToWebsite("movies")}>Go to Movies</IonButton>
        </IonContent>
    </IonPage>
);

export default Home;
