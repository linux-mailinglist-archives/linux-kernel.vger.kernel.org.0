Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFAA689D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfICM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:29:14 -0400
Received: from mout.web.de ([217.72.192.78]:34707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfICM3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567513742;
        bh=y2nCAjLsqH+/IXyuFBbt7GyPuAFQotExBGJT1ob3De8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EkdxYR6jd/ks01EgjhP+5qv1LKPb22071kr4TmafKue3e3532gtJP/bgJc/HkQd26
         7ZVOv/IkImjTT9i1OTsvW5N7ZJ04f1neNndaQOASTgEJj/KaoLJ4TgPecCHyfgn+fm
         kydQyVpNu2Svx8BcaABoCIHxD4byqfQ8Q7Z5pwBY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o3y-1iK2Pk01Ji-00tgni; Tue, 03
 Sep 2019 14:29:02 +0200
To:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] efs: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <30140782-38b7-5eb6-885e-8289997842f6@web.de>
Date:   Tue, 3 Sep 2019 14:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XTJ2Fqod4uDZ4XyVlQmPqah8BFIi8r0z8bPSGJuwoeSB8d6tFvi
 86LSfp5QhqCA+j0281rDpWZ3VxNiTnPFKWlxxbcMm2jcdok9ZG8BSGej81UJxWNvIfA8xl7
 TkOSHazEURxi/kLugnwEqtTwEYwYNw0c84ByrvFX2K8K90n/Wdi6Yz+/gdaoQJIB/V/8Fvg
 b/PC6L3EboZAeCZJgN+PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eX1XpncS11s=:BDsvH8CMwThSrudwTyn7S+
 uYsn7+Q5xxAljva5DoeAcY63mOw8oy51n5hQyYHQIHKSo++WJL8wRbBi/9BaWPIBRmmKkhia9
 +YNiPewt+hKOv7yBwz3/u9rHkZIxw1qmyZah5lNaNryuA7u4OjYSoGX69g/ucQ9hE1Ao8ixGT
 MZN16QmvcEOom8Kbh9WE04i/gyUBlhiNm3FfnX3uNbpi7VEJA6Oj+lZE97ua9YD2xfgYvRBIM
 zkP1vkgwzoi/3/3SOiQzGALGMdITPtOSH2CBpeKxTOc/rgWhRYxTYQ1ycWrG2kAd22tEB5HTQ
 SKQe5kBXc+zokIrPVhlKp8gRcdpHiw6texxfHTuNIII/m0e7HFO0sO277Fp2yNBL0jjjGE4qX
 hSmo28c48MjvhOx6SSaNbWvwbKezuOFM4+oFCJ4t8R9oMGSkka3hLXlzygOlyKkDRmtMmHscN
 cOcCtgEnIKvI8kfaxXnrLw4Lv33KO68ny1jNhDDNYgaNSpOubG3Dwsa1LF2TzDkX1Fv65s1V5
 26XAcnv9MMSltDsTBkQSnrQ/Zxfe21wfDve/r+ZH3sKRDWnq0qMiyOJpaBkvjmj7AME12r/OH
 JaRwTSHStnDIEyfmqaC/TmppJ366LKPEOUzN/bHv2rToXIQ4weWDzG6DoXd5N+Z9bE4/bJxr9
 S0blvK7N7zltmeaLTySsmjPv18wcyzSDSc00fi48irSNbdLgEg/VRAOMVaHOf9gFG8HEsuL7p
 hGi48blV2e0yPZuk5wQ8HPx2tEUQEqblPO6rnRHdLiuytbCkl6g9w0uEUvspOVWVHiZlxRNcd
 8WqN8f7UBXgHZJbtViMXgsRUj6TLT2KF09eb196m9VSzpZTaAb6ufOqoSPiT/2oRtXcBUtPCJ
 d9SxDA1K0mGyL2qWS8nhKMWFH3kC3Nc2kscPukL9rSh381r25mtlecAi/8zbCF86qF1V2u3hY
 Oc4Wk8MYZbW8T1LB9N5dDqHojBQXAyyjxwLThkfka1em5pmuldn8gX2khKAvnJCeD2EMaNxC5
 w1pOgD2naV1On0SwaLWG6T2yIzle7elNEfcf+VVNvIbbtVo+/m+OU2Aeu8tWJL5BLRji6p6Kj
 /Sn+ewRThWieFtXiELHb+lkRJX9TTpcX5RzXKYp2txIJHcTytqVa7KvTMKZnZUO9hy++LJO5q
 BtW1EdqeOK//Nw5AmMkMQvlZKqeCPHrsbccBoBsVOiOzKaQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 14:24:38 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/efs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..176061d107ed 100644
=2D-- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -262,7 +262,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_blo=
ck_t block) {
 			/* should never happen */
 			pr_err("couldn't find direct extent for indirect extent %d (block %u)\=
n",
 			       cur, block);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

@@ -274,8 +274,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_blo=
ck_t block) {
 			(EFS_BLOCKSIZE / sizeof(efs_extent));

 		if (first || lastblock !=3D iblock) {
-			if (bh) brelse(bh);
-
+			brelse(bh);
 			bh =3D sb_bread(inode->i_sb, iblock);
 			if (!bh) {
 				pr_err("%s() failed at block %d\n",
@@ -295,17 +294,17 @@ efs_block_t efs_map_block(struct inode *inode, efs_b=
lock_t block) {
 		if (ext.cooked.ex_magic !=3D 0) {
 			pr_err("extent %d has bad magic number in block %d\n",
 			       cur, iblock);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

 		if ((result =3D efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			in->lastextent =3D cur;
 			return result;
 		}
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	pr_err("%s() failed to map block %u (indir)\n", __func__, block);
 	return 0;
 }
=2D-
2.23.0

