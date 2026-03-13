export function initFaq(): void {
    const faqItems = Array.from(document.querySelectorAll<HTMLElement>(".faq-item"));

    if (faqItems.length === 0) {
        return;
    }

    for (const item of faqItems) {
        const button = item.querySelector<HTMLButtonElement>(".faq-item_question");
        const answer = item.querySelector<HTMLElement>(".faq-item_answer");

        if (!(button instanceof HTMLButtonElement) || !(answer instanceof HTMLElement)) {
            continue;
        }

        const answerId = answer.id || `faq-answer-${Math.random().toString(36).slice(2, 10)}`;
        answer.id = answerId;

        button.setAttribute("aria-controls", answerId);
        button.setAttribute("aria-expanded", item.classList.contains("faq-item--open") ? "true" : "false");

        button.addEventListener("click", () => {
            const isOpen = item.classList.toggle("faq-item--open");
            button.setAttribute("aria-expanded", isOpen ? "true" : "false");
        });
    }
}
