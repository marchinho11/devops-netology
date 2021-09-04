# docker build --tag marchinho11/netology -f 05_03.Dockerfile .
# docker run -dit --name my-running-app -p 8080:80 marchinho11/netology
FROM httpd:2.4

RUN echo "\
<html> \n\
    <head> \n\
        Hey, Netology \n\
    </head> \n\
    <body> \n\
        <h1>I'm kinda DevOps now</h1> \n\
    </body> \n\
</html>\
" > /usr/local/apache2/htdocs/index.html
