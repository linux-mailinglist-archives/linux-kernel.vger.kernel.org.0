Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE4FCD14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKNSSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfKNSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB43020878;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00019j-Vw; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181826.870366590@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 24/33] tracing/selftests: Turn off timeout setting
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the ftrace selftests can run for a long period of time, disable the
timeout that the general selftests have. If a selftest hangs, then it
probably means the machine will hang too.

Link: https://lore.kernel.org/r/alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Tested-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/ftrace/settings

diff --git a/tools/testing/selftests/ftrace/settings b/tools/testing/selftests/ftrace/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.23.0


