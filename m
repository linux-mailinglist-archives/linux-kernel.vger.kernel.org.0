Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81319159AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgBKUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 15:48:47 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.155]:25623 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgBKUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:48:47 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 57018400CECDB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:48:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cScjIXlfXVkQ1cScjgsOz; Tue, 11 Feb 2020 14:48:46 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pk3jucKkgGeEV6Au0nX+Ttm5YWNvtM3diEI6bWayXng=; b=XdB3q/5U5BVjk2oUsJ6okatoQC
        9TUfMCOqfTfbAFjokj2rm0Zih46zq7fY4ULZ4UwK7eCaiC6RH/PtJsnEyX1b4bQUy5H2o/Nt0G3SQ
        dDEwXHQ1/pQiaS7JelKtB/UwUkMSVtBU3Q3NeUysyCzXWjCHJYbuKrS0NDV/2KsGW2tmgCX2h6yGh
        c0gJPzRJ+PmPcxUlM+Vnnq6stDFa1mYPp3CX7rWcdBC6pi0WFbGezMG5OnBbpJfYA1bdHl7Nd0NgA
        fxJHzcPDQtpP7SOqshKFamK7SLzJthk7u56uAqXGf99LV4CfTlnwNmp2mACt51kkozPQzBPJ4hCAG
        A7i7A+ug==;
Received: from [200.68.140.36] (port=6499 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cSa-001vSf-P0; Tue, 11 Feb 2020 14:48:44 -0600
Date:   Tue, 11 Feb 2020 14:51:19 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib/bch: Replace zero-length array with flexible-array member
Message-ID: <20200211205119.GA21234@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1cSa-001vSf-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:6499
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/bch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bch.c b/lib/bch.c
index 5db6d3a4c8a6..052d3fb753a0 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -102,7 +102,7 @@
  */
 struct gf_poly {
 	unsigned int deg;    /* polynomial degree */
-	unsigned int c[0];   /* polynomial terms */
+	unsigned int c[];   /* polynomial terms */
 };
 
 /* given its degree, compute a polynomial size in bytes */
-- 
2.25.0

