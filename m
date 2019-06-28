Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA65919D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfF1CsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:48:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43161 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF1CsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:48:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so2179039pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rbEYaNHREF7ILO8RRtmtvzlf2nFn3SyNQ4zDhV4ZIpU=;
        b=cXUsk7BHAAfEVytNrzbRMTTG4qVyMNRVSl+DrUV9V3TCuzZWX3xZ4YeirpHRbwVcpm
         Rn5bqs3PxJsL7UeHjFN+/WFjSEGisWQQI0tTLV7Kj7cwtD1cQn7kB5IdCFvhH648lUQj
         bjDmy1p2PHFWbbTmLiUdHJ7JYVhVW11jyIq2vwHBURj0xL28wk0n+O2fCC4Wqsv+M50u
         Rx2XhUX9ulKzQvuUs0f8feHOl+dr/E72IB4pT5MYyV1z33OE6igRhdCBSENW9P1RwUBf
         09s3PImIxR3WVMGdDFmuiwYa9Ce/cSqKjNP3LzJLI4fsYppVKnqdBICpCby6xgIQQBwN
         PnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rbEYaNHREF7ILO8RRtmtvzlf2nFn3SyNQ4zDhV4ZIpU=;
        b=ddiiueenES3GsH1ElgKUS8FvxVBkJ6MM1GHYIs2dN0IO3Qe35L4SA/G30iO419dh5D
         0lolwrW2zl1+48Ips6/xMQXaAHhAYqNPELgeiVi7eA3u1A8nscjpGpmM52WStMKge7+R
         ajDSsOSi7YtUsCbEY9ANv785gH9Fkq3vE0zHTos8QKsDLoZMkEYaKbh3kRqb6mHgWWpD
         JXvyN0/kGPIIV/Ga9i7BZ1q5eBhABgovkS/69C/a7bUZylAxr5wLqaeOxN7n6zaT6Y4C
         jGMHult6eByaOcGDlo4Y8s3vIEHG8u05GDbLjPkOqaX5MSFPE19GIK6E4K4LqveF9Uf4
         347Q==
X-Gm-Message-State: APjAAAXjm1YDl6dMWtoo8GbaYBVpMqWH3BrljOZO812L3iW71zfqubAM
        JcMuaOzunv1pVM/4m6Oe4P0=
X-Google-Smtp-Source: APXvYqyL2BSk1/B6CxNzvp6a0kmRsoEyOhjwRgO0mLmLEFYVVmbnWhj10DWx9yPVJWrNGPu1UtSwjA==
X-Received: by 2002:a63:e90b:: with SMTP id i11mr7002772pgh.351.1561690101460;
        Thu, 27 Jun 2019 19:48:21 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i123sm446277pfe.147.2019.06.27.19.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:48:21 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/27] mtd: nand: use kzalloc instead of kmalloc and memset
Date:   Fri, 28 Jun 2019 10:48:13 +0800
Message-Id: <20190628024814.15527-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc followed by a memset with kzalloc.

There is a recommendation to use zeroing allocator
rather than allocator followed by memset with 0 in
./scripts/coccinelle/api/alloc/zalloc-simple.cocci

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mtd/nand/raw/nand_bch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index 55aa4c1cd414..17527310c3a1 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -170,7 +170,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 	}
 
-	nbc->eccmask = kmalloc(eccbytes, GFP_KERNEL);
+	nbc->eccmask = kzalloc(eccbytes, GFP_KERNEL);
 	nbc->errloc = kmalloc_array(t, sizeof(*nbc->errloc), GFP_KERNEL);
 	if (!nbc->eccmask || !nbc->errloc)
 		goto fail;
@@ -182,7 +182,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 
 	memset(erased_page, 0xff, eccsize);
-	memset(nbc->eccmask, 0, eccbytes);
 	encode_bch(nbc->bch, erased_page, eccsize, nbc->eccmask);
 	kfree(erased_page);
 
-- 
2.11.0

