import React, { useState } from 'react';
import { ReactComponent as InfoIcon } from '../../assets/info-icon.svg';
import { ClickableInfoBanner, HeaderContainer, Title, HeaderIconsContainer } from './styled';
import { useDispatch, useSelector } from 'react-redux';
import DarkModeToggle from 'react-dark-mode-toggle';
import { AppStore } from '../../store/store';
import { toggleDarkMode } from '../../store/reducers/appReducer';
import InfoModal from './Modal';

const Header: React.FC = () => {
  const dispatch = useDispatch();
  const isDarkMode = useSelector((state: AppStore) => state.app.darkMode);

  // Modal visibility state
  const [showInfoModal, setShowInfoModal] = useState(false);

  return (
    <HeaderContainer>
      <Title>React Weather</Title>
      <HeaderIconsContainer>
        <DarkModeToggle checked={isDarkMode} onChange={() => dispatch(toggleDarkMode())} size={60} />
        <ClickableInfoBanner onClick={() => setShowInfoModal(true)}>
          <InfoIcon />
        </ClickableInfoBanner>
      </HeaderIconsContainer>

      {/* Conditionally render InfoModal */}
      {showInfoModal && <InfoModal onClose={() => setShowInfoModal(false)} />}
    </HeaderContainer>
  );
};

export default Header;
