package common;

public class FileVO {
		
	 private int id, postid;
	 private String filename, filepath;
	 
	 
	 
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPostid() {
		return postid;
	}
	public void setPostid(int postid) {
		this.postid = postid;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	@Override

	public String toString() {
		return "[filepath=" + filepath + ", filename=" + filename + "]";
   }
	 
	 
		
}
