package frontend.node.expr;

import frontend.type.BasicType;
import frontend.type.BasicTypeEnum;
import frontend.visitor.NodeVisitor;

public class CharNode extends ExprNode {

  /**
   * Represent a character node
   * Example: 'a', '!', '?'
   */

  private final char val;

  public CharNode(char c) {
    this.val = c;
    this.type = new BasicType(BasicTypeEnum.CHAR);
  }

  public int getAsciiValue() {
    return val;
  }

  @Override
  public void accept(NodeVisitor visitor) {
    visitor.visitCharNode(this);
  }

}
