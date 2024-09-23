<x-layout>
  <x-breadcrumbs class="mb-4"
  :links="['Jobs' => route('jobs.index')]"
> </x-breadcrumbs>

<x-card class="mb-4 text-sm">
  <div class="mb-4 grid grid-cols-2 gap-4">
    <div>
      <div class="mb-1 font-semibold">Search</div>
      <x-text-input name="search" value="" placeholder="Search for any text"></x-text-input>
    </div>
    <div>
      <div class="mb-1 font-semibold">Salary</div>
      <div class="flex space-x-2">
        <x-text-input name="min_salary" value="" placeholder="from"></x-text-input>
        <x-text-input name="max_salary" value="" placeholder="to"></x-text-input>
      </div>
    </div>
    <div>3</div>
    <div>4</div>
  </div>
</x-card>
  @foreach ($jobs as $job)
    {{-- <x-card class="mb-3"> --}}
      <x-job-card class="mb-4" :job="$job">
        <div>
          <x-link-button :href="route('jobs.show', ['job'=>$job])">
            Show
          </x-link-button>
        </div>
      </x-job-card>

    {{-- </x-card> --}}
  @endforeach
</x-layout>