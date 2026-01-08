package es.albarregas.dao;

import es.albarregas.beans.Carta;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author jesus
 */
public class CartasDAO {
    
    
    public List<Carta> getCartas() {
        List<Carta> cartas = new ArrayList<>();
        
        cartas.add(new Carta(1, "Arqueras", 3, 112, 304, "Común", "Archers.png"));
        cartas.add(new Carta(2, "Caballero", 3, 159, 1399, "Común", "Knight.png"));
        cartas.add(new Carta(3, "Duendes con lanza", 2, 50, 110, "Común", "SpearGobs.png"));
        cartas.add(new Carta(4, "Esqueletos", 1, 67, 67, "Común", "Skellies.png"));
        cartas.add(new Carta(5, "Esbirros", 3, 84, 190, "Común", "Minions.png"));
        cartas.add(new Carta(6, "Horda de esbirros", 5, 84, 190, "Común", "Horde.png"));
        cartas.add(new Carta(7, "Bárbaros", 5, 159, 346, "Común", "Barbs.png"));
        cartas.add(new Carta(8, "Gigante", 5, 211, 3276, "Rara", "Giant.png"));
        cartas.add(new Carta(9, "Mosquetera", 4, 289, 955, "Rara", "Musk.png"));
        cartas.add(new Carta(10, "Valquiria", 4, 360, 1736, "Rara", "Valk.png"));
        cartas.add(new Carta(11, "Montapuercos", 4, 384, 1484, "Rara", "Hog.png"));
        cartas.add(new Carta(12, "Mago", 5, 373, 955, "Rara", "Wiz.png"));
        cartas.add(new Carta(13, "Mini P.E.K.K.A.", 4, 598, 1648, "Rara", "MP.png"));
        cartas.add(new Carta(14, "Bebé dragón", 4, 161, 1152, "Épica", "BabyD.png"));
        cartas.add(new Carta(15, "P.E.K.K.A.", 7, 678, 3458, "Épica", "PEKKA.png"));
        cartas.add(new Carta(16, "Gólem", 8, 259, 6784, "Épica", "Golem.png"));
        cartas.add(new Carta(17, "Bruja", 5, 113, 524, "Épica", "Witch.png"));
        cartas.add(new Carta(18, "Ejército de esqueletos", 3, 67, 67, "Épica", "Skarmy.png"));
        cartas.add(new Carta(19, "Globo bombástico", 5, 798, 1746, "Épica", "Balloon.png"));
        cartas.add(new Carta(20, "Príncipe", 5, 330, 1591, "Épica", "Prince.png"));
        cartas.add(new Carta(21, "Mago eléctrico", 4, 110, 944, "Legendaria", "eWiz.png"));
        cartas.add(new Carta(22, "Dragón infernal", 4, 30, 1070, "Legendaria", "InfernoD.png"));
        cartas.add(new Carta(23, "Sabueso de lava", 7, 45, 5700, "Legendaria", "Lava.png"));
        cartas.add(new Carta(24, "Espíritu de hielo", 1, 91, 190, "Común", "IceSpirit.png"));
        cartas.add(new Carta(25, "Flechas", 3, 144, 0, "Común", "Arrows.png"));
        cartas.add(new Carta(26, "Descarga (Zap)", 2, 159, 0, "Común", "Zap.png"));
        cartas.add(new Carta(27, "Recolector de elixir", 6, 0, 1280, "Épica", "Pump.png"));
        cartas.add(new Carta(28, "Choza de bárbaros", 7, 0, 1673, "Épica", "BarbHut.png"));
        cartas.add(new Carta(29, "Torre Tesla", 4, 135, 954, "Común", "Tesla.png"));
        cartas.add(new Carta(30, "Torre infernal", 5, 75, 1070, "Rara", "Inferno.png"));
        
        return cartas;
    }
    
}
