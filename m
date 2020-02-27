Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219041727BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgB0SfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 13:35:00 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.196]:44933 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729280AbgB0Se7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:34:59 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id A9D7F3E5A7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:34:58 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7NzujZGuoSl8q7NzujDUn3; Thu, 27 Feb 2020 12:34:58 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bhPHK/N4A61h2syo2X1zezBye6MjYEOpxj4W5r7wBqY=; b=RddKp6yXbkYhCmwlzNx0Qcs63N
        XgKcp0ytO5RIJ8YbLV6LYBaQ989L68llzybq70zyj+kBG0Tv2IGAKL0d+0oY7nwAiu2c3Bl8XMtTC
        82FjXN4/dgGQwoFgxBI9/sXlwm3Hv0UE40tTENGqxMfGIuOaAs3yWffnVN2F7v5O+gVnJSoR95FQz
        oiVF/4tlzzMWCtoY/+kAmPVQj9h1efYbcCTRYVqGReOOCjNmI+SQ8b5u89Ge/93MZTG6JKVdt+RZJ
        9KgHCnGbMsWs1DwxG6I51EvexKUuXkam14x9YKlYPC+qtIQuBcF5vtXimZto/ICv+9gXCmIrYgOLl
        yPioBx3A==;
Received: from [201.162.168.186] (port=21630 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7Nzs-003vAP-Gq; Thu, 27 Feb 2020 12:34:56 -0600
Date:   Thu, 27 Feb 2020 12:37:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] zorro: Replace zero-length array with flexible-array member
Message-ID: <20200227183748.GA31018@embeddedor>
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
X-Source-IP: 201.162.168.186
X-Source-L: No
X-Exim-ID: 1j7Nzs-003vAP-Gq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.186]:21630
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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
 drivers/zorro/zorro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/zorro.c b/drivers/zorro/zorro.c
index 8eeb84c239db..47c733817903 100644
--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -41,7 +41,7 @@ struct zorro_dev *zorro_autocon;
 
 struct zorro_bus {
 	struct device dev;
-	struct zorro_dev devices[0];
+	struct zorro_dev devices[];
 };
 
 
-- 
2.25.0

