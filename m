Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC7E5F50
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJZTqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 15:46:15 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:60078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbfJZTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:46:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DA1B3181D341E;
        Sat, 26 Oct 2019 19:46:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3867:3870:3871:4321:5007:6119:7903:10004:10400:11026:11473:11658:11914:12296:12297:12555:12760:13069:13311:13357:13439:14096:14097:14181:14394:14659:14721:21080:21627:30029:30051:30054,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: game48_1929a876a3b5b
X-Filterd-Recvd-Size: 1608
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 19:46:12 +0000 (UTC)
Message-ID: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
Subject: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 26 Oct 2019 12:46:08 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization is not guaranteed to zero padding bytes so
use an explicit memset instead to avoid leaking any kernel
content in any possible padding bytes.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index a611d1..3459a5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1279,11 +1279,13 @@ SYSCALL_DEFINE1(uname, struct old_utsname __user *, name)
 
 SYSCALL_DEFINE1(olduname, struct oldold_utsname __user *, name)
 {
-	struct oldold_utsname tmp = {};
+	struct oldold_utsname tmp;
 
 	if (!name)
 		return -EFAULT;
 
+	memset(&tmp, 0, sizeof(tmp));
+
 	down_read(&uts_sem);
 	memcpy(&tmp.sysname, &utsname()->sysname, __OLD_UTS_LEN);
 	memcpy(&tmp.nodename, &utsname()->nodename, __OLD_UTS_LEN);

