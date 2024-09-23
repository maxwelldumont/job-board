<nav {{ $attributes->class([""]) }}>
  <ul class="flex space-x-3 text-slate-700">
    <li>
      <a href="/">Home</a>
    </li>

    @foreach ($links as $label => $link)
      <li>→</li>
      <li>
        <a href="{{ $link }}"> 
          {{ $label }} 
        </a>
      </li>
    @endforeach
  </ul>
</nav>