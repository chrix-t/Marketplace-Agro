# 🌾 Agricultura Marketplace

Plataforma de compra y venta de productos agrícolas construida con Next.js, TypeScript y Tailwind CSS.

## 🚀 Características

- ✅ Catálogo de productos agrícolas con categorías
- ✅ Búsqueda y filtrado de productos
- ✅ Páginas de detalle de productos y categorías
- ✅ Sistema de vendedores con calificaciones
- ✅ Diseño responsive y moderno
- ✅ Interfaz intuitiva y fácil de usar

## 🛠️ Tecnologías Utilizadas

- **Next.js 16** - Framework de React
- **TypeScript** - Tipado estático
- **Tailwind CSS 4** - Estilos utilitarios
- **App Router** - Sistema de enrutamiento de Next.js

## 📦 Estructura del Proyecto

```
agricultura-marketplace/
├── app/                    # Páginas y rutas
│   ├── productos/         # Páginas de productos
│   ├── categorias/        # Páginas de categorías
│   └── vender/            # Formulario para vender
├── components/            # Componentes reutilizables
│   ├── Header.tsx
│   ├── Footer.tsx
│   ├── ProductCard.tsx
│   └── CategoryCard.tsx
├── lib/                   # Utilidades y datos
│   └── data.ts           # Datos de ejemplo
└── types/                # Tipos TypeScript
    └── index.ts
```

## 🚦 Comenzar

### Instalación

Las dependencias ya están instaladas. Si necesitas reinstalar:

```bash
npm install
```

### Ejecutar en Desarrollo

```bash
npm run dev
```

Abre [http://localhost:3000](http://localhost:3000) en tu navegador para ver el resultado.

### Compilar para Producción

```bash
npm run build
npm start
```

## 📄 Páginas Disponibles

- **/** - Página principal con productos destacados y categorías
- **/productos** - Listado completo de productos con filtros
- **/productos/[id]** - Detalle de un producto específico
- **/categorias** - Listado de todas las categorías
- **/categorias/[id]** - Productos de una categoría específica
- **/vender** - Formulario para publicar un nuevo producto

## 🎨 Categorías de Productos

1. 🍎 **Frutas** - Frutas frescas de temporada
2. 🥬 **Verduras** - Verduras orgánicas y frescas
3. 🌾 **Granos** - Granos básicos y cereales
4. 🫘 **Legumbres** - Legumbres secas y frescas
5. 🌱 **Semillas** - Semillas para siembra
6. 🌿 **Hierbas** - Hierbas aromáticas y medicinales

## 🔧 Características Técnicas

- Sistema de tipos TypeScript completo para productos agrícolas
- Componentes modulares y reutilizables
- Optimización de imágenes con Next.js Image
- Diseño responsive con Tailwind CSS
- Navegación con Next.js App Router

## 📝 Próximas Mejoras

- [ ] Sistema de autenticación de usuarios
- [ ] Carrito de compras funcional
- [ ] Sistema de pagos
- [ ] Gestión de órdenes
- [ ] Panel de administración para vendedores
- [ ] Sistema de búsqueda avanzada
- [ ] Integración con base de datos
- [ ] Sistema de reseñas y comentarios

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

Desarrollado con ❤️ para conectar productores y compradores agrícolas.
