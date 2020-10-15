const db = require('../db/conexao');

module.exports.store = async (req, res) => {

    const { login, senha } = req.body;
    try {
        const user = await db("usuario").select("*").where("login", login).first();

        if (!user) {
            return res.status(401).json({ mensagem: "Login incorreto!" });
        }

        if (senha !== user.senha) {
            return res.status(401).json({ mensagem: "Senha incorreta!" });
        }

        const {id_usuario} = user;

        return res.json({
            user: {
                id_usuario,
                login
            },
        });

    } catch (error) {
        return res.status(500).json({ mensagem: "Erro interno no servidor.", error });
    }
}


