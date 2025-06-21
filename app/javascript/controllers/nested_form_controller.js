import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"];
  static values = {
    wrapperSelector: String,
    index: Number,
  };

  connect() {
    this.indexValue = this.containerTarget.children.length;
  }

  add(event) {
    event.preventDefault();

    // Получаем шаблон и заменяем индексы
    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      this.indexValue,
    );

    // Создаем новый элемент
    const wrapper = document.createElement("div");
    wrapper.innerHTML = content;

    // Добавляем анимацию появления
    const newItem = wrapper.firstElementChild;
    newItem.style.opacity = "0";
    newItem.style.transform = "translateY(-20px)";

    // Добавляем в контейнер
    this.containerTarget.appendChild(newItem);

    // Анимируем появление
    requestAnimationFrame(() => {
      newItem.style.transition = "all 0.3s ease";
      newItem.style.opacity = "1";
      newItem.style.transform = "translateY(0)";
    });

    // Увеличиваем индекс
    this.indexValue++;

    // Фокусируемся на первом поле нового элемента
    const firstInput = newItem.querySelector("input, select");
    if (firstInput) {
      firstInput.focus();
    }
  }

  remove(event) {
    event.preventDefault();

    const wrapper = event.target.closest(
      this.wrapperSelectorValue || "[data-nested-form-wrapper]",
    );
    const destroyInput = wrapper.querySelector('input[name*="_destroy"]');

    if (destroyInput) {
      // Если это существующая запись, помечаем для удаления
      destroyInput.value = "1";
      wrapper.style.transition = "all 0.3s ease";
      wrapper.style.opacity = "0.5";
      wrapper.style.transform = "scale(0.95)";
      wrapper.querySelector(".fields").style.display = "none";
    } else {
      // Если это новая запись, удаляем из DOM
      wrapper.style.transition = "all 0.3s ease";
      wrapper.style.opacity = "0";
      wrapper.style.transform = "translateX(-100%)";

      setTimeout(() => {
        wrapper.remove();
      }, 300);
    }
  }

  updateIcon(event) {
    const select = event.target;
    const iconPreview = select
      .closest(".link-form-group")
      .querySelector(".icon-preview");

    if (iconPreview) {
      const linkType = select.value;
      const icons = {
        github: "🐙",
        youtube: "🎥",
        demo: "🚀",
        documentation: "📚",
        figma: "🎨",
        linkedin: "💼",
        portfolio: "👤",
        custom: "🔗",
      };

      iconPreview.textContent = icons[linkType] || "🔗";
    }
  }
}
