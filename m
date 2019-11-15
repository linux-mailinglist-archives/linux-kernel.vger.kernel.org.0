Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E90FE050
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKOOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 09:43:35 -0500
Received: from sonic313-56.consmr.mail.ne1.yahoo.com ([66.163.185.31]:43884
        "EHLO sonic313-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbfKOOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573829012; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:From:Subject; b=dOi5MedBpN+QnK5dLEKsKBoT3yQUBy5HL0Ae+c/6jSk1dnnaUm8QLn9PD1kirch6t6x1lsVijRKXzVmbCsyFM1QgRxKlmBvEZhvn7Isd6vJXJXuyWQlzFAB2+dy2nk7PrsJ9SqpLShsHugLc+2Lb/ext/lZhNOokPjBeHrs60+bfQjOe/MwsDYmtO/vqbm3sEQIkqkZFr1+m48nVxWQj0HFbO1qCtSddStJm6HyNnUKRFVWn+ODRiNGxtV1P3m5y3tCXd5RBQp991w0xNliwCbenfG7s/TwduqRaq5T6BX7zWOl9fPqoCavRw7bZq0LtYpCX/jss58KSr4YrFBr+iA==
X-YMail-OSG: WYokenIVM1nalX_m_2zrA0iqU05cNMxEPfhmflRS6R7Uf8vobyZ61mJECuONddJ
 eH6LfmVEFNn1ytDFV3_HtQUu2w3FvmDwBXBi3rwBtKpzrfOX27zhVpQVwPc4MIgvJroV6N9kMm3r
 nOFK4Pk5buOx6sGkKP4q9sd7MO4M4wWfHp9lusa3ApPsNgfv0sN0Jh.Zjhn7XhmtqFPD28r9x5zo
 cKjoHgsdBy5ftqeh87aGtkh4bI3pAzWHw6f7neFwuks7GU8aeyj.JxFs7mRG13cdi2bW04.ycde2
 2_VJ85qvBWf67.nrrVbtmaTWKedOgtTjlp2ERuYG47YVx4gnAhdN78iBBfJy_fjf8.9QtwaH2O63
 IfbhmPPAuxibVtLR7j9a3nJcpLtFw8dA6jyQaWVdu2mOqM74yI4e6BqoxFLPluuiWnZy98tmaNAc
 _wUmhD87Wh22Wwik6VbU79x1PuE.gmSMScNFu8l.tLZ2t5plFP_X0_1V1uWWq4.FvFIliGvyV9Zh
 bMqcaCM9IP1IX827x3QU90bEYfjIq5sGFOZq5TzbRk9m6wsBqcRBn6Oh2q_wWEHT4TZWhLxV85Jb
 NumqKHKpAZsoJ3PvjG3bjh82pIqnxZzhggfgY8c5yCA6oeIhufdMnELoprqzibpATkDSV.zjcnZg
 ba2f7M9ly_JaQhAx2Wuq8wDvAEe9BgeUL.BDD5M3haDIz4DQujnhusbQIJgalnIE8Ml53cGKzkLp
 Ki3yxLc9HvoPwlsr93WSfdKxGY.cU4_zrqYUjN4nl6MSp5u86iScc1qyAL496lSxk2V6D0tEFedf
 9DEKoXj16zhgOXzZmVLk1dELkNmq1aUb5iPWhhfeb0hqsCti5Cg.gFPcj621KUtDERLkZoyEEgVc
 gyYK.wdFtRHNYSjxqkdDlYm0jV.kwwbGG2g_d8Juc.Kynw7.oIjXPbMuEKIfiIHBwfX7sAKAqD0x
 RYg4bEre7WAyfUjVfgUYzA2EVbh3uLztvgkECEc_8JGNyGWUcn4IdK_hRYzCSswL3xqRKpxSOKWN
 INthv.XLvpM6RQdzuqyb7mxdG3MOMNKQTzKD1z1tAb6Z53G2lwyDhHhClx0.Qx0_OWUcE06FFeXC
 M88uqsZ6Z._VJo9.azAvdRCuX4DNMjZB3w0ezjtt04SZq3yi4qUAD8D5SCKM2qLg4ioPVtA_4bNW
 H9UTN6kY45N4U7u66UizqOdJS1_TkMEkhVN63pBQit3hCY5QX4uWTQCNtzDnjZkbCprw4G08MYoF
 ykoFMgQy5Jkj7x.jJufuSIYGxPGgAaA2JwdrBGqQG4wDrlW88DLwarKgrX0_W3i_TZzhliUe.A0b
 .vF8hrPyNSPm3sm103xw22cDqf0rhTOEpGBvO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Nov 2019 14:43:32 +0000
Date:   Fri, 15 Nov 2019 14:43:26 +0000 (UTC)
From:   Aisha Gaddafi <agaddafibb@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <1935439309.714771.1573829006936@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
