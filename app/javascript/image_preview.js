document.addEventListener("turbo:load", () => {
  const input = document.getElementById("image-input");
  const preview = document.getElementById("image-preview");

  if(!input || !preview) return;

  let selectedFiles = [];

  input.addEventListener("change", () => {
    selectedFiles = selectedFiles.concat(Array.from(input.files));

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