import React from "react";
import styled from "styled-components";
import { render } from "react-dom";
import Header1Text from "./components/textStyles/Header1Text";
import Header2Text from "./components/textStyles/Header2Text";
import OverlineText from "./components/textStyles/OverlineText";
import BodyText from "./components/textStyles/BodyText";
import CoachAvatar from "./components/CoachAvatar";
import CallToActionButton from "./components/buttons/CallToActionButton";
import calendar from './assets/calendar-icon-filled.png'
import time from './assets/time-icon-filled.png'
import locationImg from './assets/location-icon-filled.png'

export default class App extends React.Component {
  state = {
    title: "",
    location: "",
    description: "",
    startDate: "",
    endDate: "",
    photo: "",
    group: {},
    coach: {}
  }

  componentDidMount() {
    let activityId = window.location.pathname.split("/share/activities/")[1]
    fetch(`/api/activities/${activityId}`)
    .then((res) => res.json())
    .then((data) => {
      this.setState(data)
    })
  }
  render() {
    console.log(this.state)
    const { title, location, description, startDate, endDate } = this.state
    const { name } = this.state.group
    const { fullName, bio, photo } = this.state.coach
    console.log("Date", startDate)
    const startDateObj = new Date(startDateObj)
    console.log("new Date", startDateObj)
    return (
      <Container>
        <div>
          <Cover>
            <Activityimg
              src={this.state.photo}
              resizeMode="cover"
            />
          </Cover>
          <OverlineText
            title={name}
            style={{ paddingLeft: 20, paddingTop: 30, paddingBottom: 10 }}
          />
          <Header1Text
            title={
              title
            }
            style={{ paddingLeft: 20, marginRight: 20 }}
          />
          <SummaryContainer>
            <CalendarWrapper>
              <CalendarIconFilledContainer>
                <CalendarIconimg
                  src={calendar}
                  resizeMode="contain"
                />
              </CalendarIconFilledContainer>
              <BodyText
                title={"Friday, April 10"}
                style={{ color: "#858585", paddingLeft: 10 }}
              />
            </CalendarWrapper>
            <TimeWrapper>
              <TimeIconFilledContainer>
                <TimeIconimg
                  src={time}
                  resizeMode="contain"
                />
              </TimeIconFilledContainer>
              <BodyText
                title={"8:00 PM"}
                style={{ color: "#858585", paddingLeft: 10 }}
              />
            </TimeWrapper>
            <LocationWrapper>
              <LocationIconFilledContainer>
                <LocationIconimg
                  src={locationImg}
                  resizeMode="contain"
                />
              </LocationIconFilledContainer>
              <BodyText
                title={location}
                style={{ color: "#858585", paddingLeft: 9 }}
              />
            </LocationWrapper>
          </SummaryContainer>
          <Header2Text title="What we will do" style={{ paddingLeft: 20 }} />
          <CoachSection>
            <BodyText
              title={
                description
              }
              style={{ paddingTop: 14, marginRight: 20 }}
            />
            <Header2Text
              title={`Hosted by ${fullName}`}
              style={{ paddingBottom: 14, paddingTop: 40 }}
            />
            <CoachAvatar photo={photo} />
            <BodyText
              title="Runner"
              style={{ color: "#858585", paddingTop: 14 }}
            />
            <BodyText
              title={
                bio
              }
              style={{ paddingTop: 14, width: 335 }}
            />
          </CoachSection>
          <ExtraSrollSpaceForPadding />
        </div>
        <CallToActionButton
          title="Open in app to join activity"
          style={{ top: 10, marginBottom: 30 }}
          onPress={console.log("Button has been pressed.")}
        />
      </Container>
    );
  }
}

const Container = styled.div`
  flex: 1;
  background: white;
`;

const Cover = styled.div`
  height: 350px;
`;

const Activityimg = styled.img`
  width: 100%;
  height: 100%;
`;

const SummaryContainer = styled.div`
  flex-direction: column;
  padding-top: 20px;
  padding-left: 20px;
  padding-bottom: 30px;
`;

const CalendarWrapper = styled.div`
  flex-direction: row;
  align-items: center;
  padding-bottom: 20px;
`;

const CalendarIconFilledContainer = styled.div``;

const CalendarIconimg = styled.img`
  width: 17px;
  height: 17px;
`;

const TimeWrapper = styled.div`
  flex-direction: row;
  align-items: center;
  padding-bottom: 20px;
`;

const TimeIconFilledContainer = styled.div``;

const TimeIconimg = styled.img`
  width: 17px;
  height: 17.11px;
`;

const LocationWrapper = styled.div`
  flex-direction: row;
  align-items: center;
`;

const LocationIconFilledContainer = styled.div``;

const LocationIconimg = styled.img`
  width: 18px;
  height: 17.8px;
`;

const CoachSection = styled.div`
  padding-left: 20px;
`;

const ExtraSrollSpaceForPadding = styled.div`
  padding-bottom: 40px;
`;
