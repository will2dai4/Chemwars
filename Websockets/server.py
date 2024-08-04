

import asyncio
import websockets

print("starting..")
async def handle_websocket(websocket, path):
    try:
        while True:
            message = await websocket.recv()
            print(f"Received message: {message}")
            response = "Pong!"
            await websocket.send(response)
    except websockets.ConnectionClosed:
        pass

if __name__ == "__main__":
    start_server = websockets.serve(handle_websocket, "localhost", 12345)
    asyncio.get_event_loop().run_until_complete(start_server)
    asyncio.get_event_loop().run_forever()