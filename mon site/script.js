const navSlide = () => {
    const burger = document.querySelector('#burger');
    const nav = document.querySelector('#navLinks');
    const navLinks = document.querySelectorAll('.nav-links li');

    burger.addEventListener('click', () => {
        // Toggle Nav
        nav.classList.toggle('nav-active');

        // Animate Links
        navLinks.forEach((link, index) => {
            if (link.style.animation) {
                link.style.animation = '';
            } else {
                link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.3}s`;
            }
        });

        // Burger Animation
        burger.classList.toggle('toggle');
    });
}

// Changement de couleur navbar au scroll
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.style.padding = '0.8rem 5%';
        navbar.style.background = 'rgba(255, 255, 255, 0.95)';
    } else {
        navbar.style.padding = '1.5rem 5%';
        navbar.style.background = '#fff';
    }
});

navSlide();