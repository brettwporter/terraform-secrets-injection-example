export default function Home() {
  return (
    <main className="flex min-h-screen flex-col gap-4 items-start p-24">
      <p>Secret Value 1: {process.env.secret_value_1}</p>
      <p>Secret Value 2: {process.env.secret_value_2}</p>
    </main>
  );
}
