document.addEventListener('DOMContentLoaded', function () {
    const inputDescElement = document.querySelector('#text');

    if (inputDescElement) {
        const easyMarkdownEditor = new EasyMDE({
            element: inputDescElement,
        });
    }
    const inputDescElement1 = document.querySelector('#desc');

    if (inputDescElement1) {
        const easyMarkdownEditor1 = new EasyMDE({
            element: inputDescElement1,
        });
    }
    const inputDescElement2 = document.querySelector('#bookDescription');

    if (inputDescElement2) {
        const easyMarkdownEditor2 = new EasyMDE({
            element: inputDescElement2,
        });
    }
});

