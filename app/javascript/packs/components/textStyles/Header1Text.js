import React from "react";
import styled from "styled-components";

const Header1Text = (props) => {
  const { title, style } = props;
  return <Title style={style}>{title}</Title>;
};

export default Header1Text;

const Title = styled.p`
  font-style: normal;
  font-weight: 600;
  font-size: 25px;
  line-height: 30px;
  letter-spacing: -0.3125px;
  color: #333333;
`;
