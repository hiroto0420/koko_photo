document.addEventListener("turbo:load", () => {
  const MAX_FILES = 10

  const input = document.getElementById("image-input");
  const preview = document.getElementById("image-preview");

  if(!input || !preview) return;

  let selectedFiles = [];

  input.addEventListener("click", () => {
    input.value = null;
  });

  input.addEventListener("change", () => {
    const newFiles = Array.from(input.files);

    if (selectedFiles.length + newFiles.length > MAX_FILES) {
      alert(`画像は最大${MAX_FILES}枚までです`);
      return;
    }

    selectedFiles = selectedFiles.concat(newFiles);

    const dataTransfer = new DataTransfer();
    selectedFiles.forEach(file => dataTransfer.items.add(file));
    input.files = dataTransfer.files;

    preview.innerHTML = "";

    selectedFiles.forEach((file, index) => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const wrapper = document.createElement("div");
        wrapper.className = "relative";

        const img = document.createElement("img");
        img.src = e.target.result;
        img.className = "w-full h-32 object-cover rounded-lg border";
        if (index === 0) {
          img.classList.add("ring-2", "ring-blue-500");
        }
        wrapper.appendChild(img);
        preview.appendChild(wrapper)
      };

      reader.readAsDataURL(file)
    });
  });
});