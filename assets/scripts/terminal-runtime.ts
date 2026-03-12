type TerminalLine = {
    text: string;
    isSuccess?: boolean;
};

const terminalLines: TerminalLine[] = [
    { text: "booting swat..." },
    { text: "loading modules..." },
    { text: "initializing assets..." },
    { text: "typescript runtime ready !", isSuccess: true },
];

const TYPE_DELAY_MS = 28;
const DELETE_DELAY_MS = 18;
const LINE_DELAY_MS = 350;
const LOOP_PAUSE_MS = 1800;
const BETWEEN_DELETE_LINES_MS = 120;

function wait(ms: number): Promise<void> {
    return new Promise((resolve) => {
        globalThis.setTimeout(resolve, ms);
    });
}

async function typeText(element: HTMLElement, text: string, delayMs: number): Promise<void> {
    element.textContent = "";

    for (const char of text) {
        element.textContent += char;
        await wait(delayMs);
    }
}

async function deleteText(element: HTMLElement, delayMs: number): Promise<void> {
    const currentText = element.textContent ?? "";

    for (let index = currentText.length; index >= 0; index--) {
        element.textContent = currentText.slice(0, index);
        await wait(delayMs);
    }
}

function createTerminalLine(line: TerminalLine): {
    lineElement: HTMLDivElement;
    textElement: HTMLSpanElement;
} {
    const lineElement = document.createElement("div");
    lineElement.className = "typescript-runtime_line";

    if (line.isSuccess) {
        lineElement.classList.add("typescript-runtime_line--success");
    }

    const promptElement = document.createElement("span");
    promptElement.className = "typescript-runtime_prompt";
    promptElement.textContent = ">";

    const textElement = document.createElement("span");
    textElement.className = "typescript-runtime_text";

    lineElement.appendChild(promptElement);
    lineElement.appendChild(textElement);

    return { lineElement, textElement };
}

async function animateTerminal(terminal: HTMLElement, lines: TerminalLine[]): Promise<void> {
    terminal.innerHTML = "";

    for (const line of lines) {
        const { lineElement, textElement } = createTerminalLine(line);

        terminal.appendChild(lineElement);

        textElement.classList.add("typescript-runtime_text--typing");
        await typeText(textElement, line.text, TYPE_DELAY_MS);
        textElement.classList.remove("typescript-runtime_text--typing");

        await wait(LINE_DELAY_MS);
    }
}

async function clearTerminalSmoothly(terminal: HTMLElement): Promise<void> {
    const lineElements = Array.from(
        terminal.querySelectorAll<HTMLElement>(".typescript-runtime_line")
    ).reverse();

    for (const lineElement of lineElements) {
        const textElement = lineElement.querySelector<HTMLElement>(".typescript-runtime_text");

        if (!textElement) {
            lineElement.remove();
            continue;
        }

        textElement.classList.add("typescript-runtime_text--typing");
        await deleteText(textElement, DELETE_DELAY_MS);
        textElement.classList.remove("typescript-runtime_text--typing");

        await wait(BETWEEN_DELETE_LINES_MS);
        lineElement.remove();
    }
}

async function loopTerminal(terminal: HTMLElement, lines: TerminalLine[]): Promise<void> {
    while (true) {
        await animateTerminal(terminal, lines);
        await wait(LOOP_PAUSE_MS);
        await clearTerminalSmoothly(terminal);
        await wait(250);
    }
}

export function initTerminalRuntime(): void {
    const terminal = document.getElementById("typescript-runtime-terminal");

    if (!(terminal instanceof HTMLElement)) {
        return;
    }

    void loopTerminal(terminal, terminalLines);
}