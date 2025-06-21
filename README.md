# 🚀 DevPortfolio - Репозиторий проектов студентов

Веб-приложение на Ruby on Rails для демонстрации студенческих проектов с современным дизайном в стиле программирования и динамическими ссылками.

## 📋 Содержание

- [Инструкции по запуску проекта](#-инструкции-по-запуску-проекта)
- [Описание лабораторной работы](#-описание-лабораторной-работы)
- [Краткая документация](#-краткая-документация)
- [Примеры использования](#-примеры-использования)
- [Контрольные вопросы](#-контрольные-вопросы)
- [Список источников](#-список-источников)
- [Дополнительные аспекты](#-дополнительные-аспекты)

## 🛠️ Инструкции по запуску проекта

### Предварительные требования

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **Node.js**: 18+ (для JavaScript зависимостей)
- **PostgreSQL**: 12+
- **Git**: для клонирования репозитория

### Установка и настройка

1. **Клонирование репозитория**
   ```bash
   git clone https://github.com/gugulen0k/web_exam.git
   cd web_exam
   ```

2. **Установка зависимостей**
   ```bash
   # Ruby зависимости
   bundle install

   # JavaScript зависимости (опционально)
   yarn install
   ```

3. **Настройка базы данных**
   ```bash
   # Создание базы данных
   rails db:create

   # Добавление возможности загружать медиа файлы в БД
   rails active_storage:install

   # Выполнение миграций
   rails db:migrate

   # Загрузка тестовых данных
   rails db:seed
   ```

4. **Запуск приложения**
   ```bash
   # Запуск в режиме разработки
   bin/dev

   # Или альтернативно
   rails server
   ```

5. **Доступ к приложению**
   - Откройте браузер и перейдите по адресу: `http://localhost:3000`
   - Для входа в админ-панель используйте:
     - **Email**: `admin@devportfolio.com`
     - **Пароль**: `password123`

## 📚 Описание лабораторной работы

### Цель работы

Разработать веб-приложение "Репозиторий проектов студентов" с использованием фреймворка Ruby on Rails, реализующее систему управления портфолио студенческих проектов с современным интерфейсом и административными функциями.

### Задачи

1. **Система аутентификации**
   - Реализация входа только для администраторов
   - Защита административных функций

2. **Управление проектами**
   - Создание, редактирование и удаление проектов
   - Загрузка множественных изображений
   - Система динамических ссылок (GitHub, YouTube, Demo и др.)

3. **Пользовательский интерфейс**
   - Адаптивный дизайн
   - Карточки проектов с кратким описанием
   - Детальные страницы со слайдером изображений

### Технические требования

- **Фреймворк**: Ruby on Rails 8.0
- **База данных**: PostgreSQL
- **Стили**: Tailwind CSS
- **JavaScript**: Stimulus (Hotwire)
- **Файлы**: Active Storage
- **Аутентификация**: bcrypt

## 📖 Краткая документация

### Модели данных

#### User (Пользователь)
```ruby
- email: string, unique, not null
- password_digest: string, not null
- admin: boolean, default: false
```

#### Project (Проект)
```ruby
- title: string, not null
- description: text
- detailed_description: text
- author_name: string, not null
- technology_stack: string
- user_id: references User
```

#### ProjectLink (Ссылка проекта)
```ruby
- project_id: references Project
- title: string, not null
- url: string, not null
- link_type: string (github, youtube, demo, etc.)
- icon: string (custom emoji)
- position: integer
```

#### ProjectImage (Изображение проекта)
```ruby
- project_id: references Project
- position: integer
- image: attached file (Active Storage)
```

### Основные маршруты

```ruby
# Аутентификация
GET    /login           # Форма входа
POST   /login           # Обработка входа
DELETE /logout          # Выход

# Проекты
GET    /                # Главная страница (список проектов)
GET    /projects/new    # Форма создания проекта
POST   /projects        # Создание проекта
GET    /projects/:id    # Просмотр проекта
GET    /projects/:id/edit # Форма редактирования
PATCH  /projects/:id    # Обновление проекта
DELETE /projects/:id    # Удаление проекта
```

### Система динамических ссылок

Приложение поддерживает 8 типов ссылок:

| Тип | Иконка | Цвет | Назначение |
|-----|--------|------|------------|
| `github` | 🐙 | Серый | Репозитории кода |
| `youtube` | 🎥 | Красный | Демо видео |
| `demo` | 🚀 | Синий | Живые демо |
| `documentation` | 📚 | Желтый | Документация |
| `figma` | 🎨 | Фиолетовый | Дизайн макеты |
| `linkedin` | 💼 | Голубой | Профили LinkedIn |
| `portfolio` | 👤 | Зеленый | Личные сайты |
| `custom` | 🔗 | Серый | Кастомные ссылки |

## 💡 Примеры использования

### 1. Создание нового проекта

```ruby
# В контроллере
def create
  @project = current_user.projects.build(project_params)

  if @project.save
    handle_image_uploads
    redirect_to @project, notice: "Проект успешно создан!"
  else
    render :new
  end
end

private

def project_params
  params.require(:project).permit(:title, :description, :detailed_description,
                                 :author_name, :technology_stack,
                                 project_links_attributes: [:id, :title, :url,
                                 :link_type, :icon, :position, :_destroy])
end
```

### 2. Динамическое добавление ссылок (JavaScript)

```javascript
// app/javascript/controllers/nested_form_controller.js
add(event) {
  event.preventDefault()

  const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, this.indexValue)
  const wrapper = document.createElement('div')
  wrapper.innerHTML = content

  const newItem = wrapper.firstElementChild
  newItem.style.opacity = '0'
  newItem.style.transform = 'translateY(-20px)'

  this.containerTarget.appendChild(newItem)

  requestAnimationFrame(() => {
    newItem.style.transition = 'all 0.3s ease'
    newItem.style.opacity = '1'
    newItem.style.transform = 'translateY(0)'
  })

  this.indexValue++
}
```

### 3. Отображение проекта с ссылками

```erb
<!-- Пример карточки проекта -->
<div class="bg-gray-800 border border-green-500/30 rounded-lg p-6">
  <h3 class="text-xl font-semibold text-white">
    <span class="text-green-400">function</span> <%= project.title %>()
  </h3>

  <!-- Предварительный просмотр ссылок -->
  <% if project.project_links.any? %>
    <div class="flex items-center space-x-2 text-xs">
      <span class="text-gray-500">links:</span>
      <% project.project_links.limit(4).each do |link| %>
        <span class="text-lg" title="<%= link.title %>">
          <%= link.display_icon %>
        </span>
      <% end %>
    </div>
  <% end %>
</div>
```

### 4. Слайдер изображений

```erb
<!-- Слайдер с навигацией -->
<div id="image-slider" class="relative">
  <div class="w-full h-96 bg-gray-800 rounded-lg overflow-hidden">
    <% @images.each_with_index do |image, index| %>
      <div class="slide <%= 'active' if index == 0 %>"
           style="<%= 'opacity: 0;' if index != 0 %>">
        <%= image_tag image.image, class: "w-full h-full object-cover" %>
      </div>
    <% end %>
  </div>

  <!-- Индикаторы слайдов -->
  <div class="flex justify-center space-x-2 mt-4">
    <% @images.each_with_index do |_, index| %>
      <button onclick="currentSlide(<%= index + 1 %>)"
              class="slide-indicator w-3 h-3 rounded-full">
      </button>
    <% end %>
  </div>
</div>
```

### 5. Примеры CSS стилей

```css
/* Анимация печати */
@keyframes typing {
  from { width: 0 }
  to { width: 100% }
}

.typing-animation {
  overflow: hidden;
  border-right: 3px solid #10b981;
  animation: typing 3.5s steps(40, end);
}

/* Эффект glitch для заголовков */
.glitch::before,
.glitch::after {
  content: attr(data-text);
  position: absolute;
  animation: glitch-anim 0.3s infinite linear alternate-reverse;
}

/* Стили для разных типов ссылок */
.link-github { border-color: rgba(107, 114, 128, 0.5); }
.link-youtube { border-color: rgba(239, 68, 68, 0.5); }
.link-demo { border-color: rgba(59, 130, 246, 0.5); }
```

### Скриншоты

<p align="center">
   <img alt="main-page-unauthorized" src="https://github.com/user-attachments/assets/715b38da-5f2f-4766-a2f4-5c1e0245404a" width="800">
   <br/>
   <em>Главная страница (Неавторизованный пользователь)</em>
</p>

<br/>

<p align="center">
   <img alt="main-page-authorized" src="https://github.com/user-attachments/assets/e388974e-9ca9-437f-a7c8-0e59748aaff5" width="800">
   <br/>
   <em>Главная страница (Авторизованный пользователь/Админ)</em>
</p>

<br/>

<p align="center">
   <img alt="authorization-page" src="https://github.com/user-attachments/assets/cbd75ee2-ba23-4cbd-8938-bfac7eb5eab6" width="800">
   <br/>
   <em>Страница авторизации</em>
</p>

<br/>

<p align="center">
   <img alt="project-info-page" src="https://github.com/user-attachments/assets/56659d46-9854-4b72-a4e2-bf3c7fd7fe99" width="800">
   <br/>
   <em>Подробная информация о проекте</em>
</p>

<br/>

<p align="center">
   <img alt="change-project-info-page" src="https://github.com/user-attachments/assets/11197a41-c071-4a4f-b947-da11775cc7bd" width="800">
   <br/>
   <em>Изменения данных о проекте</em>
</p>

## 📚 Список источников

### Документация и официальные ресурсы

1. **Ruby on Rails Guides** - https://guides.rubyonrails.org/
   - Getting Started with Rails
   - Active Record Basics
   - Action Controller Overview
   - Layouts and Rendering

2. **Ruby Documentation** - https://ruby-doc.org/
   - Ruby 3.4.4 Core Documentation
   - Standard Library Reference

3. **Rails API Documentation** - https://api.rubyonrails.org/
   - Classes and Modules Reference
   - Method Documentation

### Фреймворки и библиотеки

4. **Tailwind CSS** - https://tailwindcss.com/
   - Utility Classes Reference
   - Responsive Design
   - Dark Mode Implementation

5. **Stimulus (Hotwire)** - https://stimulus.hotwired.dev/
   - Handbook and Reference
   - Controller Lifecycle
   - Targets and Actions

6. **Active Storage** - https://guides.rubyonrails.org/active_storage_overview.html
   - File Upload and Processing
   - Direct Uploads
   - Image Variants

### Дизайн и UX

7. **Google Fonts** - https://fonts.google.com/
   - Fira Code (Monospace font)
   - Inter (Sans-serif font)

8. **CSS Animations** - https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Animations
   - Keyframes and Transitions
   - Animation Properties

### Безопасность

9. **Rails Security Guide** - https://guides.rubyonrails.org/security.html
   - CSRF Protection
   - SQL Injection Prevention
   - XSS Protection

10. **bcrypt Documentation** - https://github.com/bcrypt-ruby/bcrypt-ruby
    - Password Hashing
    - Authentication Implementation

### Дополнительные ресурсы

13. **MDN Web Docs** - https://developer.mozilla.org/
    - JavaScript ES6+ Features
    - Web APIs and DOM Manipulation

14. **GitHub** - https://github.com/
    - Open Source Projects
    - Best Practices and Examples

15. **Stack Overflow** - https://stackoverflow.com/
    - Community Solutions
    - Common Problems and Fixes
