Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3E15B12B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 20:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgBLTcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 14:32:50 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.31]:38351 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727439AbgBLTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:32:50 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4D4572B41
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:32:49 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1xkfjcwi3Sl8q1xkfjLi9m; Wed, 12 Feb 2020 13:32:49 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BP5sguBbX0hQJxC50qnvMrrOb4NGZsy3OYZYhmQRyOg=; b=BGl7aV0/nJq8AgDBf1oDacH614
        bWQhNebXkmiFR28mZg1wmXIxySFWT+vDQHbJDhMMY6T9/gMBaSg4Q6NCI1k0kmxRcG7Jd3AmiSXOZ
        eKYOIDdWDXSvc0lxQOs0iM09rBVv7pzshzpF7TMwCtODY7FevEr8Vfad5A3g1kIl18PiUGq2g/Cir
        uZqtqUQsUqeeCVnZF3fv5whzpD7YHA39igpv4TF2JizWbJEMss9KNMkFcEgyHtbpG8UKSYw/7QyBZ
        w5ZUj+VArk+SDl0PVi45MfubOTw/CFwsQTctZBSsw90fQazz8cy+2DTUJD6VFES3fNBQHi955bTwz
        hqVusP7w==;
Received: from [201.144.174.25] (port=23494 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1xkd-0018b1-TF; Wed, 12 Feb 2020 13:32:48 -0600
Date:   Wed, 12 Feb 2020 13:35:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tty: n_gsm: Replace zero-length array with flexible-array
 member
Message-ID: <20200212193523.GA28826@embeddedor>
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
X-Exim-ID: 1j1xkd-0018b1-TF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.25]:23494
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
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
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f1c90fa2978e..5f8c30f0538e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -97,7 +97,7 @@ struct gsm_msg {
 	u8 ctrl;		/* Control byte + flags */
 	unsigned int len;	/* Length of data block (can be zero) */
 	unsigned char *data;	/* Points into buffer but not at the start */
-	unsigned char buffer[0];
+	unsigned char buffer[];
 };
 
 /*
-- 
2.25.0

