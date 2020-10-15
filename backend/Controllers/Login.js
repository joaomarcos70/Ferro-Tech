const db = require('../banco/conexao');
const bcrypt = require('bcryptjs');

module.exports.store = async (req, res) => {
    
    const { email, senha } = req.body;
    try {
        const user = await db("usuario").select("*").where("email", email).first();

        if (!user) {
            return res.status(401).json({ mensagem: "Email incorreto!" });
        }

        if (!(bcrypt.compare(senha, user.senha))) {
            return res.status(401).json({ mensagem: "Senha incorreta!" });
        }

        const { id_usuario, nome, id_tipousuario } = user;

        return res.json({
            user: {
                id_usuario,
                nome,
                email
            },
            token: Jwt.sign({ id_usuario, id_tipousuario }, authConfig.secret, {
                expiresIn: authConfig.expiresIn
            })
        });

    } catch (error) {
        return res.status(500).json({ mensagem: "Erro interno no servidor." });
    }
}


