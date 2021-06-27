require_relative "crypter_md5"


def search_in_file(hashed_val,path,trans,option)

  puts "The programm will try to search in the rainbow table first if not found it will try to use the Transformations file if given" if option
  key, finish =nil
  if path==nil
    puts "no given path...exit code 1 "
    exit 1
  end

  start=Time.now #for more efficeint timing start the timer after declaring the values!.
  #please note that the usage of time.now is inacurate and using brench mark is better!.
  puts "start time is #{start}" if option

  IO.foreach(path) do |line|
    puts "will check if the word: #{line.chomp} matches the given hash value" if option
    if test_password(line.chomp,hashed_val)#use the test method written by the professor in the crypter_md5
      finish=Time.now#we stop the timer when we find a match
      puts "finish time is #{finish}" if option
      key=line
      break
    end
  end

  if key!= nil
    p "found it -> #{key.chomp} in #{finish-start}s"
    exit 0
  else
    puts "\n\rnot found with noraml search in file will try with modifications"
    search_in_file_with_modifications(hashed_val,path,trans,option)
  end
end

def search_in_file_with_modifications(hashed_val,path,trans,option)
  if trans==nil
    puts "no tansformation file has been given!"
    return
  end
  puts "now will try to find it with modifing the words in the file in #{trans}" if option
  key, finish =nil
  start=Time.now

  IO.foreach(path) do |line|

    IO.foreach(trans) do |reg|
      puts "checking the word #{line.chomp} with the modification #{reg.chomp}" if option

      re, replace= reg.split(/\s+/, 3)
      line=line.chomp.gsub(eval(re), replace)

      if test_password(line,hashed_val)
        finish=Time.now
        key=line
        puts "------------------------------------------------------"
        break
      end

    end
    break if key!=nil
  end

  if key!= nil
    puts "found it -> #{key.chomp} in #{finish-start}s"
    exit 0
  else
    puts "even with modifications not found! will try brute-force"
    puts "finish your study, graduate, get married have childern grab a cup of coffe then come back...this gonna take a long Time !" if option

    result, time, password= brute_force_with_repeated_permutation(0,6,('!'..'~').to_a, hashed_val,option)
    puts result==true ? "found in #{time} and its #{password}":"not Found!"
  end
end

def brute_force_with_repeated_permutation(n,limit,chars,hashed_val,option)# TODO: GLOBAL variable would be soo cool for options!! BUT YOU DONT LIKE EM
  puts "checking the passwords of length #{n}" if option
  start=Time.now
  chars.repeated_permutation(n).to_a.each do |e|
    temp = e.join
    return true,"#{Time.now-start}s", temp if test_password(temp,hashed_val)
  end
  if n<limit
    brute_force_with_repeated_permutation(n+1,limit,chars,hashed_val,option)
  end
end

def check_for_verbose
  ARGV[0].casecmp("-v")==0 || ARGV[0].casecmp("-verbose")==0
end

def show_help # the word end is reserved so any word would work!.
puts  <<-END
The program works with the following order:

ruby cracker.rb <OPTION> <Hashed key> <rainbow table> <Transformation file>

list of all avaliable options:
- h or help will show this message
- v or verbose will show extra informations
- crtl+z will terminate the program
  END

end

if __FILE__ == $0

    option=check_for_verbose

    case ARGV.length
    when 0
      puts "add more arguments!."
    when 1
      if (ARGV[0].casecmp("-h")== 0 || ARGV[0].casecmp("-help")==0 )
        show_help
      else
        puts "to show help run the program with the help flag ruby cracker.rb -h or -help"
      end
    when 2
      if option # in case the user entered -v hash
        puts "need wordlist/rainbow Table. please run the program with the right amount of arguments"
        show_help
      else # in this case the user entered hash wordlist
        search_in_file(ARGV[0],ARGV[1],nil,option) ## TODO: PROF, i would use global variable but YOU DONT LIKE THEM EVENTHOUGHT ITS HELPFUL SOMETIMES!
      end
    when 3
      if option # in this case the user entered v hash wordlist
        search_in_file(ARGV[1],ARGV[2],nil,option) ## TODO: PROF, i would use global variable for "option" but YOU DONT LIKE THEM EVENTHOUGHT ITS HELPFUL SOMETIMES!
      else  # in this case the user entered hash wordlist Transformations
        search_in_file(ARGV[0],ARGV[1],ARGV[2],option)
      end
    when 4> #if we have four we dont care how many extra do we have!
        search_in_file(ARGV[1],ARGV[2],ARGV[3],option)
    end
end
