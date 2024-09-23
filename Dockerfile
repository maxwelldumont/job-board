# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, MySQL, PHP, Node.js, npm, and other necessary packages
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    php \
    php-mysql \
    php-xml \
    php-mbstring \
    php-zip \
    php-curl \
    curl \
    git \
    unzip \
    nodejs \
    npm \
    libapache2-mod-php \
    && apt-get clean

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set up working directory in /var/www/html
WORKDIR /var/www/html

# Install Composer (Laravel's dependency manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the current Laravel application files into the container
COPY . /var/www/html

# Install Node.js dependencies, including Tailwind CSS, PostCSS, and Autoprefixer
RUN npm install -D tailwindcss postcss autoprefixer

# Initialize Tailwind CSS (this generates tailwind.config.js)
RUN npx tailwindcss init

# Create necessary directories for Tailwind CSS and mix configuration
RUN mkdir -p resources/css && \
    echo '@tailwind base;\n@tailwind components;\n@tailwind utilities;' > resources/css/app.css

# Install Laravel Mix and update the mix configuration to use Tailwind CSS
RUN npm install laravel-mix && \
    echo "let mix = require('laravel-mix');\n" \
         "mix.postCss('resources/css/app.css', 'public/css', [\n" \
         "   require('tailwindcss'),\n" \
         "]);" > webpack.mix.js

# Compile the assets using Laravel Mix
RUN npm run dev

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
