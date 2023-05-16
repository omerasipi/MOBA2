import TrafficLight from "../trafficLight/trafficLight";
import './trafficLightCasing.css'
import {useState, useEffect} from "react";

const TrafficLightCasing = (props) => {
    const newLightProps = [
        {color: "red", active: false},
        {color: "yellow", active: false},
        {color: "green", active: false}
    ];
    newLightProps[Math.floor(Math.random() * newLightProps.length)].active = true;

    const [lightProps, setLightProps] = useState(newLightProps);

    const nextStep = () => setLightProps((prevState) => {
        const newState = [...prevState];
        const activeLightIndex = newState.findIndex((light) => light.active);
        newState[activeLightIndex].active = false;
        newState[(activeLightIndex + 1) % newState.length].active = true;
        return newState;
    });

    const timeout = Math.floor(Math.random() * 1500) + 500;

    useEffect(() => {
        const intervalId = setInterval(() => {
            nextStep();
        }, timeout);
        return () => clearInterval(intervalId);
    }, [timeout]);

    const handleClick = () => {
        nextStep();
    }

    return (
        <div className="traffic-light-casing-container">
            <div className="traffic-light-casing"
                 onClick={handleClick}
                 style={{
                     backgroundColor: props.color ? props.color : "gray",
                     width: props.width ? props.width : "120px",
                     height: props.height ? props.height : "fit-content",
                     borderRadius: props.borderRadius ? props.borderRadius : "10px",
                     border: props.border ? props.border : "1px solid black",
                     boxShadow: props.boxShadow ? props.boxShadow : "0 0 0 0",
                     margin: props.margin ? props.margin : "10px",
                     padding: props.padding ? props.padding : "10px",
                     display: props.display ? props.display : "flex",
                     flexWrap: props.flexWrap ? props.flexWrap : "wrap",
                     flexDirection: props.flexDirection ? props.flexDirection : "column",
                     justifyContent: props.justifyContent ? props.justifyContent : "space-between",
                     alignItems: props.alignItems ? props.alignItems : "center",
                     alignContent: props.alignContent ? props.alignContent : "stretch",
                     top: props.top ? props.top : "0",
                     right: props.right ? props.right : "0",
                     bottom: props.bottom ? props.bottom : "0",
                     left: props.left ? props.left : "0",
                     zIndex: props.zIndex ? props.zIndex : "0",
                 }}
            >
                <TrafficLight lightProps={lightProps}/>
            </div>
        </div>
    )
}

export default TrafficLightCasing;
