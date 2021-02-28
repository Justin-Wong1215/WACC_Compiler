package backend.instructions.addressing.addressingMode2;

import backend.instructions.addressing.*;
import backend.instructions.operand.Immediate;
import utils.backend.Register;

public class AddressingMode2 extends Addressing {

    public enum AddrMode2Operator { LSL, LSR, ASR, ROR, RRX }

    public enum AddrMode2 { OFFSET, PREINDEX, POSTINDEX }

    private AddrMode2 mode;
    private Register Rn;
    private Register Rm;
    private AddrMode2Operator operator;
    private Immediate immed;

    public AddressingMode2(AddrMode2 mode, Register Rn, Register Rm, AddrMode2Operator operator, Immediate immed) {
        this.mode = mode;
        this.Rn = Rn;
        this.Rm = Rm;
        this.operator = operator;
        this.immed = immed;
    }

    public AddressingMode2(AddrMode2 mode, Register Rn, Register Rm) {
        this(mode, Rn, Rm, null, null);
    }

    public AddressingMode2(AddrMode2 mode, Register Rn, Immediate immed) {
        this(mode, Rn, null, null, immed);
    }

    public AddressingMode2(AddrMode2 mode, Register Rn) {
        this(mode, Rn, null, null, null);
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        switch (mode) {
            case OFFSET:
                str.append(Rn != null ? Rn : "");
                str.append(Rm != null ? ", " + Rm : "");
                str.append(operator != null ? ", " + operator.name() + " " : "");
                str.append(immed != null ? ", " + immed : "");
                return "[" + str.toString() + "]";
            case PREINDEX:
                str.append(Rn != null ? "[" + Rn : "");
                if(Rm == null) {
                    str.append(immed != null ? ", " + immed : "]");
                } else {
                    str.append(", " + Rm);
                    str.append(operator != null ? ", " + operator.name() + " " : "");
                    str.append(immed != null ? ", " + immed : "");
                }
                return str.toString() + "]!";
            case POSTINDEX:
                str.append(Rn != null ? "[" + Rn + "]": "");
                str.append(Rm != null ? ", " + Rm : "");
                str.append(operator != null ? ", " + operator.name() + " " : "");
                str.append(immed != null ? ", " + immed : "");
                return str.toString();
            default:
                return "";
        }
    }
}
