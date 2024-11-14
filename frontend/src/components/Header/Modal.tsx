import React from 'react';
import { ModalBackground, ModalContent, CloseButton } from './styled';

// Modal Component
const InfoModal: React.FC<{ onClose: () => void }> = ({ onClose }) => (
    <ModalBackground onClick={onClose}>
        <ModalContent onClick={(e) => e.stopPropagation()}>
            <h2>About Product Manager Accelerator</h2>
            <p>The Product Manager Accelerator Program is designed to support PM professionals through every stage of their careers. From students looking for entry-level jobs to Directors looking to take on a leadership role, our program has helped over hundreds of students fulfill their career aspirations.</p>
            <p>Our Product Manager Accelerator community are ambitious and committed. Through our program they have learnt, honed and developed new PM and leadership skills, giving them a strong foundation for their future endeavors.</p>
            <p>Here are the examples of services we offer. Check out our website (link under my profile) to learn more about our services.</p>

            <p>🚀 <strong>PMA Pro</strong><br />
                End-to-end product manager job hunting program that helps you master FAANG-level Product Management skills, conduct unlimited mock interviews, and gain job referrals through our largest alumni network. 25% of our offers came from tier 1 companies and get paid as high as $800K/year.</p>

            <p>🚀 <strong>AI PM Bootcamp</strong><br />
                Gain hands-on AI Product Management skills by building a real-life AI product with a team of AI Engineers, data scientists, and designers. We will also help you launch your product with real user engagement using our 100,000+ PM community and social media channels.</p>

            <p>🚀 <strong>PMA Power Skills</strong><br />
                Designed for existing product managers to sharpen their product management skills, leadership skills, and executive presentation skills.</p>

            <p>🚀 <strong>PMA Leader</strong><br />
                We help you accelerate your product management career, get promoted to Director and product executive levels, and win in the board room.</p>

            <p>🚀 <strong>1:1 Resume Review</strong><br />
                We help you rewrite your killer product manager resume to stand out from the crowd, with an interview guarantee.<br />
                Get started by using our FREE killer PM resume template used by over 14,000 product managers. <a href="https://www.drnancyli.com/pmresume" target="_blank" rel="noopener noreferrer">https://www.drnancyli.com/pmresume</a></p>

            <p>🚀 We also published over 500+ free training and courses. Please go to my YouTube channel <a href="https://www.youtube.com/c/drnancyli" target="_blank" rel="noopener noreferrer">https://www.youtube.com/c/drnancyli</a> and Instagram @drnancyli to start learning for free today.</p>

            <CloseButton onClick={onClose}>Close</CloseButton>
        </ModalContent>
    </ModalBackground >
);

export default InfoModal;