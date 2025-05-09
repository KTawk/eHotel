<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>e_Hotel Luxury Stay</title>
    <link rel="stylesheet" href="css/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
</head>

<body>

<!-- Top Navigation -->
<%@ include file="top-navbar.html" %>

<!-- Hero Video Section -->
<section class="video-section">
    <video autoplay muted loop id="background-video" poster="media/poster.jpg">
        <source src="media/background.mp4" type="video/mp4" />
        Your browser does not support the video tag.
    </video>
</section>

<!-- Additional Scrollable Content -->
<section id="welcome-section" class="welcome-section">
    <h2>VELVET NIGHTS</h2>
    <br><br>
    <p class="description">
        Step into a world where sophistication, comfort, and timeless elegance blend seamlessly.
        At <b>Velvet Nights</b>, we believe your stay should be more than just accommodation.
        It should be an experience. From lavish interiors and curated details to warm service and serene ambiance,
        every element is designed to immerse you in luxury.
        Whether you are here for a weekend escape, a romantic getaway, or a business retreat,
        let us redefine what it means to feel at home, wrapped in velvet and surrounded by beauty.
    </p>
    <button class="info-btn" onclick="location.href='rooms.jsp'">BOOK A ROOM</button>
</section>

<section class="highlight-section">
    <div class="highlight-container">
        <div class="highlight-image">
            <img src="media/hotel-building.png" alt="Velvet Nights Hotel in Ottawa">
        </div>
        <div class="highlight-text">
            <h3>ELEGANCE MEETS NATURE IN THE HEART OF OTTAWA</h3>
            <p>
                At Velvet Nights, every stay is a statement of comfort and consciousness. Our upcoming location
                blends timeless luxury with natural serenity, nestled near Ottawa’s historic waterways and vibrant city life.
            </p>
            <p>
                From curated interiors to sustainable design choices, we invite you to discover a hotel experience
                that embraces sophistication and soul.
            </p>
            <p>- Velvet Nights Editorial</p>
        </div>
    </div>
</section>

<section class="highlight-section">
    <div class="highlight-container">
        <div class="highlight-image">
            <img src="media/dining.png" alt="Velvet Nights Gourmet Dining">
        </div>
        <div class="highlight-text">
            <h3>CULINARY DELIGHTS THAT TELL A STORY</h3>
            <p>
                At Velvet Nights, dining is more than a meal — it’s an experience. From locally inspired dishes to international favorites, every plate is crafted to awaken your senses. Whether it’s breakfast in bed or dinner under the stars, your taste journey begins here.
            </p>
            <p>- Velvet Nights Culinary Team</p>
        </div>
    </div>
</section>

<section class="highlight-section">
    <div class="highlight-container">
        <div class="highlight-image">
            <img src="media/spaRoom.png" alt="Velvet Nights Gourmet Dining">
        </div>
        <div class="highlight-text">
            <h3>YOUR PEACEFUL HAVEN IN THE CITY</h3>
            <p>
                Step away from the noise and into serenity. Our wellness offerings include in-room spa treatments,
                guided meditation sessions, and access to nearby nature walks. Velvet Nights is where body, mind,
                and soul find balance.
            </p>
            <p>- Velvet Nights Wellness Team</p>
        </div>
    </div>
</section>

<section class="highlight-section">
    <div class="highlight-container">
        <div class="highlight-image">
            <img src="media/img.png" alt="Velvet Nights Gourmet Dining">
        </div>
        <div class="highlight-text">
            <h3>CELEBRATING MOMENTS THAT MATTER</h3>
            <p>
                From bridal mornings and best-friend getaways to spontaneous escapes, Velvet Nights is where
                unforgettable memories begin.
            </p>
            <p>Laughter, comfort, and a touch of luxury — all wrapped in moments that feel like magic. </p>
            <p>Every smile here tells a story, and yours is just getting started.</p>
            <p>- Velvet Nights Wellness Team</p>
        </div>
    </div>
</section>



<script src="js/script.js"></script>
<%@ include file="footer.html" %>
</body>
</html>
