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

<!-- Contact Section -->

<!-- <section id="welcome-section" class="welcome-section">
    <h2>Get In Touch</h2>
    <br><br> -->

<section id="contact" style="padding: 100px 20px; background-color: #f9f6f1; text-align: center;  font-family: 'Helvetica Neue', sans-serif;" >
    <h2 style="font-size: 2.2rem; margin-bottom: 40px;">Get in Touch</h2>
    <p style="margin: 0 auto 30px; font-size: 20px; line-height: 1.8; max-width: 800px; margin: 0 auto 40px;
    font-family: 'Montserrat', sans-serif;">
        Whether you're planning a weekend escape, a special event, or simply have a question, we're here for you.
        At <strong>Velvet Nights</strong>, your comfort begins the moment you reach out.
        Feel free to call, email, or drop us a message below we would love to hear from you.
    </p>

    <div style="margin: 0 auto 30px; font-size: 20px; line-height: 1.8; max-width: 800px; margin: 0 auto 40px;">
        <p><strong>Address:</strong> 123 Velvet Avenue, Ottawa, ON</p>
        <p><strong>Phone:</strong> +1 (343) 988-0877</p>
        <p><strong>Email:</strong> <a href="mailto:Kairly.tauk@outlook.com">Kairly.tauk@outlook.com</a></p>
    </div>

    <form>
        <input type="text" placeholder="Your Name" required
               style="width: 80%; max-width: 500px; margin: 10px auto; padding: 12px; border: 1px solid #ccc; border-radius: 8px; display: block;">
        <input type="email" placeholder="Your Email" required
               style="width: 80%; max-width: 500px; margin: 10px auto; padding: 12px; border: 1px solid #ccc; border-radius: 8px; display: block;">
        <textarea placeholder="Your Message" rows="10" required
                  style="width: 80%; max-width: 500px; margin: 10px auto; padding: 12px; border: 1px solid #ccc; border-radius: 8px; display: block;"></textarea>
        <button type="submit"
                style="background-color: black; color: white; padding: 12px 30px; border: none; border-radius: 8px; cursor: pointer; margin-top: 10px;">
            Send Message
        </button>
    </form>
</section>
<script src="js/script.js"></script>
<%@ include file="footer.html" %>
</body>
</html>