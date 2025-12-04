cat << EOF 
--------------------------------------------------------------------------------------------
                  Welcome to the Manual-Curation Tutorial by Sanger's GRIT
--------------------------------------------------------------------------------------------
                      First, activate your env (if not already active)!       
                                  "conda activate rapid"             
--------------------------------------------------------------------------------------------
                              Now you can actually use things!      
--------------------------------------------------------------------------------------------

 This Codespace contains everything you need for the Manual-Curation session, including:
  - Test data in ./test_data & ./rapid-curation-main-test_data
  - PretextView
  - agp-tpf-utils scripts accessed by the commands:
    - asm-format
      Parses and reformats AGP and TPF files, converting into either format.

    - find-overlaps
      Finds overlapping entries within AGP or TPF assembly files. Useful for debugging.

    - pretext-to-asm
      Takes the AGP file output by PretextView and the input assembly (usually FASTA), 
      and produces an output assembly in FASTA and AGP formats.
 
 Run PretextView it self with:              "./PretextView &"

 Access the Desktop via the ports tab! If it requests a password, it is "password".

 The & will make life easier, and try to run it in the VScode window if possible, 
 this will stop any issues with time out.
--------------------------------------------------------------------------------------------

                                  Enjoy the session!!!

--------------------------------------------------------------------------------------------

EOF
