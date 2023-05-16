import Light from "../light/Light";

const TrafficLight = ({lightProps}) => {
    return (
        <div className="traffic-light">
            {lightProps.map((lightProp, index) => <Light key={index} color={lightProp.color} active={lightProp.active}/>)}
        </div>
    )
}

export default TrafficLight;
