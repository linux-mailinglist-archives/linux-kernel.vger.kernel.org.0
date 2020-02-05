Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5087153B77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBEWyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:54:01 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.163]:28674 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbgBEWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:54:00 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2020 17:54:00 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 81EC6300D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Feb 2020 16:31:40 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id zTCuiyULsQfADzTCui1Nf3; Wed, 05 Feb 2020 16:31:40 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L0Nz5IqdwqEH9ceOPKFVEIdv2X6+UyVS0shI1C/vLi8=; b=BLFkwCXKaaGmoFODgQFki5r82E
        S021q2WGng0zG9zg+PCxkTUhOgv7yJxsvUO8cSV0xDNxytNqx3DPz+a7IWVPzBThzCn6/srLJco5f
        lsTxcXYpDnEnlXgDemY8uZrASbdNJ2gzw0fAcJgrO9rA0Kf3FKail5tMF1gQzkliLa2/tf02t8ZnP
        aqbt01yO51riNLXFk3x8HCRqOtFCEmNLLuMrXZYV3GRlBbN8QDpRJtnqmaHhflJ6m8y7i6US7PciX
        j8fmWaqkGJ97dLh28jakK5oiJMI64mXw/pZA28kWs4k+2wqUPRthdPDFje2XgqDs4z1mkBI1oYoA2
        IzY4QvJA==;
Received: from [201.144.174.45] (port=29810 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1izTCt-000Jo3-6R; Wed, 05 Feb 2020 16:31:39 -0600
Date:   Wed, 5 Feb 2020 16:34:04 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] tracing/kprobe: Fix uninitialized variable bug
Message-ID: <20200205223404.GA3379@embeddedor>
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
X-Source-IP: 201.144.174.45
X-Source-L: No
X-Exim-ID: 1izTCt-000Jo3-6R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.45]:29810
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable *ret* is returned
without being properly initialized, previously.

Fix this by initializing variable *ret* to 0.

Addresses-Coverity-ID: 1491142 ("Uninitialized scalar variable")
Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d8264ebb9581..362cca52f5de 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1012,7 +1012,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
 {
 	struct dynevent_arg arg;
 	va_list args;
-	int ret;
+	int ret = 0;
 
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
-- 
2.25.0

