import React from "react";
import styled from "styled-components";
import BodyText from "../components/textStyles/BodyText";

class CoachAvatar extends React.Component {
  render() {
    const { name, photo } = this.props;
    return (
      <Container>
        <ImageContainer>
          <img
            src={photo}
            style={{ width: 53, height: 53, borderRadius: 26.5 }}
          />
        </ImageContainer>
        <BodyText style={{ paddingLeft: 13 }} title={name} />
      </Container>
    );
  }
}

export default CoachAvatar;

const Container = styled.div`
  margin-right: 20px;
  flex-direction: row;
  align-items: center;
`;

const ImageContainer = styled.div`
  justify-content: center;
  align-items: center;
`;
