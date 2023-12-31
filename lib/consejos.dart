import 'dart:math';

class ConsejosProvider {
  static final List<String> _consejos = [
    "Anotar tus tareas puede ayudar a organizar tus pensamientos y priorizar mejor tus actividades",
    "Puedes dedicar unos minutos al día a ejercicios de atención plena para mejorar tu concentración y reducir estrés",
    "Divide tus sesiones de estudio en bloques de tiempo con objetivos específicos para evitar la sobrecarga de información",
    "Se conoce como 'Scroll Infinito' al acto de consumir indefinidamente contenido en apps como Instagram, Facebook, o Tiktok, y es altamente nocivo",
    "Está demostrado que el Scroll Infinito reduce gradualmente el promedio de tiempo de atención sostenida de una persona",
    "El cerebro humano está diseñado para hacer una sola cosa a la vez, el 'Multitask' sólo es alternar esa atención por lapsos cortos",
    "La plasticidad cerebral es un factor clave de la capacidad de aprendizaje de los seres humanos, y esta nunca desaparece",
    "El cerebro humano se adapta a lo que consume, esto puede mejorar, o reducir su rendimiento",
    "Si no puedes parar de bajar en una app, el primer paso es darte cuenta del bucle en el que has entrado",
    "Existe un máximo de cosas que podemos hacer antes de sentirnos fatigados, ese máximo puede aumentar según nuestros hábitos",
    "Puedes forzarte a intentar hacer ese algo que llevas aplazando tanto tiempo, por sólo 5 minutos, y después no te costará tanto",
    "Pocas cosas son tan satisfactorias como el trabajo completado, ¿No crees?",
    "Los mejores lugares para enfocarse en algo, son tranquilos, bien iluminados, y organizados",
    "Concentrarse en una sola tarea a la vez mejora la eficiencia y la calidad del trabajo. La multitarea puede disminuir la atención y aumentar los errores.",
    "Explica lo que estás estudiando con tus propias palabras, como si se lo enseñaras a alguien más. Esto puede ayudar a aclarar conceptos",
    "Durante los descansos, realiza actividades físicas ligeras como estiramiento o caminata corta. Esto puede mejorar la concentración al regresar al estudio.",
    "Aunque suene gracioso, imaginarse a uno mismo completando tareas con éxito puede aumentar la motivación y el enfoque.",
    "Desactiva las notificaciones innecesarias en dispositivos digitales para reducir las distracciones",
    "Establece metas claras. Definir objetivos específicos para cada sesión de estudio puede ayudar a enfocarse y proporcionar un sentido de logro.",
    "No es tan fácil dejar de procrastinar si nuestra salud mental no está en óptimas condiciones",
    "Vigila qué tipo de interrupciones recibes, así puedes actuar conforme a ello",
    "\"Cada paso es uno menos\"",
    "Haz el trabajo duro, especialmente cuando no te apetezca",
    "Pregúntate si lo que estás haciendo ahora mismo es útil, reparador, o inútil",
    "Es muy importante tomarse un descanso",
    "Para algunos, el trabajo agotador puede derivar en un gran placer",
    "\"Los que buscan mejorar, mejoran\"",
    "Empieza con las tareas más difíciles o importantes cuando tu energía y concentración estén en su punto máximo",
    "Al leer, haz anotaciones, subraya o resume lo leído para mantener un nivel alto de compromiso y enfoque.",
    "Crear mapas mentales para organizar ideas puede ayudar a visualizar y conectar mejor la información, mejorando así la retención.",
    "Estudiar en un lugar asociado con el sueño, como la cama puede disminuir la concentración. Es mejor tener un área dedicada sólo al estudio o al trabajo",
    "Busca la manera de hacer disfrutables tus responsabilidades, así es menos probable que pierdas el foco en esta",
    "Cuando te concentras, este estado no se adquiere de golpe, sino de manera gradual mientras trabajas, desde una atención superficial, hasta una profunda",
    "La atención es dinámica, no hay nada de malo en que los niveles de esta varíen",
    "El sistema nervioso responde y se adapta de acuerdo a la experiencia y hábitos de la persona. Lo que repetimos se hace más fácil con el tiempo",
    "Si te encuentras en un descanso, tómate un momento para descomprimir tu cerebro: No pensando en nada concreto",
    "El formato de videos cortos (Shorts, reels, TikTok, etc.) está diseñado para disparar tu dopamina y los sigas consumiendo indefinidamente",
    "La mayoría de las veces es más práctico dividir el trabajo grande en pequeñas tareas",
    "La disciplina es más confiable que la motivación",
    "\"Nada se construyó sin poner el primer ladrillo\"",
    "Antes de comenzar una tarea, dedica tres minutos a planificar cómo vas a abordarla. Esto ayuda a establecer un enfoque claro.",
    "Mantener un horario de estudio o trabajo regular ayuda a entrenar tu cerebro para concentrarse mejor en esos momentos específicos.",
    "Motívate estableciendo pequeñas recompensas después de completar ciertas tareas o sesiones de estudio.",
    "Tomar notas a mano, en lugar de teclearlas, puede mejorar la retención y el enfoque en el material, aunque esto depende de los gustos personales",
    "Usa metáforas y analogías. Comprender y recordar conceptos complejos es más fácil cuando los asocias con algo familiar.",
    "¿Has escuchado de la Mnemotecnia? Es una técnica ampliamente utilizada para la memorización de datos",
    "Llevar un registro diario de tus logros puede proporcionarte un sentido de progreso y motivación.",
    "Si te gana la tentación de distraerte, puedes usar aplicaciones para bloquear aplicaciones, funcionalidades, o sitios web",
    "Usa tableros de visión o mapas conceptuales para visualizar metas y procesos, lo que puede ayudar a mantener el enfoque en los objetivos a largo plazo.",
    "Si una tarea toma menos de dos minutos en completarse, hazla de inmediato. Esto ayuda a reducir la acumulación de tareas pequeñas.",
    "Regularmente evalúa y ajusta tus métodos de estudio según su efectividad. Lo que funciona bien para otros puede no ser lo mejor para ti.",
    "Limita el número de decisiones triviales que debes tomar cada día para guardar energía mental para tareas más importantes.",
    "Vigila el número de estímulos que recibes a la vez, la sobreestimulación cerebral es perniciosa para nuestra capacidad de enfoque",
    "Si te diriges a un objetivo personal, es muy útil marcar una hoja de ruta que seguir",
    "Alterna entre diferentes métodos de estudio (como lectura, resúmenes, mapas mentales) para mantener el interés y la eficacia.",
    "La técnica Pomodoro es esencialmente útil para tareas mecánicas, cortas, o que se pueden distribuir en espacios de tiempo",
    "La técnica Flowtime es esencialmente útil para tareas de análisis o creatividad, en donde no deberías parar sino por agotamiento o distracción",
    "Las distracciones externas son las que surgen del entorno, son inesperadas, y de las cuales usualmente carecemos de control",
    "Las distracciones internas son las que parten desde el individuo, como pensamientos, cansancio, hambre, impulsos, etc.",
    "Si estás trabajando o estudiando, toma en consideraciones qué te distrajo, y cuándo. Así podrás evitarlo ulteriormente",
    "Si estás teniendo un día lento, puedes intentar usar Pomodoros para dividir tus responsabilidades en bloques",
    "Si cada vez se te hace más difícil concentrarte y te estás quedando sin ideas, tal vez sea hora de tomarse un descanso más largo, o de hacer otra cosa",
    "Si estás descansando, procura no pensar en el trabajo, de esa forma se descomprime tu cerebro y sí te dedicarás a descansar"
    ];

  static String obtenerConsejoAleatorio() {
    final randomIndex = Random().nextInt(_consejos.length);
    return _consejos[randomIndex];
  }
}