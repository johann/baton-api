import React from "react";
import styled from "styled-components";

class CallToActionButton extends React.Component {
  render() {
    const { title, style, textStyle, buttonStyle } = this.props;
    return (
      <div style={buttonStyle} onPress={this.props.onPress}>
        <ButtonContainer style={style}>
          <ButtonText style={textStyle}>{title}</ButtonText>
        </ButtonContainer>
      </div>
    );
  }
}

export default CallToActionButton;

const ButtonContainer = styled.div`
  height: 50px;
  margin-left: 20px;
  margin-right: 20px;
  justify-content: center;
  align-items: center;
  background-color: #007aff;
  border-radius: 8px;
`;

const ButtonText = styled.p`
  font-style: normal;
  font-weight: 600;
  font-size: 13px;
  line-height: 16px;
  text-align: center;
  letter-spacing: -0.08px;
  color: white;
`;
