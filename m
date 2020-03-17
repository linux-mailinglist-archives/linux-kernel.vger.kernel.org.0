Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23A41887F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCQOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:45:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40378 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgCQOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:43:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144344euoutp02906398b2e8b502fb8fd95724b85c2c0f~9Hoqe2VWO1539415394euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144344euoutp02906398b2e8b502fb8fd95724b85c2c0f~9Hoqe2VWO1539415394euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456224;
        bh=IPEAdF5M/5mqo/dLId8rLp0SHEVTaVMyz1UVsYoLNgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHaJfgGdi+7tLNTQpYQbEZP0EHuytS4ydpaQwPbFy3/Tzwk4JO5C2YgsR2Qgk5wbe
         caPvtu6lm86zRc3BxPWjQc14qQ2HAkBaYbph49h7U3oijnCvUpJFSNMD3qFhnrSds9
         ExO/YpBZroYXCei83SIHwt09XPc+QC7F8iKIMd3Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144344eucas1p2411142c2ad7b0ce36dad1f9defd21e85~9HoqJbgs90560005600eucas1p2L;
        Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.E9.60698.022E07E5; Tue, 17
        Mar 2020 14:43:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144343eucas1p2eb0fa17c0130d3be0b994110979e6a87~9HopxaRGW0133301333eucas1p2i;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144343eusmtrp24aa316847d60f74af0161a78114c0301~9HopwzsSY0147801478eusmtrp21;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-df-5e70e22015d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.23.07950.F12E07E5; Tue, 17
        Mar 2020 14:43:43 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144343eusmtip1997c9f2110433d3e0b10e4a81dc8e4c1~9HopTah7E0973009730eusmtip1V;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 06/27] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
Date:   Tue, 17 Mar 2020 15:43:12 +0100
Message-Id: <20200317144333.2904-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87oKjwriDPY381qsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozDT1ewFTzgrfjb38bUwLiPu4uRk0NC
        wETi/Mlu5i5GLg4hgRWMEo/OdLJBOF8YJc5uWcgE4XxmlLh6t4URpmXNn81QieWMEi8Ov2aH
        a1nTvRasik3ASmJi+yowW0RAQaLn90qwucwC7xklVkzaywKSEBYIlVixoR9oOwcHi4CqRMde
        B5Awr4CNxJ6eU2wQ2+Qltn77xApicwrYSlw7/I8NokZQ4uTMJ2BjmIFqmrfOBntCQmAVu8T5
        zkvMEM0uErev72SCsIUlXh3fwg5hy0j83zmfCaJhHaPE344XUN3bGSWWT/4Htdpa4s65X2wg
        1zELaEqs36UPEXaU+NP7gREkLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfO
        lVAlHhJ3tjBPYFScheSbWUi+mYWwdgEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
        RHT63/GvOxj3/Uk6xCjAwajEw5uwqSBOiDWxrLgy9xCjBAezkgjv4sL8OCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYu57aGyzzaZsQbug6/bxC5MPQ
        3fn7ij69yWzXX/z/ZPbKtVFHhBxXpWwNrpASco4LnBeam7N5eoWIxctlZkf2rVK5HO9mYB3g
        sVdtU9z2e9v3vN21a7+iz22P5/5rn+yTsDaUqmYX9H5cV5eXULDkTGDq+T22mvY7z8k/erhE
        79Ee7jWae68dUWIpzkg01GIuKk4EAFFEd2pAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7ryjwriDP4dN7BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmHn65gK3jAW/G3v42pgXEfdxcjJ4eEgInEmj+bmUBsIYGljBIn2xS6
        GDmA4jISx9eXQZQIS/y51sXWxcgFVPKJUeLbzifsIAk2ASuJie2rGEFsEQEFiZ7fK8GKmAW+
        MkosndTNDJIQFgiW+L9tKjPIUBYBVYmOvQ4gYV4BG4k9PafYIBbIS2z99okVxOYUsJW4dvgf
        G8Q9NhIv3vxngqgXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiMlm3Hfm7Zwdj1LvgQowAHoxIPL8eGgjgh1sSy4srcQ4wSHMxKIryLC/Pj
        hHhTEiurUovy44tKc1KLDzGaAv0wkVlKNDkfGMl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYD0rJndyjuLHBJYDlZ/S8/gUuvLd+Zoq4xB0r0b24bVbEsZST
        1apn279p896+ecf22/sS7qkOm/+XWKRH7n28n+uE6KLkgElmXQGVrBwuUUU9J40mfJW896Ht
        59snvOF3mIJnPBb/338+41Lo++2aPxb8bFVjl3BKqJuycL7mNYk7T33D7/zXU2Ipzkg01GIu
        Kk4EADDF4rKsAgAA
X-CMS-MailID: 20200317144343eucas1p2eb0fa17c0130d3be0b994110979e6a87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144343eucas1p2eb0fa17c0130d3be0b994110979e6a87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144343eucas1p2eb0fa17c0130d3be0b994110979e6a87
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144343eucas1p2eb0fa17c0130d3be0b994110979e6a87@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use COMMAND_LINE_SIZE instead PAGE_SIZE for ata_force_param_buf[]
size as libata parameters buffer doesn't need to be bigger than
the command line buffer.

For many architectures this results in decreased libata-core.o
size (COMMAND_LINE_SIZE varies from 256 to 4096 while the minimum
PAGE_SIZE is 4096).

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064    4413      40   45517    b1cd drivers/ata/libata-core.o
after:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1b509ccc67f3..0c9ac46d3109 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -52,6 +52,7 @@
 #include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <asm/setup.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/libata.h>
@@ -106,7 +107,7 @@ struct ata_force_ent {
 static struct ata_force_ent *ata_force_tbl;
 static int ata_force_tbl_size;
 
-static char ata_force_param_buf[PAGE_SIZE] __initdata;
+static char ata_force_param_buf[COMMAND_LINE_SIZE] __initdata;
 /* param_buf is thrown away after initialization, disallow read */
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/admin-guide/kernel-parameters.rst for details)");
-- 
2.24.1

