window.addEventListener("scroll", () => {
    const nav = document.querySelector(".top-nav");
    const videoSection = document.querySelector(".video-section");
    const triggerHeight = videoSection.offsetHeight;

    if (window.scrollY > triggerHeight - 80) {
        nav.classList.add("scrolled");
    } else {
        nav.classList.remove("scrolled");
    }
});
