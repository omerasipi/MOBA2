import './Light.css'
const Light = ({ color, active }) => {
    return <div
        className="light"
        style={{backgroundColor: color, opacity: active ? 1 : 0.3}} />
}


export default Light
