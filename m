Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68DC1337DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 01:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgAHAQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 19:16:52 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42106 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:16:51 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 620A98364F;
        Wed,  8 Jan 2020 13:16:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578442609;
        bh=Mo5sa6h3H08lZ8ssx1DN1B4tuBT+AZc2trcKFgDOxHk=;
        h=From:To:Cc:Subject:Date;
        b=QsF6+xke2/mv+U5cHYAAoO8skfWDxu8fxrI2SL7exy+7ohp1hV50/AWjGA+pHeclS
         KRcQUmoYeWiITM08tjNAVJpukFjokIKIX0UrXkcNkBbcScd/u3Y8YW3EyGxN0MrE8w
         Vn3o9K5PcNUkA5u9y3xLxNFaxgzQ6jEAORwsYR0euQmR2+BK0eqeTwYLK3fTJ7qXrM
         QG0j8X+goEAz0MuqO1rG3XgDUSGQK1yUT8fzUs2OsnaYo/gDiEliZEP1JgDQz40qMJ
         CG6oLxK/lgV15nSVVrwDS6TKKnyUVe17jtR7vwQAVMWAT+0uEqPLeZdixDHLNEzBV6
         kjOE5iS8PRwQA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e151f710000>; Wed, 08 Jan 2020 13:16:49 +1300
Received: from oscarr-dl.ws.atlnz.lc (oscarr-dl.ws.atlnz.lc [10.33.24.28])
        by smtp (Postfix) with ESMTP id E7DEE13EEA1;
        Wed,  8 Jan 2020 13:16:47 +1300 (NZDT)
Received: by oscarr-dl.ws.atlnz.lc (Postfix, from userid 1607)
        id 192C03C8FF8; Wed,  8 Jan 2020 13:16:49 +1300 (NZDT)
From:   Oscar Ravadilla <oscar.ravadilla@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Oscar Ravadilla <oscar.ravadilla@alliedtelesis.co.nz>
Subject: [PATCH] uio: uio_pdrv_genirq: Do not log an error when deferring probe routine.
Date:   Wed,  8 Jan 2020 13:16:48 +1300
Message-Id: <20200108001648.2949-1-oscar.ravadilla@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deferring the probe routine just return without displaying an
error.

Signed-off-by: Oscar Ravadilla <oscar.ravadilla@alliedtelesis.co.nz>
---
 drivers/uio/uio_pdrv_genirq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.=
c
index 1303b165055b..fc25ce90da3b 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -156,6 +156,8 @@ static int uio_pdrv_genirq_probe(struct platform_devi=
ce *pdev)
 		uioinfo->irq =3D ret;
 		if (ret =3D=3D -ENXIO && pdev->dev.of_node)
 			uioinfo->irq =3D UIO_IRQ_NONE;
+		else if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
 		else if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get IRQ\n");
 			return ret;
--=20
2.23.0

