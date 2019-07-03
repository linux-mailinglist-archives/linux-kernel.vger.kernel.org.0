Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FC5D5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGBRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 13:51:12 -0400
Received: from mout.web.de ([212.227.17.12]:44431 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562089823;
        bh=ZY4QJ60SgBCr9rjOeI7wJcWzwyMqawSzvqtqOb7h6q4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=fOwI16P8ajUtdvLe+XGAGJcfdEPOS7PG1o+jDdIAqX/1dn/rmotgIrrs9acWWeoW8
         gug8waSyOtGxWMBHoYQ6lNDjzjKmJm1oF+889zutzHcE0nrbpMws9n2fHPClD6ualc
         31M3eqmtDwYHBVLdbG8vQ1WIILjX+c85vOGRngbE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLxD-1iiD9N3Olz-011lV2; Tue, 02
 Jul 2019 19:50:22 +0200
To:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] locking/lockdep: Replace two seq_printf() calls by seq_puts()
 in print_name()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f842ca82-b9f1-6aa6-7868-6b6e8c6b0f76@web.de>
Date:   Tue, 2 Jul 2019 19:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gK4mIV/I0jwSe9wSxlDCudi9olaFmtW/apz0yi1eNu8s3wH/Gy
 lU20xTDnm0GicDJkPISRtOBY5DI7O4o03RIRufbxLsc2XaPW7wNIFJ0qxLKaP7llD2Lhn1j
 i4YZI+2D1ox1ZiubWvXRnmFUZHT2Hq1qsNEL4L+0S5UwNKT2eLs5N5w/f65/R+twHY9I2XF
 ot07xKqdnzIziOUTXbj/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YuVe9wV9BtM=:jikX841Yovyn82Dxkn1qnX
 Bo1e5OQoNquOd17BYmZNvwpkfPVDQeZRjR+oPoLyfIwX7K0TvGgSh6/3TmgCVvB4+2LGXodPa
 uroMGuQRfpSYkNpy+Vu0ogDN5H/KXrjQtlb4X0hHw9JCL4uYRCzZQuj+Im8sBqTjisTxli6sE
 0qDMC/FoUBmiM/E8QlgB4HrGOdLEgTCFBICofcSEeX27EG3t8WPnHV5Zd4ALALaB8BtP/wYVc
 YMyT1j8BnAKH2mDVNoAzupo+gT6uYb1axfqhK8JnI822mc73N9NMqeUTaTHFv8iXMiNzXDwsg
 ZSdu+DTz0g5tKGefJqbGrhE2TB4de/ZOwX/QBPsYLqhX6E+4PU5eBlHDoPyzKVE5bGf2wzmx6
 bra/AvxissjoJKhcuTqf5nmXb/iVA1IgrAU555VzN6wsgb+5jtuwipomxgRxvrrnHAuV6e0xM
 oC1J19LmpQtVnY7T0stvxJip7BZFXJGcsA9kzHywa/xFVaEJY/Yf5LKUmlrXS+GeHyppBhteX
 HTcib4m2E+oX6qxnte0dyOVn4fK4VICQRsZkt4Mndilw84PaWbT43ol4DlvH2iJmp1ryVAyGO
 dRggxJr5BswuT2kksOO4BZCX8zgD2jjk81t1kP0FLnIXaa2PImBPT/fL/f3L1sdCF0Pr2pAdb
 cnEK0h6tpQD+vT/guFjJR1VaoO6bLANeBdWMJvr+sNSXhDsF7EfjDFI1Qfc4iAaXV67TTxqBX
 bBuH5vZfO8Bg2i4s7mU4dvWOkj12Y+Y3HvU/aqeiW+CnQrw3GN7E7Tot/Q2lJ7RGkVGZGSViv
 dK441pn6yY0b1AVztO2wG5774VfJnVvyfKLx29SF9TaVaaCpugpyeb/8pJDbODtL46YoGjALY
 +kYC4gj+hm2Uni2yWIfBtU3gi5bHr9Ew54X9+4WdEFAEzJZKUS3YNjnvkBvaOos0ZtIR7F4Ij
 5JkwdDJBmcDhHhS7Tvq63BvHgqI/fp7Qf3nI9ZUt4eysC8FCNFskrbWtz/mdAUT2t0kTTA/TU
 SJoxECa8xVVtHxMONQ6MVgAnQ2dbh+lZfHGhMrE5vgVqe9hRlYWdgk//QmxLChJ2pBB1SpAW8
 KTAvGIjNrJAsQ5MjDhac8g0y13ZfxAPGfxJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 19:45:26 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/locking/lockdep_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec645d8b..5bc9187e6246 100644
=2D-- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -45,9 +45,9 @@ static void print_name(struct seq_file *m, struct lock_c=
lass *class)

 	if (!name) {
 		name =3D __get_key_name(class->key, str);
-		seq_printf(m, "%s", name);
+		seq_puts(m, name);
 	} else{
-		seq_printf(m, "%s", name);
+		seq_puts(m, name);
 		if (class->name_version > 1)
 			seq_printf(m, "#%d", class->name_version);
 		if (class->subclass)
=2D-
2.22.0

