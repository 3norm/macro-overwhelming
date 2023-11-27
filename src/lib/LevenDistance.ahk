LD(Source, Target) {
   if Source == Target
      return 0
   Source := StrSplit(Source)
   Target := StrSplit(Target)
   if !Source.Length
      return Target.Length
   if !Target.Length
      return Source.Length
   
   v0 := [], v1 := []
   Loop Target.Length + 1
      v0.Push(A_Index - 1)
   v1.Length := v0.Length
   
   for Index, SourceChar in Source {
      v1[1] := Index
      for TargetChar in Target
         v1[A_Index + 1] := Min(v1[A_Index] + 1, v0[A_Index + 1] + 1, v0[A_Index] + (SourceChar !== TargetChar))
      Loop Target.Length + 1
         v0[A_Index] := v1[A_Index]
   }
   return v1[Target.Length + 1]
}