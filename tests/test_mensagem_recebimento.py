# -*- coding: utf-8 -*-
import datetime
import unittest

from pyboleto.bank.caixa import BoletoCaixa as Boleto
from pyboleto.pdf import BoletoPDF


class TestMensagemRecebimento(unittest.TestCase):
    def setUp(self):
        self.boleto = Boleto()
        self.boleto.logo_image = 'logo_bancocaixa.jpg'
        self.boleto.data_documento = datetime.date(2000, 7, 4)
        self.boleto.data_vencimento = datetime.date(2000, 7, 4)
        self.boleto.data_processamento = datetime.date(2012, 7, 11)
        self.boleto.valor_documento = 550
        self.boleto.agencia_cedente = '1102'
        self.boleto.conta_cedente = '9000150'
        self.boleto.convenio = 7777777
        self.boleto.nosso_numero = str(22832563 + 0)
        self.boleto.numero_documento = str(22832563 + 0)
        self.boleto.nome_emissor = 'NOME EMISSOR'
        self.boleto.vendedor_nome_fantasia = 'VENDEDOR NOME FANTASIA'
        self.boleto.vendedor_razao_social = 'VENDEDOR RAZAO SOCIAL'
        self.boleto.vendedor_tipo_documento = 'VENDEDOR TIPO DOCUMENTO'
        self.boleto.vendedor_documento = 'VENDEDOR DOCUMENTO'
        self.boleto.razao_social_emissor = 'RAZAO SOCIAL EMISSOR'
        self.boleto.especie = 'R$'
        self.boleto.quantidade = ''
        self.boleto.instrucoes = ['', '']

    def make_boleto(self, dias):
        self.boleto.max_dias_apos_vencimento = dias
        self.boleto.boleto_desenhado = BoletoPDF('teste-recebimento.pdf')
        self.boleto.boleto_desenhado.drawBoleto(self.boleto)

    def test_mensagem_vencimento_zero_dias(self):
        self.make_boleto(0)
        self.assertEqual(self.boleto.max_dias_apos_vencimento, 0)
        self.assertEqual(
            self.boleto.mensagem_recebimento,
            'Não receber após o vencimento'
            )

    def test_mensagem_vencimento_alguns_dias(self):
        self.make_boleto(10)
        self.boleto.max_dias_apos_vencimento = 10
        self.assertEqual(self.boleto.max_dias_apos_vencimento, 10)
        self.assertEqual(
            self.boleto.mensagem_recebimento,
            'Não receber após 10 dias do vencimento'
            )


suite = unittest.TestLoader().loadTestsFromTestCase(TestMensagemRecebimento)

if __name__ == '__main__':
    unittest.main()
