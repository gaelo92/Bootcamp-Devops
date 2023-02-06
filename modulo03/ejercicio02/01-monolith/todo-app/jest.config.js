require('dotenv').config({
    path: '.env',
});

module.exports = {
    testEnvironment: 'node', 
    roots: ['<rootDir>/src'],
    testMatch: ['**/?(*.)+(spec).+(ts|js)'],
    transform: {
        '^.+\\.ts$': 'ts-jest',
    },
};