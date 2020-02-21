Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7999B1681E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBUPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:37:40 -0500
Received: from gateway20.websitewelcome.com ([192.185.46.107]:31521 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgBUPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:37:40 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3C591400ED3DA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:20:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 5AK2jR7buvBMd5AK2jNzoC; Fri, 21 Feb 2020 09:34:34 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GKpPXo3AQzEVA4yK0J3aDuF9U4AWBQfi0jCw2uWOJA8=; b=Xyhucb8TPqtTHYPTm2KwEZzI9v
        45aburvxF5dgGvB7X/qjNl/CI03acT8Ulf3aZRD9UXd8WVUFurj4/CkeWrhVD8/9Y6xeLlKDxZZSB
        UTWifZN/qWkO6EIo1Sj3SX8ab7l4vO34ZfRMxyqGxjJReS6FUmJJzX+YuqPQvcVu929mFuZI+bCcb
        m/dgRBnVx0AUA6/3ArS1P6uAmPJSxAm9CLJioK6KrFGSaz7a7kqD2pZFHk5gKjtammRf+bZw9JFav
        xzJ1N2xp3G12T06yef4KVb0Qiv2EAQ3AO0xmcxBvxURNAjTs2/W2lApFMK5o1LjB4Dmlc61mlqSNe
        YOtTsfpg==;
Received: from [200.68.140.54] (port=28252 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j5AJy-003jkr-Vk; Fri, 21 Feb 2020 09:34:32 -0600
Date:   Fri, 21 Feb 2020 09:37:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pcdp: Replace zero-length array with flexible-array member
Message-ID: <20200221153713.GA23760@embeddedor>
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
X-Source-IP: 200.68.140.54
X-Source-L: No
X-Exim-ID: 1j5AJy-003jkr-Vk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.54]:28252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
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
 drivers/firmware/pcdp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/pcdp.h b/drivers/firmware/pcdp.h
index ce75d1da9e84..e02540571c52 100644
--- a/drivers/firmware/pcdp.h
+++ b/drivers/firmware/pcdp.h
@@ -103,6 +103,6 @@ struct pcdp {
 	u8			creator_id[4];
 	u32			creator_rev;
 	u32			num_uarts;
-	struct pcdp_uart	uart[0];	/* actual size is num_uarts */
+	struct pcdp_uart	uart[];	/* actual size is num_uarts */
 	/* remainder of table is pcdp_device structures */
 } __attribute__((packed));
-- 
2.25.0

