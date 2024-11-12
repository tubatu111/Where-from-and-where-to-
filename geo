<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Interactive Migration Map</title>

  <!-- Include Leaflet CSS and JS -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

  <style>
    /* Ensure the map takes up the full screen */
    #map {
      width: 100%;
      height: 600px;
    }

    /* Style for the legend */
    .legend {
      background-color: white;
      border: 1px solid #ccc;
      padding: 10px;
      font-size: 14px;
      position: absolute;
      bottom: 10px;
      left: 10px;
      z-index: 1000;
    }

    /* Footer information about creators */
    .footer {
      position: absolute;
      bottom: 10px;
      right: 10px;
      font-size: 12px;
      color: #555;
    }
  </style>
</head>
<body>

  <div id="map"></div> <!-- This is where the map will be displayed -->

  <div class="legend">
    <h4>Migration Intensity</h4>
    <div><span style="background-color: darkred; width: 20px; height: 20px; display: inline-block;"></span> > 1 million migrants</div>
    <div><span style="background-color: red; width: 20px; height: 20px; display: inline-block;"></span> > 500,000 migrants</div>
    <div><span style="background-color: orange; width: 20px; height: 20px; display: inline-block;"></span> > 100,000 migrants</div>
    <div><span style="background-color: gray; width: 20px; height: 20px; display: inline-block;"></span> Less than 100,000 migrants</div>
  </div>

  <div class="footer">
    Page created by: Akari Sofía Echeverría Ulloa, Lizeth Marine Sánchez Ceballos, Ivanna Satomi Rivas Yoshida, and Bárbara Montserrat Martínez Ramo.
  </div>

  <script>
    // Step 1: Create the map
    var map = L.map('map').setView([20, 0], 2); // Center the map around the world

    // Step 2: Add a base layer (OpenStreetMap)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // Step 3: Add GeoJSON data for countries (this is just an example, replace with actual data)
    var geojsonData = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "name": "Syria",
            "migrants": 5000000,
            "reason": "Armed conflict, civil war, and human rights violations. The civil war in Syria since 2011 has displaced millions of people, especially to neighboring countries like Turkey, Lebanon, and Jordan."
          },
          "geometry": {
            "type": "Polygon",
            "coordinates": [
              [[35, 33], [37, 34], [39, 35], [37, 36], [35, 35]] // Example coordinates for Syria
            ]
          }
        },
        {
          "type": "Feature",
          "properties": {
            "name": "Germany",
            "migrants": 1200000,
            "reason": "Refugees and migrants due to war, violence, and humanitarian crisis. Germany is a key destination due to its asylum policies and economic stability."
          },
          "geometry": {
            "type": "Polygon",
            "coordinates": [
              [[10, 51], [12, 52], [13, 51], [10, 50]] // Example coordinates for Germany
            ]
          }
        }
        // Add more countries here based on your actual data
      ]
    };

    // Step 4: Add the GeoJSON to the map and apply a style based on migrants
    function style(feature) {
      var color = 'gray'; // Default color

      var migrants = feature.properties.migrants;
      if (migrants > 1000000) {
        color = 'darkred'; // For countries with more than 1 million migrants
      } else if (migrants > 500000) {
        color = 'red'; // For countries with more than 500,000 migrants
      } else if (migrants > 100000) {
        color = 'orange'; // For countries with more than 100,000 migrants
      }

      return {
        color: color,
        weight: 2,
        fillOpacity: 0.5
      };
    }

    // Add the GeoJSON to the map
    L.geoJSON(geojsonData, {
      style: style,
      onEachFeature: function (feature, layer) {
        layer.bindPopup(`
          <strong>${feature.properties.name}</strong><br>
          Migrants: ${feature.properties.migrants.toLocaleString()}<br>
          Cause of displacement: ${feature.properties.reason}
        `);
      }
    }).addTo(map);

    // Step 5: Add migration routes (Example between Syria and Germany)
    var migrationRoute = L.polyline([
      [33.0, 35.0],  // Approximate coordinates of Syria
      [51.0, 10.0]   // Approximate coordinates of Germany
    ], {color: 'blue', weight: 4, opacity: 0.7}).addTo(map);

    migrationRoute.bindPopup("Migration route from Syria to Germany. Many Syrians flee the war towards Europe, with Germany being one of the main destinations.");

  </script>

</body>
</html>
