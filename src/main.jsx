import React from "react";
import { createRoot } from "react-dom/client";
import "./styles.css";

function App() {
  return (
    <main className="page">
      <section className="card" aria-labelledby="title">
        <p className="eyebrow">Use Drika</p>
        <h1 id="title">Moda para o seu momento</h1>
        <p className="description">
          Moda feminina, cuidado nos detalhes e atendimento próximo em São José,
          Santa Catarina.
        </p>
        <a className="button" href="tel:+5548984613044">
          Falar com a Use Drika
        </a>
      </section>
    </main>
  );
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
