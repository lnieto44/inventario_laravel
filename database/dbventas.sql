-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-05-2020 a las 01:31:34
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbventas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcategoria` int(10) UNSIGNED NOT NULL,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id`, `idcategoria`, `codigo`, `nombre`, `precio_venta`, `stock`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 1, '00245', 'loguitech', '20.00', 500, 'teclado model km90', 1, NULL, NULL),
(2, 3, 'MN-P78', 'placa asus', '250.00', 500, 'placas standar', 1, '2018-09-08 02:44:29', '2018-09-08 02:44:29'),
(3, 2, 'CMYK-45-10', 'GL Monitor de 4k', '1500.00', 500, 'monitor de alta resolucion', 1, '2018-09-08 02:45:13', '2018-09-08 02:45:13'),
(4, 5, '456663114', 'arte', '5000.00', 5, 'funda', 1, '2020-05-02 21:14:44', '2020-05-02 21:14:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'Teclados', 'teclados gamers', 1, NULL, NULL),
(2, 'Monitores', 'todos tipo de monitores', 1, '2018-09-08 02:43:35', '2018-09-08 02:43:35'),
(3, 'MotherBoards', 'placas madre gamers', 1, '2018-09-08 02:43:55', '2018-09-08 02:43:55'),
(4, 'Laptops', 'laptops de marca Hp, Lenovo, Asus, Acer, Toshiba, Dell', 1, '2018-09-10 22:23:16', '2018-09-10 22:23:16'),
(5, 'Fundas', 'fundas de laptop, impresoras y pc', 1, '2018-09-10 22:23:50', '2018-09-10 22:23:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingresos`
--

CREATE TABLE `detalle_ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idingreso` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ingresos`
--

INSERT INTO `detalle_ingresos` (`id`, `idingreso`, `idarticulo`, `cantidad`, `precio`) VALUES
(5, 4, 2, 100, '220.00'),
(6, 4, 1, 100, '20.00'),
(7, 5, 2, 50, '10.00'),
(8, 5, 1, 20, '20.00'),
(9, 6, 1, 50, '50.00'),
(10, 6, 2, 10, '250.00'),
(11, 6, 3, 5, '1250.00'),
(12, 7, 3, 1, '1500.00'),
(13, 8, 1, 10, '20.00'),
(14, 9, 3, 1, '1250.00');

--
-- Disparadores `detalle_ingresos`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingresos` FOR EACH ROW BEGIN
 UPDATE articulos SET stock = stock + NEW.cantidad 
 WHERE articulos.id = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idventa` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `idventa`, `idarticulo`, `cantidad`, `precio`, `descuento`) VALUES
(1, 1, 1, 10, '25.00', '0.00'),
(2, 2, 2, 1, '250.00', '0.00'),
(3, 2, 3, 1, '1500.00', '0.00'),
(4, 2, 1, 1, '20.00', '0.00'),
(5, 3, 1, 50, '20.00', '0.00'),
(6, 4, 1, 1, '20.00', '1.00'),
(7, 4, 2, 1, '250.00', '5.00'),
(8, 4, 3, 1, '1500.00', '20.00'),
(9, 5, 3, 2, '1500.00', '0.00'),
(10, 6, 3, 1, '1500.00', '0.00'),
(11, 7, 3, 2, '1500.00', '0.00'),
(12, 8, 3, 1, '1500.00', '0.00'),
(13, 9, 3, 1, '1500.00', '0.00');

--
-- Disparadores `detalle_ventas`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_ventas` FOR EACH ROW BEGIN
 UPDATE articulos SET stock = stock - NEW.cantidad
 WHERE articulos.id = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos`
--

CREATE TABLE `ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idproveedor` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingresos`
--

INSERT INTO `ingresos` (`id`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(4, 7, 1, 'BOLETA', '0001', '00004', '2018-06-01 00:00:00', '0.18', '24000.00', 'Anulado', '2018-09-09 06:57:17', '2018-09-09 07:07:39'),
(5, 3, 1, 'BOLETA', '0001', '00005', '2018-05-02 00:00:00', '0.18', '900.00', 'Anulado', '2018-09-09 07:23:08', '2018-09-09 07:23:26'),
(6, 3, 1, 'BOLETA', '0001', '00006', '2018-07-04 00:00:00', '0.18', '11250.00', 'Registrado', '2018-09-10 03:12:41', '2018-09-10 03:12:41'),
(7, 7, 1, 'BOLETA', '0001', '00005', '2018-09-10 00:00:00', '0.18', '1500.00', 'Registrado', '2018-09-10 03:46:47', '2018-09-10 03:46:47'),
(8, 3, 1, 'BOLETA', '0001', '00006', '2018-09-09 00:00:00', '0.18', '200.00', 'Registrado', '2018-09-10 04:27:00', '2018-09-10 04:27:00'),
(9, 7, 1, 'BOLETA', '0001', '00008', '2018-09-10 00:00:00', '0.18', '1250.00', 'Registrado', '2018-09-10 05:38:17', '2018-09-10 05:38:17');

--
-- Disparadores `ingresos`
--
DELIMITER $$
CREATE TRIGGER `tr_udpStockIngresoAnular` AFTER UPDATE ON `ingresos` FOR EACH ROW BEGIN
 UPDATE articulos a
 JOIN detalle_ingresos di
 ON di.idarticulo = a.id
 AND di.idingreso = new.id
 SET a.stock = a.stock - di.cantidad;
 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2018_02_20_171225_create_categorias_table', 1),
(3, '2018_02_22_235257_create_articulos_table', 1),
(4, '2018_02_27_143638_create_personas_table', 1),
(5, '2018_03_06_024616_create_proveedores_table', 1),
(6, '2018_03_13_133425_create_roles_table', 1),
(7, '2018_03_14_000000_create_users_table', 1),
(8, '2018_09_07_150703_create_ingresos_table', 1),
(9, '2018_09_07_150819_create_detalle_ingresos_table', 1),
(10, '2018_09_09_033145_create_ventas_table', 2),
(11, '2018_09_09_033241_create_detalle_ventas_table', 2),
(12, '2018_09_09_214633_create_notifications_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` int(10) UNSIGNED NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_id`, `notifiable_type`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('01ddeb26-cb7a-480a-a70c-8d46e59dd134', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":0,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 05:38:17', '2018-09-10 05:38:17'),
('12ee1930-fe16-4cfd-b2f8-79263702eea2', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 04:27:01', '2018-09-10 04:27:01'),
('18976400-e90c-4d79-a38b-a4fcb436edcc', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":0,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 05:38:17', '2018-09-10 05:38:17'),
('250ff7aa-710e-4d8a-90a5-99ab17fdbbd1', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:45:36', '2018-09-10 04:27:01', '2018-09-10 05:45:36'),
('2f25b2d2-a00d-4b80-bd33-f131b8459584', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 22:04:12', '2018-09-10 22:04:12'),
('3d9eaa7c-3a19-4759-93e9-9f3a5d3b6d49', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:23:09', '2018-09-10 04:56:57', '2018-09-10 05:23:09'),
('3ee696e5-119e-4fbb-b5d8-72933c3dc7e9', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":1,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', '2020-05-02 20:45:24', '2018-09-10 05:46:11', '2020-05-02 20:45:24'),
('470c8032-ef72-4efd-a17b-5663f6a040a7', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":4,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:23:09', '2018-09-10 03:46:47', '2018-09-10 05:23:09'),
('4cd4dccf-82c1-4abb-a40b-61943fe08938', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:45:36', '2018-09-10 04:56:57', '2018-09-10 05:45:36'),
('684458fa-75ec-4a51-b06e-4c1dbd965273', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 04:56:57', '2018-09-10 04:56:57'),
('6ba62dfd-d568-43e0-a549-dd9fde0771f3', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":2,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 21:40:15', '2018-09-10 21:40:15'),
('8576a7a5-54e7-42ae-adaa-ac0a5e167420', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":3,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:45:36', '2018-09-10 03:12:41', '2018-09-10 05:45:36'),
('873a7350-0270-45ca-9749-65722c670804', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":0,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', '2020-05-02 20:45:24', '2018-09-10 05:38:17', '2020-05-02 20:45:24'),
('8ca22592-976f-46cd-9e76-156e4d741ec0', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 22:04:12', '2018-09-10 22:04:12'),
('8ff5f5ae-e4f0-4ab9-8d79-417aa9193c7b', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":2,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', '2020-05-02 20:45:24', '2018-09-10 21:40:14', '2020-05-02 20:45:24'),
('90518822-036c-47de-9ddf-fe113fee9d1c', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":3,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:23:09', '2018-09-10 03:12:41', '2018-09-10 05:23:09'),
('9dadb61b-8165-43d9-91ba-58bbd205f1cc', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 21:59:05', '2018-09-10 21:59:05'),
('a0c4696b-16c8-4178-8f77-ab2d8c93245d', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":1,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 05:46:11', '2018-09-10 05:46:11'),
('a3b0afd2-99be-40f8-83ba-f70d4af58f48', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":5,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:23:09', '2018-09-10 04:27:01', '2018-09-10 05:23:09'),
('a7e8a01f-f5ee-4104-9188-5c6695dbbb4a', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', '2020-05-02 20:45:24', '2018-09-10 21:59:04', '2020-05-02 20:45:24'),
('ae106c99-8990-4f72-a2f5-09274e201b43', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":1,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 05:46:11', '2018-09-10 05:46:11'),
('b3304c5c-e163-482a-a26b-84c5692b3cf8', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":2,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 21:40:15', '2018-09-10 21:40:15'),
('c0f36d6b-9120-4837-b83d-f380851c87f4', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":4,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', '2020-05-02 20:45:24', '2018-09-10 22:04:11', '2020-05-02 20:45:24'),
('d2d26885-a007-4202-9d5a-fb7cf440e9d4', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":1,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 21:59:05', '2018-09-10 21:59:05'),
('e3308d17-d631-49b6-b4f8-c02aa4226466', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":4,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 03:46:47', '2018-09-10 03:46:47'),
('e8673ed8-6ab6-4651-9d9b-1d7e08741e43', 'App\\Notifications\\NotifyAdmin', 6, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":4,\"msj\":\"Ingresos\"}}}', '2018-09-10 05:45:36', '2018-09-10 03:46:47', '2018-09-10 05:45:36'),
('f0eed6a3-b7a4-4f0c-962c-f208aaabb142', 'App\\Notifications\\NotifyAdmin', 5, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":3,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":3,\"msj\":\"Ingresos\"}}}', NULL, '2018-09-10 03:12:41', '2018-09-10 03:12:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_documento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `created_at`, `updated_at`) VALUES
(1, 'angel', 'DNI', '72154871', 'calle los naranjos 852', '54328730', 'angeltotocayo_257@hotmail.com', NULL, NULL),
(2, 'juan carlos', 'DNI', '54215485', 'Av. simon bolivar 410', '54328730', 'juan@gmail.com', NULL, NULL),
(3, 'ELECTRONICS S.A.C.', 'RUC', '10585621457', 'Calle los jirasoles 20', '458521', 'electronics@hotmail.com', NULL, NULL),
(4, 'Daniel', 'DNI', '45852541', 'Calle los tombos 63', '05478541', 'daniel@gmail.com', '2018-09-07 21:17:24', '2018-09-07 21:17:24'),
(5, 'Jose', 'DNI', '30225415', 'Calle Perales 221', '556699', 'jose@gmail.com', '2018-09-07 21:19:08', '2018-09-07 21:19:08'),
(6, 'Maximo', 'DNI', '30662512', 'Av la marina 120', '221155', 'maximo@gmail.com', '2018-09-07 21:20:16', '2018-09-07 21:20:16'),
(7, 'ITD tecnology', 'RUC', '20548452584', 'Calle Octavio Muñoz Najar 215', '354896', 'itd@gmail.com', '2018-09-07 23:20:08', '2018-09-07 23:20:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(10) UNSIGNED NOT NULL,
  `contacto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_contacto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `contacto`, `telefono_contacto`) VALUES
(3, 'Martin quiñones', '584721'),
(7, 'Daniela Chamuco', '452512'),
(3, 'Martin quiñones', '584721'),
(7, 'Daniela Chamuco', '452512');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Administrador', 'Administradores de área', 1),
(2, 'Vendedor', 'Vendedor área venta', 1),
(3, 'Almacenero', 'Almacenero área compras', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `idrol` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`) VALUES
(1, 'admin', '$2y$12$fQVExSFUFZCNs.9xClllau9VAWQGMJZq7KNTQ14DgpO2djOIiEeVi', 1, 1, '72kQ5QSGTYpxiMXffR6EPr4lgMD0BulbSrxzWuyCiwxFw48ugApJ4pi6nB6U'),
(5, 'jose', '$2y$10$/NCWJJ9aD60bi.KG/Nu4seGwesgiisIKb1k6eVHyM7mldYTyNfm8u', 1, 3, ''),
(6, 'maxi', '$2y$10$Doyn0rEKDWS76NiZHxzjIu53u7VL5MDbGndautuyKv8iBygVDq1De', 1, 2, 'JaMiM71ZZDQiqPhOgqMNAZN6nn2TA2hqwOySO0LNaJidezJBD64caBVnL4qo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcliente` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'BOLETA', '001', '0001', '2018-05-01 00:00:00', '18.00', '100.00', 'Anulado', NULL, '2018-09-09 23:35:19'),
(2, 6, 1, 'BOLETA', '0001', '00002', '2018-06-05 00:00:00', '0.18', '1770.00', 'Anulado', '2018-09-09 23:05:01', '2018-09-09 23:41:05'),
(3, 6, 1, 'BOLETA', '0001', '0003', '2018-05-07 00:00:00', '0.18', '1000.00', 'Registrado', '2018-09-09 23:19:37', '2018-09-09 23:19:37'),
(4, 4, 1, 'BOLETA', '0001', '00005', '2018-09-09 00:00:00', '0.18', '1744.00', 'Registrado', '2018-09-09 23:37:59', '2018-09-09 23:37:59'),
(5, 7, 6, 'BOLETA', '0001', '0007', '2018-09-09 00:00:00', '0.18', '3000.00', 'Registrado', '2018-09-10 04:56:57', '2018-09-10 04:56:57'),
(6, 4, 6, 'BOLETA', '0001', '00009', '2018-09-10 00:00:00', '0.18', '1500.00', 'Registrado', '2018-09-10 05:46:11', '2018-09-10 05:46:11'),
(7, 6, 1, 'BOLETA', '0001', '00009', '2018-09-10 00:00:00', '0.18', '3000.00', 'Registrado', '2018-09-10 21:40:13', '2018-09-10 21:40:13'),
(8, 3, 1, 'BOLETA', '0001', '0010', '2018-09-10 00:00:00', '0.18', '1500.00', 'Registrado', '2018-09-10 21:59:04', '2018-09-10 21:59:04'),
(9, 7, 1, 'BOLETA', '0001', '00011', '2018-09-10 00:00:00', '0.18', '1500.00', 'Registrado', '2018-09-10 22:04:11', '2018-09-10 22:04:11');

--
-- Disparadores `ventas`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVentaAnular` AFTER UPDATE ON `ventas` FOR EACH ROW BEGIN
 UPDATE articulos a
   JOIN detalle_ventas dv
   ON dv.idarticulo = a.id
   AND dv.idventa = NEW.id
   SET a.stock = a.stock+dv.cantidad;
   
  END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `articulos_nombre_unique` (`nombre`),
  ADD KEY `articulos_idcategoria_foreign` (`idcategoria`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ingresos_idingreso_foreign` (`idingreso`),
  ADD KEY `detalle_ingresos_idarticulo_foreign` (`idarticulo`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ventas_idventa_foreign` (`idventa`),
  ADD KEY `detalle_ventas_idarticulo_foreign` (`idarticulo`);

--
-- Indices de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingresos_idproveedor_foreign` (`idproveedor`),
  ADD KEY `ingresos_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personas_nombre_unique` (`nombre`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD KEY `proveedores_id_foreign` (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ventas_idcliente_foreign` (`idcliente`),
  ADD KEY `ventas_idusuario_foreign` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_idcategoria_foreign` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  ADD CONSTRAINT `detalle_ingresos_idarticulo_foreign` FOREIGN KEY (`idarticulo`) REFERENCES `articulos` (`id`),
  ADD CONSTRAINT `detalle_ingresos_idingreso_foreign` FOREIGN KEY (`idingreso`) REFERENCES `ingresos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_idarticulo_foreign` FOREIGN KEY (`idarticulo`) REFERENCES `articulos` (`id`),
  ADD CONSTRAINT `detalle_ventas_idventa_foreign` FOREIGN KEY (`idventa`) REFERENCES `ventas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `ingresos_idproveedor_foreign` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `ingresos_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `proveedores_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `ventas_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
