import React from "react";
import styled from "styled-components";

const OverlineText = (props) => {
  const { title, style } = props;
  return <Overline style={style}>{title}</Overline>;
};

export default OverlineText;

const Overline = styled.p`
  text-transform: uppercase;
  font-style: normal;
  font-weight: 600;
  font-size: 13px;
  line-height: 16px;
  letter-spacing: -0.1625px;
  color: #666666;
`;
