Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5226815B0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBLT1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 14:27:19 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.101]:20276 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgBLT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:27:19 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 4DD57432E3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:25:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1xddj19VjvBMd1xddjzoKe; Wed, 12 Feb 2020 13:25:33 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yw0TNGO/aORoCtmP+MBqxiUhZyXSWK2un4Zm/19bNpU=; b=YbFm2LNA/HB7hYDqEuTGCOkYQC
        bxST4UXDTm2HiZ4KgZl0BUnokuStDzILXMNwzOR7Ffy1ccPO3Jb8gDtS+FpUBfJecTjO/+MybiDam
        rjOfb7yjeib2GOEgFRqYBQLtlzl+0R6+yO2eVNwj5mRhUCs3Gey2PDisW6hJWv/+OmBQk1y6q4Xe+
        EX0F882QfjId4sjDTN8NNHpCd8oDer37TlY+Ot0wtHJXsBcdDw92SzA+BotY8vnGGhVzs2Z2U3NJ+
        DLyxaqZVFpcaFQAACEul6k6C3M6STZFQmYMo5i/DGsUnT/rk9XOdLtYLsrfk3Jldh5sXmYXediAcB
        imq9A1Jg==;
Received: from [201.144.174.25] (port=30860 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1xdb-0014wK-SO; Wed, 12 Feb 2020 13:25:32 -0600
Date:   Wed, 12 Feb 2020 13:28:07 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Bluetooth: btintel: Replace zero-length array with
 flexible-array member
Message-ID: <20200212192807.GA25300@embeddedor>
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
X-Source-IP: 201.144.174.25
X-Source-L: No
X-Exim-ID: 1j1xdb-0014wK-SO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.25]:30860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
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
inadvertenly introduced[3] to the codebase from now on.

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
 drivers/bluetooth/btintel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 62e781a18bf0..6a0e2c5a8beb 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -376,13 +376,13 @@ struct ibt_cp_reg_access {
 	__le32  addr;
 	__u8    mode;
 	__u8    len;
-	__u8    data[0];
+	__u8    data[];
 } __packed;
 
 struct ibt_rp_reg_access {
 	__u8    status;
 	__le32  addr;
-	__u8    data[0];
+	__u8    data[];
 } __packed;
 
 static int regmap_ibt_read(void *context, const void *addr, size_t reg_size,
-- 
2.25.0

