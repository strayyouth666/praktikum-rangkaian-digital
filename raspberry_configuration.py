import time
import cv2
from gpiozero import LED
from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse
from io import BytesIO

app = FastAPI()

leds = {}
for i in range(0, 23):
    print(i)
    leds[i] = LED(i)


# Turn on LED
def turn_on(led):
    led.on()


# Turn off LED
def turn_off(led):
    led.off()


# Generate Video Frames
def generate_frames():
    camera = cv2.VideoCapture(0)  # Initialize the camera (change the index if necessary)

    if not camera.isOpened():
        raise RuntimeError("Could not open the camera.")

    while True:
        ret, frame = camera.read()  # Read a frame from the camera

        if not ret:
            break

        # Convert the frame to JPEG format
        ret, jpeg = cv2.imencode('.jpeg', frame)

        if not ret:
            break

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + jpeg.tobytes() + b'\r\n\r\n')

        time.sleep(0.1)  # Adjust the delay between frames as desired

    camera.release()


@app.get("/")
async def hello():
    return "Hello World"


@app.get('/video_feed')
def video_feed():
    return StreamingResponse(generate_frames(),
                             media_type='multipart/x-mixed-replace; boundary=frame')


@app.post("/gpio")
async def gpio_control(request: Request):
    # Retrieve the desired action from the request
    body = await request.json()
    action = body["action"]
    led_number = body["led"]

    # Perform the appropriate GPIO operation based on the action and LED number
    switcher = {"on": turn_on, "off": turn_off}

    # Get the corresponding LED object based on the LED number
    print(led_number)
    led = leds.get(int(led_number))

    if led is None:
        return {"message": f"Invalid LED number: {led_number}"}

    print(action)
    if action == "on":
        turn_on(led)
        return "ON"
    elif action == "off":
        turn_off(led)
        return "OFF"

    # Execute the appropriate action based on the switcher
    action_func = switcher.get(action)
    if action_func:
        turn_on(led)
        return {"message": f"LED {led_number} {action} successfully"}
    else:
        return {"message": f"Invalid action: {action}"}


@app.get("/gpio/{led}")
def get_led_state(led: int):
    # Get the corresponding LED object based on the LED number
    led = leds.get(led)
    if led:
        state = "on" if led.is_lit else "off"
        return {"led": led, "state": state}
    else:
        return {"message": f"Invalid LED number: {led}"}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0")
