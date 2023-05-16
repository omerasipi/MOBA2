import React, {useState, useEffect} from 'react';
import {
    IonList,
    IonItem,
    IonLabel,
    IonPage,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButton
} from '@ionic/react';
import axios from 'axios';

const goToHome = () => {
    window.location.href = '/home';
}

const MoviesList = () => {
    const [movies, setMovies] = useState<Movie[]>([]);
    const OMDB_API_KEY = 'b3418473';
    const url = `http://www.omdbapi.com/?apikey=${OMDB_API_KEY}`;
    const imdbIds = ["tt0317219", "tt1691917", "tt0321249"];

    useEffect(() => {
        const fetchMovies = async () => {

            const createMovieFromResponse = (data: any): Movie => {
                return {
                    id: data.imdbID,
                    title: data.Title,
                    year: data.Year,
                    director: data.Director,
                    poster: data.Poster
                };
            }

            const moviesData: Movie[] = [];

            for (const imdbId of imdbIds) {
                const response = await axios.get<Movie>(url + `&i=${imdbId}`);
                moviesData.push(createMovieFromResponse(response.data));
            }

            setMovies(moviesData);
        };

        fetchMovies();
    }, []);

    return (
        <IonPage>
            <IonHeader>
                <IonToolbar>
                    <IonTitle>Movies</IonTitle>
                </IonToolbar>
            </IonHeader>
            <IonContent className="ion-padding">
                <h1>Movies</h1>
                <IonButton color="primary" routerLink="/home" onClick={goToHome}>
                    Back to Home
                </IonButton>
                <IonList>
                    {movies.map((movie, index) => (
                        <IonItem key={index}>
                            <IonLabel>
                                <h2>{movie.title}</h2>
                                <img src={movie.poster} alt={movie.title}/>
                                <p>{movie.year} {movie.director}</p>
                            </IonLabel>
                        </IonItem>
                    ))}
                </IonList>
            </IonContent>
        </IonPage>

    );
};

export default MoviesList;


interface Movie {
    id: string;
    title: string;
    year: string;
    director: string;
    poster: string;
}
