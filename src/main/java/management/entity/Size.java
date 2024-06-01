package management.entity;
// Generated Dec 14, 2022, 9:49:56 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Size generated by hbm2java
 */
@Entity
@Table(name = "size")
public class Size implements java.io.Serializable {

	private int masize;
	private String tensize;
	private Set<Ctsize> ctsizes = new HashSet<Ctsize>(0);
	
	
	public Size() {
	}


	
	public Size(int masize, String tensize, Set<Ctsize> ctsizes) {
		

		this.masize = masize;
		this.tensize = tensize;
		this.ctsizes = ctsizes;
	}

	@Id

	@Column(name = "MASIZE", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getMasize() {
		return this.masize;
	}

	public void setMasize(int masize) {
		this.masize = masize;
	}

	@Column(name = "TENSIZE", nullable = false, columnDefinition = "nvarchar(100)")
	public String getTensize() {
		return this.tensize;
	}

	public void setTensize(String tensize) {
		this.tensize = tensize;
	}
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "size")
	public Set<Ctsize> getCtsizes() {
		return this.ctsizes;
	}
	public void setCtsizes(Set<Ctsize> ctsizes) {
		this.ctsizes = ctsizes;
	}

	
	

}