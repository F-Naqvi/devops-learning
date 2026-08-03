from flask import Flask, render_template
import redis
import os
import socket
import random


app = Flask(__name__)

redis_host = os.getenv("REDIS_HOST", "redis")
redis_port = int(os.getenv("REDIS_PORT", "6379"))

client = redis.Redis(
    host=redis_host,
    port=redis_port,
    decode_responses=True
)

ZEN_MESSAGES = [
    "breathe.",
    "you arrived.",
    "the water remembers.",
    "stillness is not empty.",
    "one ripple. many circles.",
    "nothing was lost.",
    "sit for a moment.",
    "the count does not hurry.",
    "you are the pause.",
    "presence is enough.",
    "let it settle.",
    "this too shall pass.",
    "the river does not rush.",
    "be where you are.",
    "the moment holds you.",
]

# Route 1 - Visitor Count
@app.route('/')
def void():
    visitor_count = client.incr('visitor_count')
    message = random.choice(ZEN_MESSAGES)
    hostname = socket.gethostname()
    return render_template('void.html', count=visitor_count, message=message, hostname=hostname)

# Route 2 - About Page
@app.route('/about')
def about():
    return render_template('about.html')

# Route 3 - Map page
@app.route('/map')
def map_view():
    return render_template('map.html')

if __name__== '__main__':
    app.run(host='0.0.0.0', port=5000)
