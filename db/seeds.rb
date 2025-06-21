# Создаем администратора
admin = User.find_or_create_by(email: "admin@devportfolio.com") do |user|
  user.password = "password123"
  user.admin = true
end

puts "✓ Администратор создан: #{admin.email}"

# Создаем примеры проектов
projects_data = [
  {
    title: "E-Commerce Platform",
    description: "Полнофункциональная платформа электронной коммерции с корзиной покупок, системой платежей и административной панелью.",
    detailed_description: "Современная платформа электронной коммерции, построенная с использованием Ruby on Rails и React. Включает в себя систему управления продуктами, корзину покупок, интеграцию с платежными системами, административную панель для управления заказами и пользователями. Реализована система ролей, уведомления по email, поиск и фильтрация товаров.",
    author_name: "Александр Петров",
    technology_stack: "Ruby on Rails, React, PostgreSQL, Redis, Stripe API, Docker",
    links: [
      { title: "Исходный код", url: "https://github.com/user/ecommerce-platform", link_type: "github" },
      { title: "Демо видео", url: "https://youtube.com/watch?v=demo1", link_type: "youtube" },
      { title: "Live демо", url: "https://ecommerce-demo.herokuapp.com", link_type: "demo" },
      { title: "Документация API", url: "https://docs.ecommerce-demo.com", link_type: "documentation" }
    ]
  },
  {
    title: "Task Management System",
    description: "Система управления задачами в стиле Kanban с возможностью работы в команде, уведомлениями и отчетностью.",
    detailed_description: "Веб-приложение для управления проектами и задачами с интерфейсом в стиле Kanban. Позволяет создавать проекты, добавлять участников команды, назначать задачи, отслеживать прогресс. Включает систему уведомлений в реальном времени, генерацию отчетов по продуктивности, интеграцию с календарем.",
    author_name: "Мария Сидорова",
    technology_stack: "Vue.js, Node.js, Express, MongoDB, Socket.io, JWT",
    links: [
      { title: "GitHub Repository", url: "https://github.com/user/task-manager", link_type: "github" },
      { title: "Demo Preview", url: "https://youtube.com/watch?v=demo2", link_type: "youtube" },
      { title: "Try it Live", url: "https://taskmanager-demo.netlify.app", link_type: "demo" },
      { title: "Figma Design", url: "https://figma.com/taskmanager", link_type: "figma" },
      { title: "LinkedIn", url: "https://linkedin.com/in/maria-sidorova", link_type: "linkedin" }
    ]
  },
  {
    title: "Social Media Analytics",
    description: "Аналитическая платформа для социальных сетей с красивыми дашбордами и автоматическими отчетами.",
    detailed_description: "Комплексная система аналитики социальных медиа, которая собирает данные из различных платформ и предоставляет детальную аналитику. Включает интерактивные дашборды с графиками и диаграммами, автоматическое создание отчетов, систему алертов при изменении ключевых метрик, возможность экспорта данных в различных форматах.",
    author_name: "Дмитрий Козлов",
    technology_stack: "React, TypeScript, D3.js, Python, FastAPI, PostgreSQL, Chart.js",
    links: [
      { title: "Source Code", url: "https://github.com/user/social-analytics", link_type: "github" },
      { title: "Feature Demo", url: "https://youtube.com/watch?v=demo3", link_type: "youtube" },
      { title: "Live Demo", url: "https://analytics-demo.vercel.app", link_type: "demo" },
      { title: "Portfolio", url: "https://dmitry-kozlov.dev", link_type: "portfolio" }
    ]
  },
  {
    title: "AI Chat Assistant",
    description: "Интеллектуальный чат-бот с использованием машинного обучения для автоматизации клиентской поддержки.",
    detailed_description: "Умный чат-ассистент, использующий технологии обработки естественного языка для автоматизации клиентской поддержки. Система способна понимать контекст разговора, предоставлять релевантные ответы, эскалировать сложные вопросы живому оператору. Включает админ-панель для обучения бота, аналитику диалогов и интеграцию с CRM системами.",
    author_name: "Анна Волкова",
    technology_stack: "Python, TensorFlow, Flask, React, PostgreSQL, OpenAI API, Docker",
    links: [
      { title: "GitHub Repo", url: "https://github.com/user/ai-chat-bot", link_type: "github" },
      { title: "Demo Video", url: "https://youtube.com/watch?v=demo4", link_type: "youtube" },
      { title: "Try Demo", url: "https://chatbot-demo.com", link_type: "demo" },
      { title: "Technical Docs", url: "https://ai-chat-docs.com", link_type: "documentation" },
      { title: "Research Paper", url: "https://research.ai-chat.com/paper.pdf", link_type: "custom", icon: "📄" }
    ]
  },
  {
    title: "Cryptocurrency Tracker",
    description: "Трекер криптовалют в реальном времени с портфолио, алертами и техническим анализом.",
    detailed_description: "Приложение для отслеживания криптовалютного рынка в реальном времени. Позволяет создавать личное портфолио, устанавливать ценовые алерты, просматривать графики с техническими индикаторами, получать новости рынка. Включает калькулятор прибыли/убытков, сравнение производительности различных активов, экспорт данных для налоговой отчетности.",
    author_name: "Иван Морозов",
    technology_stack: "Next.js, TypeScript, TradingView API, WebSocket, Tailwind CSS, Prisma",
    links: [
      { title: "Source Code", url: "https://github.com/user/crypto-tracker", link_type: "github" },
      { title: "App Demo", url: "https://youtube.com/watch?v=demo5", link_type: "youtube" },
      { title: "Live App", url: "https://cryptotrack-demo.app", link_type: "demo" },
      { title: "Design Files", url: "https://figma.com/cryptotracker", link_type: "figma" },
      { title: "Mobile App", url: "https://apps.apple.com/cryptotrack", link_type: "custom", icon: "📱" },
      { title: "Blog Post", url: "https://medium.com/@ivan/crypto-tracker", link_type: "custom", icon: "✍️" }
    ]
  }
]

projects_data.each do |project_data|
  links_data = project_data.delete(:links)

  project = admin.projects.find_or_create_by(title: project_data[:title]) do |p|
    p.assign_attributes(project_data)
  end

  # Добавляем ссылки к проекту
  if links_data && project.project_links.empty?
    links_data.each_with_index do |link_data, index|
      project.project_links.create!(
        title: link_data[:title],
        url: link_data[:url],
        link_type: link_data[:link_type],
        icon: link_data[:icon],
        position: index
      )
    end
  end

  puts "✓ Проект создан: #{project.title} (#{project.project_links.count} ссылок)"
end

puts "\n🚀 База данных заполнена!"
puts "📧 Email администратора: admin@devportfolio.com"
puts "🔑 Пароль: password123"
puts "\n🔗 Типы ссылок доступны:"
ProjectLink::LINK_TYPES.each do |type, config|
  puts "  #{config[:icon]} #{type.humanize}"
end
