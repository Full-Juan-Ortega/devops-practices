const GREETING = 'PepitoPepon!';

module.exports = async (req, res) => {
    res.send({
        greeting: GREETING,
    });
};
