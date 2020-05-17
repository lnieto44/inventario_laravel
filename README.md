Como ejecutar el proyecto

1-Configure Virtual Hosts desde xampp

Siga los pasos a continuación para crear un host virtual:

1-1. Cambie a su directorio de instalación de XAMPP (normalmente, C: \ xampp ) y abra el archivo httpd-vhosts.conf en el subdirectorio: 
apache\ conf \ extra \ usando su editor de texto favorito.

1-2. Reemplace el contenido de este archivo con las siguientes directivas:

<VirtualHost *:80>
       DocumentRoot "C:/xampp/htdocs/"
       ServerName localhost
</VirtualHost>
<VirtualHost *:80>
       DocumentRoot "C:\xampp\htdocs\inventario_laravel\public"
       ServerName inventario_laravel.com
</VirtualHost>

1-3. Reinicie Apache usando el panel de control XAMPP para que sus cambios surtan efecto.

1-4. En este punto, su host virtual está configurado. Sin embargo,su navegador mostrará un aviso de falla, 
ya que este dominio no existe en realidad. Para resolver esto, es necesario asignar el dominio personalizado a la dirección IP local. 
Para hacer esto, abra el archivo C: \ windows \ system32 \ drivers \ etc \ hosts y agregue la siguiente línea:

127.0.0.1 localhost

#laravel host
127.0.0.1 inventario_laravel.com

listo ahora escriba en su navegador favorito inventario_laravel.com y teniendo corriendo el  panel de control de xampp le funcionara

Nota la base de datos se encuentra en la carpera database
