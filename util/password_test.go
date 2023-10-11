package util

import (
	"testing"

	"github.com/stretchr/testify/require"
	"golang.org/x/crypto/bcrypt"
)

func TestPassword(t *testing.T) {
	password := RandomString(6)

	hashedPasswordOne, err := HashPassword(password)
	require.NoError(t, err)
	require.NotEmpty(t, hashedPasswordOne)

	err = CheckPassword(password, hashedPasswordOne)
	require.NoError(t, err)

	wrongPassword := RandomString(6)
	err = CheckPassword(wrongPassword, hashedPasswordOne)
	require.EqualError(t, err, bcrypt.ErrMismatchedHashAndPassword.Error())

	hashedPasswordTwo, err := HashPassword(password)
	require.NoError(t, err)
	require.NotEmpty(t, hashedPasswordTwo)
	require.NotEqual(t, hashedPasswordOne, hashedPasswordTwo)
}
