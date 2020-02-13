Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDA15B5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 01:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgBMAct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 19:32:49 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.196]:43739 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbgBMAcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:32:48 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id B497711EE3C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 18:32:47 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22Qxj0WsT8vkB22QxjySOs; Wed, 12 Feb 2020 18:32:47 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7jdsYH/671Xyu2fHGtlm4uwJ6l3oKA/XvfA+LmaM2x4=; b=ePaXmgnJLDY+t61/xA/9Qt1D03
        11zu8sn9txEoLZclcQuRim21SH1lvcUr1ri0ZUTF4Hq0Shybls9pEmTb9ysZK/QeV/3aOatcs+vdk
        1A6l/Tu9D+hDopqiAmDkjCqswZX5ulSng3nMGQDg2rVV0Ud5wYsHx224lrftG+q9RLEVMWNiG7wWX
        6WHlBC0c19cFkAh8I+ozPjhUTeOqqmInvINESRKwxaS4KFKGJ8FUVd1PU/yn57ftVkb95mZlsp0EC
        d5TOSODQnXKd+vBp38GkaVfBYYd/HKQh4pODGOs+TU67vnRu0uLmcWsrUU5GR3CzOZAMQtferBLiW
        dQwn6T+g==;
Received: from [200.68.141.42] (port=13439 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22Qv-003dOK-QU; Wed, 12 Feb 2020 18:32:46 -0600
Date:   Wed, 12 Feb 2020 18:32:43 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lightnvm: Replace zero-length array with flexible-array
 member
Message-ID: <20200213003243.GA1253@embeddedor.com>
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
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22Qv-003dOK-QU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:13439
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
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ec46693f6b64..3002bf972c6b 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -171,7 +171,7 @@ struct nvme_nvm_bb_tbl {
 	__le32	tdresv;
 	__le32	thresv;
 	__le32	rsvd2[8];
-	__u8	blk[0];
+	__u8	blk[];
 };
 
 struct nvme_nvm_id20_addrf {
-- 
2.23.0

