import java.io.*;
import java.util.HashMap;
import java.util.Set;

public class DuplicateValueDetecter {
	

	
	
	public static void main2 (String[] args) throws IOException {
		FileReader fr = new FileReader("C:\\dev\\inthedoors\\demo\\jpgfilelist-v2.txt");
		int c;
		String file = "";
		int line = 1; 
		HashMap<String, String> fileset = new HashMap<String, String>();
		HashMap<String, String> dupset = new HashMap<String, String>();
		while( (c = fr.read()) != -1) {
			if (c == '\n' || c == '\r') {
				if ( ! file.trim().equals("")) {
					file = file.trim();//.toLowerCase();
					if(fileset.containsKey(file)) {
						System.err.println("found duplicats " + file + " " + fileset.get(file) + ":" + Integer.toString(line));
						dupset.put(file, file);
					}
					else
						fileset.put(file, Integer.toString(line));
					//System.out.println (Integer.toString(line) + " " + file);
					file = "";
					line += 1;
			}

                continue;
			}
			file += (char)c;

		}
		System.err.println (fileset.size() );	
		Set<String> keys = dupset.keySet();
		for(String key : keys) 
			System.out.println (key);
	}

}
