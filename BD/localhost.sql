-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 30-09-2013 a las 09:14:40
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bd_mates`
--
CREATE DATABASE `bd_mates` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bd_mates`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `id_admin` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(150) NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE IF NOT EXISTS `cursos` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT,
  `clase` varchar(7) NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `clase`) VALUES
(1, '1ESO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exams`
--

CREATE TABLE IF NOT EXISTS `exams` (
  `id_examen` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  PRIMARY KEY (`id_examen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exams_temas`
--

CREATE TABLE IF NOT EXISTS `exams_temas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tema` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tema` (`id_tema`,`id_examen`),
  KEY `id_examen` (`id_examen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE IF NOT EXISTS `tareas` (
  `id_tarea` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `f_publicacion` datetime NOT NULL,
  `f_cierre` datetime NOT NULL,
  `id_tema` int(11) NOT NULL,
  PRIMARY KEY (`id_tarea`),
  KEY `id_tema` (`id_tema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temas`
--

CREATE TABLE IF NOT EXISTS `temas` (
  `id_tema` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  PRIMARY KEY (`id_tema`),
  KEY `id_curso` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trimestres`
--

CREATE TABLE IF NOT EXISTS `trimestres` (
  `id_trimestre` int(11) NOT NULL AUTO_INCREMENT,
  `f_inicio` date NOT NULL,
  `f_final` date NOT NULL,
  PRIMARY KEY (`id_trimestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id_alumno` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(30) NOT NULL,
  `id_curso` int(11) NOT NULL,
  PRIMARY KEY (`id_alumno`),
  KEY `id_curso` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_exams`
--

CREATE TABLE IF NOT EXISTS `users_exams` (
  `id_alumno_examen` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumno` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  `nota_examen_alumno` int(11) NOT NULL,
  PRIMARY KEY (`id_alumno_examen`),
  KEY `id_alumno` (`id_alumno`,`id_examen`),
  KEY `id_examen` (`id_examen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_tareas`
--

CREATE TABLE IF NOT EXISTS `users_tareas` (
  `id_alumno_tarea` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumno` int(11) NOT NULL,
  `id_tarea` int(11) NOT NULL,
  `nota_tarea_alumno` int(11) NOT NULL,
  PRIMARY KEY (`id_alumno_tarea`),
  KEY `id_alumno` (`id_alumno`,`id_tarea`),
  KEY `id_tarea` (`id_tarea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_trimestres`
--

CREATE TABLE IF NOT EXISTS `users_trimestres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumno` int(11) NOT NULL,
  `id_trimestre` int(11) NOT NULL,
  `nota_alumno_trimestre` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_alumno` (`id_alumno`,`id_trimestre`),
  KEY `id_trimestre` (`id_trimestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `exams_temas`
--
ALTER TABLE `exams_temas`
  ADD CONSTRAINT `exams_temas_ibfk_1` FOREIGN KEY (`id_tema`) REFERENCES `temas` (`id_tema`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `exams_temas_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `exams` (`id_examen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`id_tema`) REFERENCES `temas` (`id_tema`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `temas`
--
ALTER TABLE `temas`
  ADD CONSTRAINT `temas_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `users_exams`
--
ALTER TABLE `users_exams`
  ADD CONSTRAINT `users_exams_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `users` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_exams_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `exams` (`id_examen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_tareas`
--
ALTER TABLE `users_tareas`
  ADD CONSTRAINT `users_tareas_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `users` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_tareas_ibfk_2` FOREIGN KEY (`id_tarea`) REFERENCES `tareas` (`id_tarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_trimestres`
--
ALTER TABLE `users_trimestres`
  ADD CONSTRAINT `users_trimestres_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `users` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_trimestres_ibfk_2` FOREIGN KEY (`id_trimestre`) REFERENCES `trimestres` (`id_trimestre`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
