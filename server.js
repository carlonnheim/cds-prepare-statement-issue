const cds = require('@sap/cds');
module.exports = (o) => {
    cds.once('served', async services => {
        const db = await cds.connect.to('db');
        const { IntegerKeyedEntity, StringKeyedEntity } = db.entities('my');
        var integerKey = 123456789;
        await SELECT.from(IntegerKeyedEntity, { id: integerKey });
        await SELECT.from(IntegerKeyedEntity, { id: integerKey.toString() });
        await SELECT.from(StringKeyedEntity, { id: integerKey.toString() });
    });
    return cds.server(o);
}
