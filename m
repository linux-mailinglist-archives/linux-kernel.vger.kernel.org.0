Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651B565FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfGKTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 15:22:36 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50156 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:22:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 5A478C55
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 19:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RqDjoynalEP0 for <linux-kernel@vger.kernel.org>;
        Thu, 11 Jul 2019 14:22:34 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 2A5DCC7F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:22:34 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id s9so7836845iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=04r+xkfi3OIxIAnYMbyBVwPuxdAwHrdKDxo/QJz9TXo=;
        b=kRCDtdkKWDupkwiDvuAHjTjjn6YF6vYe+M23iFm7rjC9nCrglDHxUtsu9IqVnPNCUw
         f1efLF/yBqTHqxnNCsqMC4iZCGCu2FiBJBRDofzVGoOeNd1aEjcIB3EQ1AecMz19ls4Q
         dkJKau+qfJRQnsQC5BgI9cI259ChqPd/LRs1T8/1UjSsrNMWjzAvNTrTYhhfhByM8ai/
         Fuy1f00937LWrXRFuBCiNieNncfblHnTD2if+0J8Vk9a5qUW1mqEmI0EFKblfyvyuy65
         VQbiEGyFf9+GcFtQ2laOCumU/cr+x85rQKzlqHBKqeUsuf8jfQG6ciLpHJnq70t0Mhpk
         WJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04r+xkfi3OIxIAnYMbyBVwPuxdAwHrdKDxo/QJz9TXo=;
        b=W80I306JBpnTp98ifPntpP16303xFEYluBP9ESrQVd6ZnNnk3Pu0vTgletfWCTu/GA
         YL8bL59Ug4FBoNvXXrDj4SjhgAPdeOcKC72YcjRfQ03R5iI2z+PXBMarwUrZ4fc71Fu0
         zALb2nV+1AEVOObnKKmkaWctBW337lEAEjbZV8nTTIiEpl1QoUpvP0/B4d90prOxuj6u
         mGik3oNG2J37TSe/3OAC30nEsTv247MJa3TmKyzINhI2Xid2i3cCRr8o2frGWFS1A0JP
         t3eS7Vhnv86JGXKyHWLNPzR3HCqLm47GMkK/08C3gKqgGnvoUH7Qce10S7eMGfCuWHfB
         COBg==
X-Gm-Message-State: APjAAAVbfz5y7/URxf5lB5CUnKtw/iCvdqORU2BZVtQATs/4GDT/IVS9
        3uLUTabXDEeGom7NcLbpS49CjRsXu32qQi0J0iTWbzI0B8TDjeInHPkGT0yI4PXT2704ZNA9c0C
        nXBldk1RK9SYLmcj9wiwq8ABfrxO2
X-Received: by 2002:a6b:f711:: with SMTP id k17mr5891513iog.273.1562872953858;
        Thu, 11 Jul 2019 12:22:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/oBuIk60mhI4isOWmFv2H/1EonKWKX/fEvEckRCa0a+lY1XboOURnqhKOt66OGfCLdBxd3A==
X-Received: by 2002:a6b:f711:: with SMTP id k17mr5891495iog.273.1562872953548;
        Thu, 11 Jul 2019 12:22:33 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id 8sm5505611ion.26.2019.07.11.12.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jul 2019 12:22:32 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] block/bio-integrity: fix a memory leak bug
Date:   Thu, 11 Jul 2019 14:22:02 -0500
Message-Id: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
hold integrity metadata. Later on, the buffer will be attached to the bio
structure through bio_integrity_add_page(), which returns the number of
bytes of integrity metadata attached. Due to unexpected situations,
bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
needs to be terminated with 'false' returned to indicate this error.
However, the allocated kernel buffer is not freed on this execution path,
leading to a memory leak.

To fix this issue, free the allocated buffer before returning from
bio_integrity_prep().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 block/bio-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4db6208..fb95dbb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -276,8 +276,12 @@ bool bio_integrity_prep(struct bio *bio)
 		ret = bio_integrity_add_page(bio, virt_to_page(buf),
 					     bytes, offset);
 
-		if (ret == 0)
-			return false;
+		if (ret == 0) {
+			printk(KERN_ERR "could not attach integrity payload\n");
+			kfree(buf);
+			status = BLK_STS_RESOURCE;
+			goto err_end_io;
+		}
 
 		if (ret < bytes)
 			break;
-- 
2.7.4

