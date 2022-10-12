// Clase abstracta = method x() {}
// La clase abstracta permite no instanciar esa clase.

class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method acelerar(cuanto) {velocidad = 100000.min(velocidad + cuanto)}
	method desacelerar(cuanto) {velocidad = 0.max(velocidad - cuanto)}
	method irHaciaElSol() {direccion = 10}
	method escaparDelSol() {direccion = -10}
	method ponerseParaleloAlSol() {direccion = 0}
	method acercarseUnPocoAlSol() {direccion = 10.min(direccion + 1)}
	method alejarseUnPocoDelSol() {direccion = 10.max(direccion - 1)}
	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method cargarCombustible(cuanto) {combustible += cuanto}
	method descargarCombustible(cuanto) {combustible = 0.max(combustible - cuanto)}
	// Método abstracto
	method adicionalTranquilidad()
	method estaTranquila() = 
	combustible >= 4000 and velocidad <= 12000 and self.adicionalTranquilidad()
}

class NaveBaliza inherits NaveEspacial {
	var baliza = "verde"
	
	method baliza() = baliza
	method cambiarColorDeBaliza(colorNuevo) {baliza = colorNuevo}
	override method prepararViaje() {
		// super(). Realiza las acciones del prepararViaje() de la superclase NaveEspacial.
		super()
		baliza = "verde"
		self.ponerseParaleloAlSol()
	}
	override method adicionalTranquilidad() = baliza != "rojo"
}

class NaveDePasajeros inherits NaveEspacial {
	var property pasajeros = 0
	var property racionesDeComida = 0
	var property racionesDeBebida = 0
	
	override method prepararViaje() {
		// super(). Realiza las acciones del prepararViaje() de la superclase NaveEspacial.
		super()
		racionesDeComida +=  4 * pasajeros
		racionesDeBebida += 6 * pasajeros
		self.acercarseUnPocoAlSol()
	}
	override method adicionalTranquilidad() = true
}

class NaveDeCombate inherits NaveEspacial {
	var estaInvisible = false
	var estaVisible = true
	var misilesDesplegados = false
	const mensajesEmitidos = []
	
	method ponerseVisible() {estaVisible = true}
	method ponerseInvisible() {estaInvisible = true}
	method estaInvisible() = estaInvisible
	method desplegarMisiles() {misilesDesplegados = true}
	method replegarMisiles() {misilesDesplegados = false}
	method misilesDesplegados() = misilesDesplegados
	method emitirMensaje(mensaje) {mensajesEmitidos.add(mensaje)}
	method mensajesEmitidos() = mensajesEmitidos
	method primerMensajeEmitido() {
		// Mensaje de error.
		if(mensajesEmitidos.isEmpty()) self.error("La lista está vacía")
		return mensajesEmitidos.first()
	}
	method ultimoMensajeEmitido() {
		// Mensaje de error.
		if(mensajesEmitidos.isEmpty()) self.error("La lista está vacía")
		return mensajesEmitidos.last()
		}
	method esEscueta() = mensajesEmitidos.all({ m => m.size() < 30 })
	method emitioMensaje(mensaje)
	override method prepararViaje() {
		// super(). Realiza las acciones del prepararViaje() de la superclase NaveEspacial.
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
		self.acelerar(15000)
	}
	override method adicionalTranquilidad() = not misilesDesplegados
}

class NaveHospital inherits NaveDePasajeros {
	var property quirofanosPreparados = false
	
	override method adicionalTranquilidad() = not quirofanosPreparados
}

class NaveCombateSigilosa inherits NaveDeCombate {
	override method adicionalTranquilidad() = super() and not self.estaInvisible()
}