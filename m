Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2E8FFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHPKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 06:13:50 -0400
Received: from sonic311-23.consmr.mail.ne1.yahoo.com ([66.163.188.204]:46718
        "EHLO sonic311-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbfHPKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565950429; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=KzZIvSlT/tkgHH/H1HsXcwAXCmFM0k71WwppyCFiF8SCh3QhIh6FLSrxBhCkL/DK+juxDoUpasXEtPBry43TrH3UD7Lo25eRrerTaP3GS5SAXW7iF99hs4eg+SRem3aoTaO3narLINvuhfuf97RpnjINR8z3K7zQ8Ofg9avLeW4cVxHkGjlXEIkfY3zHoC6SQmWJOg023TE+MiNWvg8+MpnuZj6K7PTsLV3mtmEbJxShrAQtwEZMLz/yddIl6z1UmLW1qaHG/vfeP6qYAB4KTifxoHQa/m3stxWn6NgCdwN+hDS4IDYl/5HdyMJHBPUo15/scuJzsGTyN3AJYKpGqw==
X-YMail-OSG: c42ZiIgVM1nJL50rJK1cZjZDtCdll1G1wDkzbCSiZVSsEIpyToBx3fb_G2eMuF2
 GFHJwRateeNws7FK0DbavyhkIDTKoEOsMA6gcHzQnM0QOqJ0saEPX5DV5ysY1o0SarRTs19_y4B6
 VSD8fxT5PfK2_wpyu91AAVgBfjYS2J3GWbh6Afc.CJzfRbvdVzqTqc.GQbvSsqDnYJ91_.RZhCY4
 ZXj3xJwtLEAa6Zpj6ICmnut93XJ3C2mSLuRS9gWV5ugOUUunawBZrh9gi.ZVO9gllwjPwmu0mibR
 Knskz9lhx2n2wtUvuvBAsVr6cNlNxNrKmimIPKo69wNjyvIv6L2eA2CKdRp.md2MTB6cABIrJs2n
 fXghW1U7ZrxEzPTjPQEmBjjMziIa02zrihQH1RVPaXF4.08.PHahOObdBvvWFR21t82jDeMFc0iK
 5GJPT6WOIhxGnxXQpNjqswveQoJNF2IcADcYrDT2_R76lVaXDP3FyeQnWegG8WCyuWs4dInnQu1i
 WEntt0APfBL3xaSDkKru0hitv2wpz9tEw5gEeyh3rRBtrwD4AVN2C5IYHcPEIysE3SsB5wHqrJy5
 ofMQb8Wu_4KxtIDJ1KVueJEOSOCCpOWIkjGIoHJs5WCyQmdqJxXMe4QYnTMlyeCT2RdANVJLtsav
 79IR.fOIJWjY9FdMwL24ibju5ZYq20Wrpf9PwrxmYYqERCMGjs3Pj9KMZFD2VOWHnOV9RSmr1J9n
 j8cWXZXZq2.kN2syAkaLN.bb4sYG5ZZqkvDp13YstaXuZm6HP4GptHYMsZ98OfCDD470_QqMHAce
 JUIGcOKZiQtzNWEiw6r21L2kDkf51RZmymLX1JDCm154ZDlPYieYB_NJK6GyC20raD1fo9CbgWER
 hXf0Kk2l1QrfgQMM2KT.zIlJkaV26y0MeOiUrkB7YkTKYpj7l42TTn9j0SvmDDpB.Ww7NgDWj5eN
 2.gUeZyrhEYKsMraK4YVf5JikZhTuiBJBD_P0nsgPKhRfuwNDAHfAOl_qZ63qqLDisz00.pXagWZ
 DgzShumLlbT02os90oIMAfAGVB6BkJL9x4SvFyranmlwsRzkeGEMSkrAeZcpB9TZgDDbrENpiIWi
 vTHLqhdmJO4Blrp0zTlwIw.4bt3eXFxDMGdoXvFvPzNHOblnnpqMO4U7pz9VSiPPjit62og91tkC
 bZmF1VriuUqSD1OKJKxsqqRRDLBua3_H1EtueIJSsuLQ0ESJoZ1cNl.G.4Z02LXLEgn15hDO4Ubs
 KBoAWvo3cJdb7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Aug 2019 10:13:49 +0000
Date:   Fri, 16 Aug 2019 10:13:45 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <208601980.6195563.1565950425294@mail.yahoo.com>
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
(gaisha983@gmail.com)
