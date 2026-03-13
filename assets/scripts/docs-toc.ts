type TocSection = {
    id: string;
    element: HTMLElement;
    link: HTMLAnchorElement;
};

function setActiveLink(sections: TocSection[], activeId: string): void {
    for (const section of sections) {
        section.link.classList.toggle(
            "docs-toc_link--active",
            section.id === activeId
        );
    }
}

export function initDocsToc(): void {

    console.log("Initializing docs TOC...");

    const tocLinks = Array.from(
        document.querySelectorAll<HTMLAnchorElement>(".docs-toc_link[href^='#']")
    );

    if (tocLinks.length === 0) {
        return;
    }

    const sections: TocSection[] = tocLinks
        .map((link) => {
            const href = link.getAttribute("href");

            if (!href?.startsWith("#")) {
                return null;
            }

            const id = href.slice(1);
            const element = document.getElementById(id);

            if (!(element instanceof HTMLElement)) {
                return null;
            }

            return {
                id,
                element,
                link,
            };
        })
        .filter((section): section is TocSection => section !== null);

    if (sections.length === 0) {
        return;
    }

    let activeId = sections[0].id;

    const observer = new IntersectionObserver(
        (entries) => {
            const visibleEntries = entries
                .filter((entry) => entry.isIntersecting)
                .sort(
                    (a, b) =>
                        a.boundingClientRect.top - b.boundingClientRect.top
                );

            if (visibleEntries.length === 0) {
                return;
            }

            const firstVisible = visibleEntries[0];
            const id = firstVisible.target.getAttribute("id");

            if (!id || id === activeId) {
                return;
            }

            activeId = id;
            setActiveLink(sections, activeId);
        },
        {
            root: null,
            rootMargin: "-20% 0px -65% 0px",
            threshold: 0,
        }
    );

    for (const section of sections) {
        observer.observe(section.element);
    }

    setActiveLink(sections, activeId);

    globalThis.addEventListener("hashchange", () => {
        const hash = globalThis.location.hash.replace("#", "");

        if (!hash) {
            return;
        }

        if (!sections.some((section) => section.id === hash)) {
            return;
        }

        activeId = hash;
        setActiveLink(sections, activeId);
    });
}