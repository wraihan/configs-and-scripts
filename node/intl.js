const lokaliti = {
    timeZone: 'Asia/Kuala_Lumpur'
};

const opsyenH = {
    ...lokaliti,
    dateStyle: 'long'
};

const opsyenT = {
    ...lokaliti,
    dateStyle: 'full'
};

const opsyenM = {
    ...lokaliti,
    timeStyle: 'short'
};

var hijri = new Intl.DateTimeFormat('ar-EG-u-ca-islamic-civil', opsyenH).format(Date.now());
var tarikh = new Intl.DateTimeFormat('ms-MY', opsyenT).format(Date.now());
var masa = new Intl.DateTimeFormat('ms-MY', opsyenM).format(Date.now());

console.log(hijri, '|', tarikh, '|', masa);

/* islamic, islamic-civil, islamic-rgsa, islamic-tbla, islamic-umalqura */
