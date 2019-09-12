Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6514B0A22
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfILIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 04:22:02 -0400
Received: from sonic309-20.consmr.mail.ne1.yahoo.com ([66.163.184.146]:40259
        "EHLO sonic309-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbfILIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568276521; bh=9xH5w6zSEuhYXlvG2VclR697b/6izmQwsn4JLiYuDJA=; h=Date:From:Reply-To:Subject:From:Subject; b=unnQqThEI+MQjEQQKb56/M3gG3cfy2GhR+ELHvLehFaISXwmfE021ju67pGpqcmE689LhxU1Tf2/NUihi3ngk1b1FUBoYvt8VR22jhdumdxB2xdKZ63028yEMEN878Gov1jQww7z0hbh2SEaAVq7qi+l1Te/8VbKC9vvOAp6J8TT3YFDyrPTumqJWuSjcopjCBnf+Z0TgD+m1ynGd8G8gc2NqZhm/EjdEaEE2UyRYwnjWWJL6ooKjRSD0O3q30tz4bVwtYR6MZLqPJkRBZ/8zE3yZ8yvgmt+ANkS+Ywr4dn6GS+kdLM7UnxNyKNwjY5qbissD+W6ulVnzNRxZa5v7w==
X-YMail-OSG: atNTMaAVM1lA43GEyP7YiESSkQhbcYQ7mSfsozhTvTv8b95AtX3py0qCrq7CuOi
 XZfZsW9GSAt7kuNWHrMkVmLqhCr8RSNQxbzHZIlS5JvvqBS9eD8h6wAiLoOT7KmNDQlM3KYsPCOA
 IgQ.soW3T7RKL4IYjjCv7edo03OIJC2CGVM0E5OB89P8fVay62E5YnxysMvpUaPBuweEBacVVB_V
 SSgpSoNmZEtziLNvU9nOuSyxSrME3k5bEJyq21HdWyrb07Wgarpmi6QFg4lrpuQjFCJWZasytaI1
 F.XHVCWL_VM0wLsed7x85FcQykXpOOZD.wkk5ah6uzdO37Em.6JaJ2G2CvhIKiyudWzXYCBK8Uja
 zhZ5QrlufwnLoB3B1AaBDuCetER3mP9iZ1DiXouK0RFzRy1DG97UX2NW5Hvayn7Z_kysk3VuAg_V
 DGI9vuUBrBYw9ipSY4m4RPG4fdTbNiUKXmA2GXZ72skzEEJ9P5ngHxMGh14MGlJT9yknlUweDjrA
 0iA5_ZrqLt7Y320BFY6aXRLi1dYVFaW5iBMA_iRi949PcB4QEvXp5bSpJsNc1rgMoxIHbrGxGxQN
 TZoG5prscOuKu92qbgoPlK1UzQ.66dUCY6CRpwMCG5N_4pY6HoID.1lnkUtuaSPeMwYTqcX6001C
 bzRuFfLtSP30V9L1BhzSiHpQZuExYpaYNoOliju39Uz7.FmDXjaVic1P.XPue64RAmRWE.KN79om
 DPq86JVKWCZ28v07LG_Pci441CMPBoAHm15o5NyRxGLCvPPyo.OR4KftHdxUxmOno71r6Go743Pa
 Lq.JKyf8Q02OSoZY7mOjkJTH.pVCLcdgZ09o_HdtfHRDDy_3Y0ZcjWZXeIVQyv.EVbCguNvs2P71
 QrpbB9Y0wLuKcZXOuGUVYQ6R0bmtObcDNQakTdUjp10bWBqk50I7ijDhn_HY82cPuB4HAXhCilrF
 GUHwe31yWfnTnvzVKLnkn3riC_Q3SLh2EqVw4NDwot16V5DVFv8laC2rhBjyGQBtpS8FCC6p2jZP
 NOJRoIaauib7TFCd.YdW421iaZskggiZFlk198m2OY5L6XQtb90w.vr2B6bopsV68FEkF5EhI8hY
 llCih5TCn60gsHF_PdQeXJy8ggEVJPD19Ji5M9bZxI4d.NXwGn.ys2eXswIDBGM4Tkc66ET.JY.a
 px8Ve_iYzCd103isskgVMvTTor2yIJDn9jYfDKNrTFKSrrYa6hRCxQQJL4efYFwtHZGD.03qpYfr
 PL8.bb4vZ2xFV_vSHpSUdHEt5CUFAUCo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Sep 2019 08:22:01 +0000
Date:   Thu, 12 Sep 2019 08:21:59 +0000 (UTC)
From:   Lipton Davied <barrsterliptondaveid@gmail.com>
Reply-To: barrsterliptondaveid@gmail.com
Message-ID: <1013195882.137794.1568276519037@mail.yahoo.com>
Subject: HI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Drogi przyjacielu,


Jestem pan Lipton, kt=C3=B3ry nie by=C5=82 radc=C4=85 prawnym. Chc=C4=99, a=
by tw=C3=B3j kontakt pom=C3=B3g=C5=82 mi odzyska=C4=87 fundusz o warto=C5=
=9Bci (4,8 miliona dolar=C3=B3w) pozostawiony przez mojego zmar=C5=82ego kl=
ienta na jego koncie, zanim zostanie on skonfiskowany lub uznany za nieu=C5=
=BCyteczny przez firm=C4=99 Security Finance, je=C5=9Bli to kwota zosta=C5=
=82a zdeponowana,


Wszystko, czego od ciebie wymagam, to twoja uczciwa wsp=C3=B3=C5=82praca, a=
by=C5=9Bmy mogli zobaczy=C4=87 t=C4=99 transakcj=C4=99 jak najszybciej.


prosz=C4=99 o bezpo=C5=9Bredni=C4=85 odpowied=C5=BA w celu uzyskania dodatk=
owych wyja=C5=9Bnie=C5=84.



Pozdrowienia,



Mr.Lipton Daveid (Esq)
