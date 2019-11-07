Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC3F3747
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfKGScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 13:32:08 -0500
Received: from sonic302-3.consmr.mail.bf2.yahoo.com ([74.6.135.42]:37902 "EHLO
        sonic302-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfKGScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573151526; bh=xi91dLHAfH2BL/8V1cCtD9HM59uEYZ0ey1ryLq4KDKA=; h=Date:From:Reply-To:Subject:From:Subject; b=BfZ50b8IlVBSDUxujYgVZ4HcTWS6QVgNhFeVZoYY8MhKCSNsjkSE2VwN1t8GSTbqJodD7fX0BI7tNKC9mfZ+RmB2YiwnrcH1F3cZXiKm/jI5iaFr3bBrn0rYGlhimyqiIxsJx3XPlzclbGM85ygcRwwJFEiv6kWm37wi8XTndEagkK5PgSIoUVnq+Xtfko45hMtVW9QkyliYhPEdkSaEiEK05emLY0UlB8rN0f7x82ZXxiBUGaPaqSGAjYmft04CNvWqVuYLTeVAVhVM229nWkeAkjhxScpKFWGib3o2MVxGACrMV+ZLLwLN4lRJ6eydQUDv4Joe2tgwFfGxApgYgg==
X-YMail-OSG: zpPpr4EVM1nxeogdJ4cOe8TbtaxqqcFKOgNu85w7Lj_ZWTqL1P7i3Qgs.UBXYr8
 Zma3b.quoxL5_XeH4v8rye0GJcnv0lL0AZgrsignqUSyhrz9D3xiOyRikrQESPj4NzUCBk943FEo
 mlAmN.CJsYNHASeo8vjESP_h_VR4twXjZ6U0y16xq1eBNdOnbzQOSz9uieWWxbiTnbwSF8zxPyIy
 LL037S1ah39fQDuBc1dhZZ9FqZm4kJsheQFrNHJ1d.7wxx_cvO91XdJCEsIpGKPJjbJAv9ysZ5rD
 bTD_MoHsprtX.fFxoTVbWP3Q.m2B8AhzUx9li4Fq9oWGvP_CU2__sy8AOA4aoPV.x1fbEt24Pigm
 hMhkuqNBk.8UtbzCC010qOXmCgxoAXNeRLPoYUTNGpj1qquFRBSx_h667QCz8SLzrFutHOSxSskg
 IPYjPxJFz4vSJMiKQmj566MAn6gIUwdbKUEXv5bs.DKUNGdjFR.bGeUXabCoFxN8UJ9.cAmHlmZd
 KiFprTBwT1YLXA.3gpgUraCT_r3FzqAD2NWEnXGOBl.JVkxBZC7q9rXBIsC.T1BNsQlFuiTo9EIn
 wJdtl3jWkS7Rkw5Y7s3q0eRv_HtjouO246EjvBcYTxuzG3BPECzfHkpkCsgdhLAUCt2hsMRcwdPl
 A1a6QJnIP8lNARV2OnTzYKBrcsbboByZf9wtFJy0OPRqnBsF60UgSfXjDa2CmohLlcXT.kQtm8g_
 ztL9Jch62rOHQUhJX.lmR6xsk1EQGZm4EhM78eHTxKjzldaY1dESm2KnkCf5FMYTJe2yJYhrlSJN
 NzPXkT1r9U43Lc.ywYLDJxObliuKmO.7UdHkq5C8uwBmEHRf95byKAxjcv20POzx9u2KOcVnIdI.
 k3bVfANx2CU0V4KfNZWalET0Cu.2gfOJfX42RKSLjVWkmnPMLzcfquCf6S_Nwky3tKqX1hKZqY9D
 V7pmu0a9m5H1UtccPhIXrQQTqdz0nHThdPJw1aL0OKZcRgRcpPGY0wahkSukTZWxfuA8uirDL3Lu
 sgnm_My.eLlwSXwZ.KxzgNEEph_EVaS3daUrD8Icuz3iGn8o1Ow5FHYQKzdk_mTOyVKgFerJ5pST
 Hj.GZZrtQ9AuUHwzAIgVA9j5t1SN0tmOj3kYRdyAMKhSPjalJMpUlzeivS12KeBLUJKGcrIiz.lL
 yw7The5_nTmCcIvJvt4seBS1dDgdduMa1M1Fe.kFQwdwbMhjqt8IVp5kg2exT587RQrPrExoMrPh
 x9yW3tPSqjzXK3e01sjgsRVTpef_zn9GgobCGn.qG89JHIbirzsRka3hFSgE9TJpvdsdrXhdcpo_
 C8mgRbjWv
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 7 Nov 2019 18:32:06 +0000
Date:   Thu, 7 Nov 2019 18:32:01 +0000 (UTC)
From:   mohammado ouattara <mohammadouattara27@gmail.com>
Reply-To: mohammadouattara53@gmail.com
Message-ID: <1371795304.701466.1573151521402@mail.yahoo.com>
Subject: I am expecting your urgent respond.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear=C2=A0Friend,

I=C2=A0know=C2=A0that=C2=A0this=C2=A0message=C2=A0will=C2=A0come=C2=A0to=C2=
=A0you=C2=A0as=C2=A0a=C2=A0surprise.=C2=A0I=C2=A0am=C2=A0the=C2=A0Auditing=
=C2=A0and=C2=A0Accounting=C2=A0section=C2=A0manager=C2=A0in=C2=A0(BOA=C2=A0=
BANK)=C2=A0Ouagadougou=C2=A0Burkina=C2=A0Faso.

I=C2=A0Hope=C2=A0that=C2=A0you=C2=A0will=C2=A0not=C2=A0expose=C2=A0or=C2=A0=
betray=C2=A0this=C2=A0trust=C2=A0and=C2=A0confident=C2=A0that=C2=A0I=C2=A0a=
m=C2=A0about=C2=A0to=C2=A0repose=C2=A0on=C2=A0you=C2=A0for=C2=A0the=C2=A0mu=
tual=C2=A0benefit=C2=A0of=C2=A0our=C2=A0both=C2=A0families.

I=C2=A0need=C2=A0your=C2=A0assistance=C2=A0in=C2=A0transferring=C2=A0the=C2=
=A0sum=C2=A0of=C2=A0($12.5M)=C2=A0Twelve=C2=A0Million,=C2=A0Five=C2=A0Hundr=
ed=C2=A0Thousand=C2=A0United=C2=A0Dollars=C2=A0into=C2=A0your=C2=A0account=
=C2=A0within=C2=A07=C2=A0to=C2=A010=C2=A0banking=C2=A0days,as=C2=A0one=C2=
=A0of=C2=A0my=C2=A0Bank=C2=A0clients=C2=A0who=C2=A0died=C2=A0at=C2=A0the=C2=
=A0collapsing=C2=A0of=C2=A0the=C2=A0world=C2=A0trade=C2=A0center=C2=A0at=C2=
=A0the=C2=A0United=C2=A0States=C2=A0on=C2=A0September=C2=A011th=C2=A02001.

If=C2=A0you=C2=A0are=C2=A0really=C2=A0interested=C2=A0in=C2=A0my=C2=A0propo=
sal=C2=A0further=C2=A0details=C2=A0of=C2=A0the=C2=A0Transfer=C2=A0will=C2=
=A0be=C2=A0forwarded=C2=A0unto=C2=A0you=C2=A0as=C2=A0soon=C2=A0as=C2=A0I=C2=
=A0receive=C2=A0your=C2=A0willingness=C2=A0mail=C2=A0for=C2=A0a=C2=A0succes=
sful=C2=A0transfer.

I=C2=A0am=C2=A0expecting=C2=A0your=C2=A0urgent=C2=A0respond.

Have=C2=A0a=C2=A0great=C2=A0day,
Mr=C2=A0mohammad=C2=A0ouattara.
