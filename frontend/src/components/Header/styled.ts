import styled from 'styled-components';

export const HeaderContainer = styled.header`
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 8rem;
`;
export const Title = styled.h1`
  color: ${({ theme }) => theme.appTitleColor};
  font-size: 2.2rem;
`;
export const InfoBanner = styled.a`
  margin-left: 1rem;
  svg {
    fill: ${({ theme }) => theme.appTitleColor};
  }
  &:hover svg {
    fill: #20546a;
  }
`;
export const HeaderIconsContainer = styled.div`
  display: flex;
  align-items: center;
`;


// Modal

// Modal styles
export const ModalBackground = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 999;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
`;

export const ModalContent = styled.div`
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 500px;
  width: 80%;
  max-height: 80vh; /* Set maximum height */
  overflow-y: auto; /* Enable scrolling */
  text-align: left;
`;

export const CloseButton = styled.button`
  cursor: pointer; // Add cursor pointer for hover effect
  margin-top: 10px;
  margin-left: 11vw;
  color: #2f6f8a;
`;

// Apply cursor pointer for InfoBanner icon
export const ClickableInfoBanner = styled(InfoBanner)`
  cursor: pointer;
`;