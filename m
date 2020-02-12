Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8A15B143
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgBLTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 14:43:31 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:35642 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727372AbgBLTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:43:30 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8A3EEB0AFE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:43:29 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1xuzjv4JS8vkB1xuzjt2Ds; Wed, 12 Feb 2020 13:43:29 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8FWXDkVW2wDjkeRVhdg2pGdPCjOZiCetHczI8jearAI=; b=wSKpavxf1MKDOkewMMDptIziQj
        DKEcF0hjxEfd0gk75Qp79sxH8dhY+hhDeWpcCIx9QAFYbqFP3+R7bFE+iVYGPE5y9Pwhw19A/7WhE
        wPYL/clnYeUdUCxyP/VgOMCW63JJulyeaEJUVyBYcyD8ZHMzXVFcvs00OyjQz5PUpnGAdfm5vE1SA
        mJ4ThVrzbKA0dEo3MwZsh2ma+OPwToVT3lxS683aHSHTZR4fWcpJ+H9vwCOXbQjD0M9LZHiQiCfk7
        tkxXgukA5hR4/0ev8m4yQqJNm+YkBEUWeb9VpWiNkkkWdSMYtzl0EHwdxxx6UKc7p58e6P7HOJViY
        CCH6iSmQ==;
Received: from [201.144.174.25] (port=23782 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1xux-001DLa-VL; Wed, 12 Feb 2020 13:43:28 -0600
Date:   Wed, 12 Feb 2020 13:46:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rsxx: Replace zero-length array with flexible-array member
Message-ID: <20200212194602.GA31712@embeddedor>
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
X-Exim-ID: 1j1xux-001DLa-VL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.25]:23782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
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
 drivers/block/rsxx/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index 111eb659e66d..1914f5488b22 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -80,7 +80,7 @@ struct dma_tracker {
 struct dma_tracker_list {
 	spinlock_t		lock;
 	int			head;
-	struct dma_tracker	list[0];
+	struct dma_tracker	list[];
 };
 
 
-- 
2.25.0

