Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3918C325
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCSWoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 18:44:38 -0400
Received: from gateway30.websitewelcome.com ([192.185.197.25]:46929 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgCSWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:44:37 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6E1AD157F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:44:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F3u1jSoXAVQh0F3u1jhnXV; Thu, 19 Mar 2020 17:44:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mdi7bmeTSr1/QS6tVQ+v3Sjx4frkWAZO7zkZil/DZh0=; b=hKH/5423jQln3zUYwq6hcU4rwz
        Zil2ZawfzkpYfYAPvZiW6BKI3dBmA0U9uiwZjFp3XHh1WkZT3NoRBSjPg9pmkd2T1nkPGMALFbqas
        9bxe6hBISKJyXAzb0cQ6mx8q0AbdrVkoj7T2TVw7uD+g56o7hzVwHcf6cmuXW9oLvqkSQQ54YwDN5
        oJ4gjsyS4Ay4ZNJWhqteTWa3Gu34v5yQz3gZmqxKHvVGW2HgE3ng25ZoJ+1Y5gP5jcFSxmgoOY+Jg
        srfOBojXHRt5tVkjAEaoTYyKSJ2TDDzs16qe2ApTJWy/7+SFvaXQ7pDvxP8cpxHn/cvGMSz0w0Nnh
        vmj0Slsw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53960 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF3tz-002Dtq-Qb; Thu, 19 Mar 2020 17:44:35 -0500
Date:   Thu, 19 Mar 2020 17:44:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] mtd: ubi: ubi-media.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319224435.GA25590@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jF3tz-002Dtq-Qb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53960
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/ubi/ubi-media.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
index b5fe8f82281b..386db0598e95 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -498,6 +498,6 @@ struct ubi_fm_volhdr {
 struct ubi_fm_eba {
 	__be32 magic;
 	__be32 reserved_pebs;
-	__be32 pnum[0];
+	__be32 pnum[];
 } __packed;
 #endif /* !__UBI_MEDIA_H__ */
-- 
2.23.0

