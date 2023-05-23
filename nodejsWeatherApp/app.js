const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000;

// Remember to replace 'your-api-key' with your actual OpenWeatherMap API key
const API_KEY = '2778580c99df100d59f87e838ab679f2';

app.get('/weather', async (req, res) => {
  const location = req.query.location;

  if (!location) {
    return res.status(400).json({ error: 'Location is required' });
  }

  const url = `http://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${API_KEY}`;

  try {
    const weatherResponse = await axios.get(url);
    const weatherData = weatherResponse.data;

    if (weatherData.cod !== 200) {
      return res.status(400).json({ error: 'Could not get weather for this location' });
    }

    res.json(weatherData);
  } catch (error) {
    res.status(500).json({ error: 'Something went wrong' });
  }
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}/weather?location=London`);
});
