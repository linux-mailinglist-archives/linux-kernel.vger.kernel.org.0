Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758A718C2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 23:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCSWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 18:25:37 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.72]:26293 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:25:37 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 903CB67812
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:25:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F3bbjkhjwAGTXF3bbjAdrs; Thu, 19 Mar 2020 17:25:35 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TL6TVrB3e/45SD3ES0SlXrCS9Eof0rSqhEbtuxxX0x8=; b=alNFm6x1iNM37ziy9M+QKtKG7v
        uLOAGBZq2cjGF2t9Bq0aV0HHx5vOnX/eamgh1v+JKST0U+F6zxQAYEt0S/p6uVtCt7rFPmuGT0guC
        5zGYp/EaHyrT1FcNCRDgGs2geqaMmJIoG4Yqa6s1I2LZ+ZN0EuxPIxj7meKVKdnkVrFtV36VU7nqW
        JzDqaju2felTxZPBWkZntMVDOaFoxTPUijloYULUTi6+1T16stQ3+YOFyNx5LK+fqsywCkwrQ/35U
        ICQwfGd3V36Qs9eFOyMMdmhz8oTqtj6+6fo9m4xXpo9woCOtco4JjyI1m8pfVab1TFbzqaMKyqdJ4
        1vzluDzg==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53902 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF3ba-002549-1L; Thu, 19 Mar 2020 17:25:34 -0500
Date:   Thu, 19 Mar 2020 17:25:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] message: fusion: mptsas.h: Replace zero-length array
 with flexible-array member
Message-ID: <20200319222533.GA20577@embeddedor.com>
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
X-Exim-ID: 1jF3ba-002549-1L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53902
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
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
 drivers/message/fusion/mptsas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptsas.h b/drivers/message/fusion/mptsas.h
index c396483d3624..e35b13891fe4 100644
--- a/drivers/message/fusion/mptsas.h
+++ b/drivers/message/fusion/mptsas.h
@@ -110,7 +110,7 @@ struct fw_event_work {
 	MPT_ADAPTER	*ioc;
 	u32			event;
 	u8			retries;
-	char			event_data[0] __aligned(4);
+	char			event_data[] __aligned(4);
 };
 
 struct mptsas_discovery_event {
-- 
2.23.0

