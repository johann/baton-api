import React from "react";
import styled from "styled-components";

const Header2Text = (props) => {
  const { title, style } = props;
  return <Title style={style}>{title}</Title>;
};

export default Header2Text;

const Title = styled.p`
  font-style: normal;
  font-weight: 600;
  font-size: 20px;
  line-height: 24px;
  letter-spacing: -0.25px;
  /* margin-bottom: 21px; */
  color: #333333;
`;
