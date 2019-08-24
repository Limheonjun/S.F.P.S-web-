package sfps.vo;

public class SensorDataVO {
	String location;
	int temperature;
	int smoke;
	int flame;
	String flame_number;
	String date;
	String time;
	
	public SensorDataVO() {}
	
	public SensorDataVO(SensorDataVO vo) {
		this.location = vo.location;
		this.temperature = vo.temperature;
		this.smoke = vo.smoke;
		this.flame = vo.flame;
		this.flame_number = vo.flame_number;
		this.date = vo.date;
	}
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getTemperature() {
		return temperature;
	}
	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}
	
	public int getFlame() {
		return flame;
	}
	public void setFlame(int flame) {
		this.flame = flame;
	}
	public String getFlame_number() {
		return flame_number;
	}
	public void setFlame_number(String flame_number) {
		this.flame_number = flame_number;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getSmoke() {
		return smoke;
	}
	public void setSmoke(int smoke) {
		this.smoke = smoke;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	
}
