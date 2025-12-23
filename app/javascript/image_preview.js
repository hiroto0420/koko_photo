document.addEventListener("turbo:load", () => {
  const input = document.getElementById("image-input");
  const preview = document.getElementById("image-preview");

  if(!input) return;

  input.addEventListener("change", () => {
    preview.innerHTML = "";

    Array.from(input.files).forEach(file => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.style.maxWidth = "200px";
        img.style.marginRight = "10px";
        preview.appendChild(img);
      };

      reader.readAsDataURL(file)
    });
  });
});