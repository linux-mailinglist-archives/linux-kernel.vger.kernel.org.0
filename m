Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807E3191FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 04:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYDTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 23:19:08 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52009 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYDTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:19:08 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 16A3780237;
        Wed, 25 Mar 2020 16:19:04 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1585106344;
        bh=44FbT0mY8dOR0hwrYqg7wYOelRc5U4Tpq4XNZFjkj7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BLEduHMykXfOplW6ragwvQQqpcdRpobJPpQFFburhQek0Z80PQCnS496Yk4YEpXPs
         dkS/F4EOvcT80UScHmghxLCzBrsNtCkMPo620PIaLTc/+Xru/e/QFQNPY9y9dNGEPP
         RpvhySnIFFD2VTLo68s0nc7GP5RGbTilU9KDZN4Ig6QogFIMeV8u+roM+iLsOA+Xhs
         bF1gE0VauUcbHIDk5S6SXv9AbhRNUBcl6QBh73HxeenFBLRyHBB+s4Z+LicGgWsej2
         0Rs5YfVsFSz6i4tZIbiW/uv40nPXbZgFwkP9qqr+K8/BKiglc3UpNABDfW4wwDXnzG
         fjbV1Ml2naPaQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e7acda20000>; Wed, 25 Mar 2020 16:19:03 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3866C13EEB7;
        Wed, 25 Mar 2020 16:18:58 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CF44A28006C; Wed, 25 Mar 2020 16:18:58 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr, tglx@linutronix.de, oss@buserror.net
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] powerpc/setup_64: Set cache-line-size based on cache-block-size
Date:   Wed, 25 Mar 2020 16:18:54 +1300
Message-Id: <20200325031854.7625-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dd342c71e03e654a8786302d82f9662004418c6e.camel@alliedtelesis.co.nz>
References: <dd342c71e03e654a8786302d82f9662004418c6e.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If {i,d}-cache-block-size is set and {i,d}-cache-line-size is not, use
the block-size value for both. Per the devicetree spec cache-line-size
is only needed if it differs from the block size.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
It looks as though the bsizep =3D lsizep is not required per the spec but=
 it's
probably safer to retain it.

Changes in v2:
- Scott pointed out that u-boot should be filling in the cache properties
  (which it does). But it does not specify a cache-line-size because it
  provides a cache-block-size and the spec says you don't have to if they=
 are
  the same. So the error is in the parsing not in the devicetree itself.

 arch/powerpc/kernel/setup_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
index e05e6dd67ae6..dd8a238b54b8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -516,6 +516,8 @@ static bool __init parse_cache_info(struct device_nod=
e *np,
 	lsizep =3D of_get_property(np, propnames[3], NULL);
 	if (bsizep =3D=3D NULL)
 		bsizep =3D lsizep;
+	if (lsizep =3D=3D NULL)
+		lsizep =3D bsizep;
 	if (lsizep !=3D NULL)
 		lsize =3D be32_to_cpu(*lsizep);
 	if (bsizep !=3D NULL)
--=20
2.25.1

