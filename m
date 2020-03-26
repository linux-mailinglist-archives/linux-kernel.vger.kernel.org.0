Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2001943E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgCZQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 12:00:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52634 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgCZP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:58:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155840euoutp0284ccb6099671686a157e740d227c3e73~-5dqXp6ue0032300323euoutp02g
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155840euoutp0284ccb6099671686a157e740d227c3e73~-5dqXp6ue0032300323euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238320;
        bh=FV2/1ssMG2Cbo2pRH3m8Ewx5rRnKGTiLv8c1eZ2ToC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9yrWiBTgHR5rFMxtB5DjCKTHtd2sz4hIFI06lcRkADcPNbEHH1o7q/hBZpgmhusk
         tnPjtNjrFq0I4BT8W8gLaPtwDdVA4UXZKS2o0hKVxrkNVmEjzaDsES/9eRPMWH0oIe
         4j50ABohKuywIMg+KsnE884QxcQrkMfKi/KhbaGo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155840eucas1p148e9ba2a0e089923545ed928fce19196~-5dp_D32_0941109411eucas1p1g;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.E7.60698.031DC7E5; Thu, 26
        Mar 2020 15:58:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eucas1p1d5c84c9070fd1a1282b590172be640b1~-5dpfl6dJ0941109411eucas1p1f;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155839eusmtrp19ddf1a59c4ef5f96a1ed53f33a2de1a7~-5dpfA7Kx2090020900eusmtrp1Y;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-85-5e7cd130bce8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.5A.08375.F21DC7E5; Thu, 26
        Mar 2020 15:58:39 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eusmtip15eb3640f74cca18fb88a7e3a4bba0bb2~-5dpHP2tu1233412334eusmtip1u;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 04/27] sata_promise: use ata_cable_sata()
Date:   Thu, 26 Mar 2020 16:57:59 +0100
Message-Id: <20200326155822.19400-5-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87oGF2viDP7MEbNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmNb5pYC+5xV8x5PYW1gfE1ZxcjJ4eE
        gInEnhPbmLsYuTiEBFYwSmw+0cMC4XxhlJh2dCcLSJWQwGdGiedb/WE6nr27BlW0nFFizqm5
        THAdh74fBOtgE7CSmNi+ihHEFhFQkOj5vZINpIhZ4D2jxIpJe4GKODiEBWwkzsyuAKlhEVCV
        WD77FFgvr4CtxMxHC1kgtslLbP32iRXE5hSwk1i+bj4zRI2gxMmZT8BqmIFqmrfOZoaoX8Yu
        cXdWLITtInFy4j8mCFtY4tXxLewQtozE6ckQb0oIrGOU+NvxghnC2c4osXzyPzaIKmuJO+d+
        sYEcyiygKbF+lz5E2FHiT8dZJpCwhACfxI23ghA38ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1
        XTtXQp3pIXHjeDvzBEbFWUi+mYXkm1kIexcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P
        3cQITEOn/x3/uoNx35+kQ4wCHIxKPLwNbTVxQqyJZcWVuYcYJTiYlUR4n0YChXhTEiurUovy
        44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamCcs8xxge75F0lse87dLftz
        YKnTLLacf1z9jVmPbE7nGXKF/3HVOhr4db7DZMOdTxs+Wu+6uXy/vZP4k4akuy0fC1Tf71i8
        JSR9xXfJZtaDjawVr3TqJrHG6184cX7bGRPlZ7M4PwUp13aaX9J39mjnka0x/VvJHPDo3NLY
        w/eX6H+Zd2Vq5en5SizFGYmGWsxFxYkAu0wcUD8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7r6F2viDNatM7NYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmNb5pYC+5xV8x5PYW1gfE1ZxcjJ4eEgInEs3fXWLoYuTiEBJYySnSc
        PAvkcAAlZCSOry+DqBGW+HOtiw2i5hOjxNKuWawgCTYBK4mJ7asYQWwRAQWJnt8rwYqYBb4C
        FU3qZgYZJCxgI3FmdgVIDYuAqsTy2adYQGxeAVuJmY8WskAskJfY+u0T2ExOATuJ5evmM4PY
        QkA1i798YIKoF5Q4OfMJWD0zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0
        L10vOT93EyMwXrYd+7l5B+OljcGHGAU4GJV4eDVaauKEWBPLiitzDzFKcDArifA+jQQK8aYk
        VlalFuXHF5XmpBYfYjQFemIis5Rocj4wlvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTDWmT0462zrX6s4Iy8oyiZp/oFpdg80JoRVbo9Sja940xL6+Kll++Oz
        P3dMd7qms+T+Rv2244sif/0SWKvJkWa4tq/G2/fO7JmTPlybpil3Npl7Klfkq21t8c2J/E4v
        On6pRn57dPPMiczKbQ8VmlOTny3Luzd/rxifLM/mzo2fXz3bFmb8ndVIiaU4I9FQi7moOBEA
        pFqFsa0CAAA=
X-CMS-MailID: 20200326155839eucas1p1d5c84c9070fd1a1282b590172be640b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155839eucas1p1d5c84c9070fd1a1282b590172be640b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155839eucas1p1d5c84c9070fd1a1282b590172be640b1
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155839eucas1p1d5c84c9070fd1a1282b590172be640b1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use core helper instead of open-coding it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_promise.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c451d7d1c817..8729f78cef5f 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -157,7 +157,6 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 static void pdc_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 static int pdc_pata_cable_detect(struct ata_port *ap);
-static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
 	ATA_BASE_SHT(DRV_NAME),
@@ -183,7 +182,7 @@ static const struct ata_port_operations pdc_common_ops = {
 
 static struct ata_port_operations pdc_sata_ops = {
 	.inherits		= &pdc_common_ops,
-	.cable_detect		= pdc_sata_cable_detect,
+	.cable_detect		= ata_cable_sata,
 	.freeze			= pdc_sata_freeze,
 	.thaw			= pdc_sata_thaw,
 	.scr_read		= pdc_sata_scr_read,
@@ -459,11 +458,6 @@ static int pdc_pata_cable_detect(struct ata_port *ap)
 	return ATA_CBL_PATA80;
 }
 
-static int pdc_sata_cable_detect(struct ata_port *ap)
-{
-	return ATA_CBL_SATA;
-}
-
 static int pdc_sata_scr_read(struct ata_link *link,
 			     unsigned int sc_reg, u32 *val)
 {
-- 
2.24.1

