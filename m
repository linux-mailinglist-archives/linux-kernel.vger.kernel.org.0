Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0F1887EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCQOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:43:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45855 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgCQOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:43:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144342euoutp01c7cb8f2e6399a4b812f7f22954b76dbb~9HooTxsRM2320923209euoutp01A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200317144342euoutp01c7cb8f2e6399a4b812f7f22954b76dbb~9HooTxsRM2320923209euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456222;
        bh=YgzzcaS5NUM3OfHYGGcwjzOhwIiCbrUhSSxtwGcWWi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTdiE/oLoXieAmLU17La55H06Tf9Br5tqMlkET/ti5hcp+dZp5VHPA+T7HbWS1Uxg
         LWTcOGVpe4iPZPNV74FvEgmogKNTFQo+JI8wMt92ikNE6ctIN3lEo56cpHEV46Td8b
         c3gksJgI2oe6Q5ttRPbn0O7xNTiHTlzWOna+YWTE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144341eucas1p1b57682facd317a8839cbe1ee0575ac9e~9Honry4Cr1084010840eucas1p1T;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.E1.60679.D12E07E5; Tue, 17
        Mar 2020 14:43:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144341eucas1p2f76d3656e5d787e000b25da8f0d3b7c2~9HonWX7ZG0343503435eucas1p2F;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144341eusmtrp21a1ce781828a0df7c5a3538c21d1126c~9HonVw--30147801478eusmtrp2t;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-32-5e70e21deefc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.23.07950.D12E07E5; Tue, 17
        Mar 2020 14:43:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144340eusmtip145214e4c872f19ebe9a6abf43a7f1d3e~9HomuRWoS0973309733eusmtip1O;
        Tue, 17 Mar 2020 14:43:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 01/27] ata: remove stale maintainership information from
 core code
Date:   Tue, 17 Mar 2020 15:43:07 +0100
Message-Id: <20200317144333.2904-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/e9sZ2fS7LhJvphZHSoqzHtwUAuFylOfunwIorSpJzVva8eZ
        +skQbYp4RdSlpUnOC16bOrUi5i2J8oMX1LRAzUwyaoqiecntaPnteZ/3efj9X/gTmMwgciAi
        YuJYVYwiisKtha29qwNnDk0pA91yB4/RtZPZON1U1CCiZ8dfC+jq2h4B3WuYEtCDHSU4rZup
        w+jS1EIxvabrQX4Spl07KWYGP6iZ5pp0nDF2aRDTn7osZDrHknEmS1+DmMVmp6vELWvfUDYq
        Ip5VuZ6/ax1eWaoVKfPlCQvTQ3gyero/A0kIIL1gteSzIANZEzKyCkGJZkLID0sI3pk0O8Mi
        guGVMdFuZWR9DjNrGalD8Put97/GSJFRbF7gpDfkPq5BZm1HHoHMP9W4OYSRmQLIN4xY2nLy
        JrxIX7cUhORxqPjabfGlpC9svkkW8rTD0LJsspAl5DkY6drE+Ywt9BfPWDLYdial5QlmBgDZ
        KoZfxS1ivnwBNsq+7Gg5zPfpd7QjbLU/E/CFegQbmrmddhsCXT6PANIHJj6ubWtiG3EKGjpc
        edsf6trLkdkG0gZGF2z5R9hAXmshxttS0KTJ+PQJaKxsxHexGe3VGK8ZGMssF+ago9o952j3
        nKP9zy1DWA2yZ9VcdBjLecSwD104RTSnjglzCYmNbkbb/+n9Zt+SAXWsBxsRSSBqn5RoVAbK
        RIp4LjHaiIDAKDtpxYPYQJk0VJGYxKpig1TqKJYzooOEkLKXej7/fkdGhini2EiWVbKq3a2A
        kDgkIz/NK3+r0oE1n6H00hn9vdTxQdPafNJLj5PuvRrJfUO1whRAOd+4fMC02lQQWnWF+zaq
        ph5FFlD53fqE+ovDKz+VqOBSyqJMMBtgk4e5nZOHeGFFt7OmtyrcNrx9EoKudTVRGbS7MS3N
        yvNTq5PzWcfOnMyi7Np+3Y/g66kdbZSQC1e4n8ZUnOIvwnGfB0sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7qyjwriDP7t5LFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA6bFz1l12j8tnSz02repk
        8zh0uIPR42TrNxaP3Tcb2Dz6tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY9ncWawFk4Ur3j6+wtbAOI+/i5GTQ0LAROLanxfM
        XYxcHEICSxkl9i9dC+RwACVkJI6vL4OoEZb4c62LDaLmE6PEwU8bWEESbAJWEhPbVzGC2CIC
        ChI9v1eCFTELTGKSWH23kR0kISwQKrHi3gE2EJtFQFVi8dMjzCA2r4CNxL99DSwQG+Qltn77
        BDaUU8BW4trhf2D1QkA1L978Z4KoF5Q4OfMJWD0zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0
        ODc9t9hIrzgxt7g0L10vOT93EyMwirYd+7llB2PXu+BDjAIcjEo8vBwbCuKEWBPLiitzDzFK
        cDArifAuLsyPE+JNSaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YITnlcQbmhqaW1gamhubG5tZ
        KInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgzLINmi8oeuzmqYNzc1gvt2xzuKXcoBBsrx7P
        XRazQ0MzsXDeJc5g7YvcFkbatpNPZwq0rV8XJPxvg/+mf5fddvJ+XnVOVzK2Zk7LYeFAPv1p
        7WFMwhJSqT0f+gxbOqycCh5xfLjclJXD1NXkfTyLI8Fve+PsnJTjXN1LmM7/nCg365Ov1zwl
        luKMREMt5qLiRABTCN/uuAIAAA==
X-CMS-MailID: 20200317144341eucas1p2f76d3656e5d787e000b25da8f0d3b7c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144341eucas1p2f76d3656e5d787e000b25da8f0d3b7c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144341eucas1p2f76d3656e5d787e000b25da8f0d3b7c2
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144341eucas1p2f76d3656e5d787e000b25da8f0d3b7c2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7634ccd2da97 ("libata: maintainership update") from 2018
Jens has officially taken over libata maintainership from Tejun so
remove stale information from core libata code.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 4 ----
 drivers/ata/libata-eh.c   | 4 ----
 drivers/ata/libata-scsi.c | 4 ----
 drivers/ata/libata-sff.c  | 4 ----
 4 files changed, 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 175b2a9dc000..1b509ccc67f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2,10 +2,6 @@
 /*
  *  libata-core.c - helper library for ATA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
  *
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 388f8ed46eab..a14e26aa1391 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2,10 +2,6 @@
 /*
  *  libata-eh.c - libata error handling
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2006 Tejun Heo <htejun@gmail.com>
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f76ceb520f5e..5a4f43c85131 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2,10 +2,6 @@
 /*
  *  libata-scsi.c - helper library for ATA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
  *
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ffe633f13f55..dad59ce95c7d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2,10 +2,6 @@
 /*
  *  libata-sff.c - helper library for PCI IDE BMDMA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2006 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2006 Jeff Garzik
  *
-- 
2.24.1

