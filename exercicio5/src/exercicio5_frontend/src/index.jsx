function Index({ isLoggedIn, login, logout }) {
  return (
    <section className="bg-white dark:bg-gray-900">
      <div className="py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16">
        <h1 className="mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
          TO-DO
        </h1>
        <p className="mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 lg:px-48 dark:text-gray-400">
          Controle suas tarefas 100% onchain na ICP!
        </p>

        <div className="mb-6">
          {!isLoggedIn && (
            <button
              id="login"
              onClick={login}
              className="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-white bg-blue-700 hover:bg-blue-800 rounded-lg focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900"
            >
              ENTRAR
              <svg
                className="w-3.5 h-3.5 ml-2 rtl:rotate-180"
                aria-hidden="true"
                fill="none"
                viewBox="0 0 14 10"
              >
                <path
                  stroke="currentColor"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M1 5h12m0 0L9 1m4 4L9 9"
                />
              </svg>
            </button>
          )}

          {isLoggedIn && (
            <button
              id="logout"
              onClick={logout}
              className="inline-flex justify-center items-center py-2 px-4 text-sm font-medium text-white bg-red-600 hover:bg-red-700 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-400 mb-2"
            >
              Logout
            </button>
          )}

          <br />
          <label
            id="principalText"
            className="text-sm text-gray-700 dark:text-gray-300"
          ></label>
        </div>
      </div>
    </section>
  );
}

export default Index;
