set breakpoint pending on
set disassembly-flavor intel
set debuginfod enabled off
set follow-fork-mode child
define hook-next
  refresh
end

define hook-step
  refresh
end

define c 
  continue
  refresh
end

define n
  next
  refresh
end
