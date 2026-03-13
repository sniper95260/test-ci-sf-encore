export function initFaq(): void {
    const faqItems = Array.from(document.querySelectorAll<HTMLElement>(".faq-item"));

    if (faqItems.length === 0) {
        return;
    }

    for (const item of faqItems) {
        const button = item.querySelector<HTMLButtonElement>(".faq-item_question");

        if (!(button instanceof HTMLButtonElement)) {
            continue;
        }

        button.addEventListener("click", () => {
            item.classList.toggle("faq-item--open");
        });
    }
}