import React from "react";
import styled from "styled-components";

const BodyText = (props) => {
  const { title, style } = props;
  return <Title style={style}>{title}</Title>;
};

export default BodyText;

const Title = styled.p`
  font-style: normal;
  font-weight: normal;
  font-size: 17px;
  line-height: 22px;
  letter-spacing: -0.215333px;
  color: #333333;
`;
