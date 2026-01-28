# ⚽ Premier League 2024-25 Season - Data Analysis Project

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Pandas](https://img.shields.io/badge/Pandas-2.0+-green.svg)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📋 Descripción del Proyecto

Proyecto completo de análisis de datos de la temporada 2024-25 de la Premier League inglesa. Este proyecto demuestra habilidades clave en análisis de datos, visualización, limpieza de datos y generación de insights para toma de decisiones.

**Objetivo:** Analizar el rendimiento de equipos, patrones de juego, y generar insights accionables utilizando técnicas de análisis estadístico y visualización de datos.

## 🎯 Habilidades Demostradas

Este proyecto showcasea las siguientes competencias técnicas demandadas en el mercado:

### 📊 Data Analytics
- ✅ **Limpieza y preparación de datos** (Data Cleaning)
- ✅ **Análisis exploratorio de datos** (EDA)
- ✅ **Análisis estadístico descriptivo**
- ✅ **Agregaciones y transformaciones complejas**
- ✅ **Identificación de patrones y tendencias**

### 💻 Herramientas y Tecnologías
- ✅ **Python** - Lenguaje principal
- ✅ **Pandas** - Manipulación y análisis de datos
- ✅ **NumPy** - Operaciones numéricas
- ✅ **Matplotlib & Seaborn** - Visualización de datos
- ✅ **Git & GitHub** - Control de versiones

### 📈 Visualización de Datos
- ✅ Gráficos de barras y distribuciones
- ✅ Gráficos de dispersión (scatter plots)
- ✅ Gráficos de pastel (pie charts)
- ✅ Visualizaciones comparativas
- ✅ Dashboards informativos

### 🔍 Análisis de Negocio
- ✅ KPIs y métricas de rendimiento
- ✅ Análisis comparativo entre entidades
- ✅ Generación de insights accionables
- ✅ Reportes ejecutivos

## 📂 Estructura del Proyecto

```
premier-league-analysis/
│
├── data/
│   └── 24_25_PL_season.csv          # Dataset original
│
├── notebooks/
│   └── exploratory_analysis.ipynb   # Jupyter notebook con análisis exploratorio
│
├── src/
│   └── premier_league_analysis.py   # Script principal de análisis
│
├── output/
│   ├── pl_analysis_dashboard.png    # Dashboard con visualizaciones
│   ├── league_table.csv             # Tabla de posiciones
│   └── match_statistics.csv         # Estadísticas por partido
│
├── sql/
│   └── analysis_queries.sql         # Queries SQL para análisis
│
├── README.md                         # Este archivo
└── requirements.txt                  # Dependencias del proyecto
```

## 🚀 Instalación y Uso

### Requisitos Previos
```bash
Python 3.8 o superior
pip (gestor de paquetes de Python)
```

### 1. Clonar el Repositorio
```bash
git clone https://github.com/tu-usuario/premier-league-analysis.git
cd premier-league-analysis
```

### 2. Instalar Dependencias
```bash
pip install -r requirements.txt
```

### 3. Ejecutar el Análisis
```bash
python src/premier_league_analysis.py
```

## 📊 Dataset

El dataset contiene información detallada de **380 partidos** de la Premier League 2024-25, incluyendo:

- **Información del partido:** Fecha, hora, equipos, resultado
- **Estadísticas de juego:** Tiros, tiros a puerta, corners, faltas
- **Disciplina:** Tarjetas amarillas y rojas
- **Arbitraje:** Árbitro principal de cada partido

### Variables Principales
| Variable | Descripción | Tipo |
|----------|-------------|------|
| Date | Fecha del partido | datetime |
| HomeTeam | Equipo local | string |
| AwayTeam | Equipo visitante | string |
| Full Time Home Goals | Goles del equipo local | int |
| Full Time Away Goals | Goles del equipo visitante | int |
| Full Time Result | Resultado (Home/Away/Draw) | string |
| Home/Away Shots | Tiros totales | int |
| Home/Away Shots on Target | Tiros a puerta | int |
| Home/Away Yellow/Red Cards | Tarjetas disciplinarias | int |

## 📈 Análisis Realizados

### 1. Análisis Descriptivo
- Estadísticas generales de la temporada
- Distribución de resultados (victorias locales, visitantes, empates)
- Promedio de goles por partido
- Análisis de calidad de datos

### 2. Análisis por Equipo
- **Tabla de posiciones completa**
- Estadísticas de rendimiento (victorias, empates, derrotas)
- Goles a favor y en contra
- Diferencia de goles
- Tasa de efectividad
- Disciplina (tarjetas)

### 3. Análisis de Ventaja Local
- Comparación de resultados como local vs visitante
- Promedio de goles marcados según ubicación
- Impacto del factor campo

### 4. Análisis de Arbitraje
- Estadísticas por árbitro
- Promedio de tarjetas por árbitro
- Promedio de goles en partidos arbitrados

### 5. Análisis Temporal
- Evolución de estadísticas por mes
- Patrones estacionales
- Tendencias de goles a lo largo de la temporada

## 🎨 Visualizaciones

El proyecto genera un dashboard completo con 6 visualizaciones clave:

1. **Top 10 Equipos por Puntos** - Gráfico de barras horizontales
2. **Distribución de Resultados** - Gráfico de pastel
3. **Goles a Favor vs En Contra** - Gráfico de barras comparativas
4. **Distribución de Goles por Partido** - Histograma
5. **Tarjetas por Equipo** - Gráfico de barras apiladas
6. **Efectividad de Tiro** - Gráfico de dispersión

![Dashboard Preview](output/pl_analysis_dashboard.png)

## 💡 Insights Clave

### 🏆 Rendimiento de Equipos
- **Liverpool** lidera la tabla con **84 puntos** y una tasa de victoria del 65.8%
- **Arsenal** tiene la mejor defensa con solo **34 goles recibidos**
- **Liverpool** es el equipo más goleador con **86 goles** (2.26 por partido)

### 🏠 Ventaja Local
- Las victorias locales representan el **40.8%** de los resultados
- Los equipos locales marcan un promedio de **0.09 goles más** que los visitantes
- Solo el **24.5%** de los partidos terminan en empate

### ⚽ Estadísticas Generales
- Promedio de **2.93 goles por partido**
- El partido más goleador fue **Tottenham vs Liverpool (3-6)**
- **Man City** es el equipo más disciplinado con menos tarjetas amarillas

## 🔧 Tecnologías Utilizadas

```python
# Core
Python 3.8+

# Data Processing
pandas==2.0.0
numpy==1.24.0

# Visualization
matplotlib==3.7.0
seaborn==0.12.0

# Utilities
datetime
warnings
```

## 📝 Posibles Extensiones

Este proyecto puede extenderse con:

- [ ] **Machine Learning:** Predicción de resultados de partidos
- [ ] **Dashboard Interactivo:** Implementación con Plotly/Dash o Streamlit
- [ ] **API:** Creación de API REST para consultar estadísticas
- [ ] **Análisis Avanzado:** Clustering de equipos por estilo de juego
- [ ] **Base de Datos:** Migración a PostgreSQL o MongoDB
- [ ] **Automatización:** Pipeline ETL para actualización automática de datos
- [ ] **Web Scraping:** Recolección automática de datos de sitios web

## 🎓 Aprendizajes

Durante este proyecto se desarrollaron las siguientes competencias:

1. **Manipulación de DataFrames complejos** con Pandas
2. **Creación de métricas personalizadas** y KPIs
3. **Diseño de visualizaciones efectivas** para comunicar insights
4. **Programación orientada a objetos** en Python
5. **Documentación técnica profesional**
6. **Análisis estadístico aplicado** a casos reales

## 📧 Contacto

**[Tu Nombre]**
- LinkedIn: [tu-perfil](https://linkedin.com/in/tu-perfil)
- GitHub: [tu-usuario](https://github.com/tu-usuario)
- Email: tu.email@ejemplo.com

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

⭐ Si este proyecto te resultó útil, no olvides darle una estrella!

**Keywords:** Data Analysis, Python, Pandas, Data Visualization, Premier League, Sports Analytics, Data Science, Portfolio Project
