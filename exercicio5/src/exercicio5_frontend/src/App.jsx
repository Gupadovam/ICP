import { useState, useEffect } from 'react';
import { createActor, exercicio5_backend } from 'declarations/exercicio5_backend';
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent } from "@dfinity/agent";
import { BrowserRouter as Router, Route, Routes, useNavigate } from "react-router-dom";
import Index from './index';
import Tarefas from './tarefas';

let actorExercicio5Backend = exercicio5_backend;

function AppWrapper() {
  return (
    <Router>
      <App />
    </Router>
  );
}

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const navigate = useNavigate();

  async function login() {
    let authClient = await AuthClient.create();

    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSuccess: async () => {
        const identity = authClient.getIdentity();
        console.log("Principal:", identity.getPrincipal().toText());

        const agent = new HttpAgent({ identity });

        actorExercicio5Backend = createActor(process.env.CANISTER_ID_EXERCICIO5_BACKEND, {
          agent,
        });

        await actorExercicio5Backend.get_principal_client(); // opcional: pega o principal do backend

        setIsLoggedIn(true);
        navigate("/tarefas"); // Redireciona após login
      },
      windowOpenerFeatures: `
        left=${window.screen.width / 2 - 525 / 2},
        top=${window.screen.height / 2 - 705 / 2},
        toolbar=0,location=0,menubar=0,width=525,height=705
      `,
    });
  }

  return (
    <Routes>
      <Route path="/" element={<Index login={login} />} />
      <Route path="/tarefas" element={<Tarefas />} />
    </Routes>
  );
}

export default AppWrapper;
