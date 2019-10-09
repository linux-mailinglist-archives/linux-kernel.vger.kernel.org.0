Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CAD138F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfJIQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 12:06:17 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:37903
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731475AbfJIQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570637173; bh=dRX5d8v++xfAAoPIT3VpAbTnk4dfpHOyQKhLrN2OBJk=; h=Date:From:Reply-To:Subject:From:Subject; b=KMWA6hKNVVihueykH8pQo038duZAf4p/bAORhyeMrNQuFQMGr7Td2lriCkeEyVQOlrT1qeTNqcZjwyhPEeHlNXZZmxl0Zymp1qiaCBVNV5Q4oSDZT2oY3Tbd9K1VeNIKF1LDJlul0xTQXTr0nNbePyZQNnP/GZNd8Pr4ws8PGayeYAm1d2D4KQuHsLWQIS5KaIgAGriZ7Gt9yin/9epOtjikYH/dGFVeRuRbY3y8HaCLOlB7MiVrxBeh3JoSaKUa53RwFEo8h9gSmyCz2BsK+mhdv/0Kjhq5Q5qNT5qhic/NRQu8MXm++zJ2gdCCnAClwTJiDKS+OluRyO7sdW0TQQ==
X-YMail-OSG: DXkPKFoVM1nZSdafAfVt2CRUw1kKTTBGdtpyaw_JBfty2Xn3hwo0Ww1r_Xp5Dtg
 wv_qjlJojFZ4SAvJJKAczTLwAp5UtwAY2aHbpqweRDCG1yAXhUGknXrYuUGRIZ9rpAUB8W9xpG0f
 hGG4zRlvXHeMnDVKa36H2itEHlwULWaHMbCB240zHz_6gVSvhfSQArhA8L7WfLNQYcEXhYUifpiz
 maD.ulI_8lnSxTVdjyNmEBsx3BwYepkobfly83YTfIbo6I0a_H7I4h1Bn9wt2ySasGPxYdOf613B
 QADLSCzN24znb0uerb6hDhsUgckgPdOAqLW.LsTcp33xRW7IPmdRdjSgcZeaB0_FIWoqZ2b.onsD
 Jb07QCIs2tekkmqJp2FaSYUkRx.6um6Wtc6pzb1Kuum8toHDXqaN1_4ROHPFr.29oak8nXoastBD
 kFnEN0Tg4onewe.PVUajiuIg0nkFEx_dloQkvylmJ5nkOrSz4TsF2aNBOuacpwcOVmKd3qSOuZm9
 wsT0o0jY6XhKp298KdqX61xs04Mdh5y9iPWOm68VLZl2HHGk7SDryYIRqt1IzukjYgBosMcuqN9Y
 ZE5TGck36At9y4c5AKxCesi41ifRG1YeTJ6TQdEdK08xuGjDQ.x4QCpwVotizF7g8RxRVH0NA4YS
 ewdB_CFc_Ith.P7QCIm3JjZDcw5W8eLWhX6pqB_OPxEcjuTJ5K7kFVcFfO0_YskwOpFmnjQC_2c_
 l.PJ8cNSP2IJVvBF63lWWu78PoKbBh7QI4kAVTEXY7LEkmC33cZe9.Auo6EoLYJyHRtEWv2O8tam
 okKcbIMQB5D0zQss8LV8V.Pz4nljthSGiuN9m.Ljp9czWyvT_.2QGi9yBPHbNo3zHvFtMeLpY8aS
 KF9mm3xAUk_nk44GPVWbcLWT4Wkuc3brmNee3YnHPDDHOxRm6J6b4vxMR9FUlfvICJyuPZGlHzir
 30Gex.K51UsddCtt6LMRYdi59ICmQhRG2NZHgvlvvHoqyKNFHrftYT3tvp6a6tZeRYrSSAbBBEX9
 Qw0ryddVYaqJZ1_buNAe9gW7zmshmanCh2XasXztVrDIdbEzVZwpFnF2Mjpjc3cnrbY_uCOMh6L1
 Nik70S6VGliijGjBCMVzMKfu7RyEpbQNzywA5qgrlYMxYMyTcQQhFvB5XX7tc0MJYWFZALfhc.nV
 WAElQgsIJNR8xtyg.sZhJPhDmVBffnx.FxmQmSLsaxSSpf_Xo9_xiKVBmPN5k2qK1AFDk6tnFYuA
 xBK12YE.py2ijtGvBXaDeEYUk9isFA5wawb.TiTi8wbck7CQEyk1Itg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Oct 2019 16:06:13 +0000
Date:   Wed, 9 Oct 2019 16:06:10 +0000 (UTC)
From:   Miss Abibatu Ali <abibatuali01@gmail.com>
Reply-To: abibatu22ali@gmail.com
Message-ID: <492573820.3832490.1570637170443@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm "Mrs.Abibatu Ali" married to Mr. Ali ( an International Contractor and Oil Merchant/ jointly in Exposition of Agro  Equipment ) who died in  Burkina Faso attack,  i am 64 years old and diagnosed of cancer for about 2 years ago  and my husband informed me that he deposited the sum of (17.3Million USD Only) with a Finance house) in  UAGADOUGOU BURKINA FASO.

I want you to help me to use this money  for a charity project before I die, for the Poor, Less-privileged and  ORPHANAGES in
your country.  Please kindly respond

quickly for further details.

Yours fairly friend,
Mrs. Abibatu Ali 
