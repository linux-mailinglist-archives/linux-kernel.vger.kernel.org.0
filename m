Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EC18DBA0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 00:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCTXQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 19:16:37 -0400
Received: from gateway23.websitewelcome.com ([192.185.47.80]:37177 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCTXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:16:37 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 3A3C74B97
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 18:16:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FQsWjhDGLSl8qFQsWjFcS6; Fri, 20 Mar 2020 18:16:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1K4LBzbZwE60crSlkXO26EuXUhUjFLheBgPzwYswvKI=; b=tffwMHZffsoQ5eHpwux0zLbaNO
        XM36B5hEJPEcYRrQZfGyghQkKt44oPEeQU9MAKd5muA3VDQbl3zeks8RYstt4872lSiwgncSAWSst
        No0+VXUag3JAMJY7Vqff8F3xvcVSlhTBqZIbvx+CXFkma3dhXtlgCDVW2LM7J7XfKogH6sWOeTExv
        tOhcDC7ZBmuBIGEJocXL8psPPi5SVk2faW6MC0o99BbZGidTigeqYigT45CkR2AaOJZ9KhwQrtMRt
        Nk2pwZewsz3UeOEpfw/gOlwCRIN6jk9x4AbgN+idtdYgAFKMN1QaTKHgWjK1z+UsMugGPguwX1FR1
        IgMqx/2A==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53576 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jFQsU-001IZU-Pw; Fri, 20 Mar 2020 18:16:34 -0500
Date:   Fri, 20 Mar 2020 18:16:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] chrome: wilco_ec: event: Replace zero-length array
 with flexible-array member
Message-ID: <20200320231634.GA20040@embeddedor.com>
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
X-Exim-ID: 1jFQsU-001IZU-Pw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53576
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
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
 drivers/platform/chrome/wilco_ec/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index dba3d445623f..814518509739 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -79,7 +79,7 @@ static DEFINE_IDA(event_ida);
 struct ec_event {
 	u16 size;
 	u16 type;
-	u16 event[0];
+	u16 event[];
 } __packed;
 
 #define ec_event_num_words(ev) (ev->size - 1)
@@ -96,7 +96,7 @@ struct ec_event_queue {
 	int capacity;
 	int head;
 	int tail;
-	struct ec_event *entries[0];
+	struct ec_event *entries[];
 };
 
 /* Maximum number of events to store in ec_event_queue */
-- 
2.23.0

