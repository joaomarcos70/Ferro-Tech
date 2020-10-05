
const express = require("express");
const router = express.Router();

router.get('', (req, res) => {
    res.send('seila vei')
})

module.exports = router;

