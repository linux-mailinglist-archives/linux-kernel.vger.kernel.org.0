Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1DCE56D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJYXCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 19:02:11 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:39621 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfJYXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:02:11 -0400
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1iO8av-000Liw-FG; Fri, 25 Oct 2019 19:02:09 -0400
Subject: [PATCH] Kconfig: Fix spelling mistake in user-visible help text
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, akaher@vmware.com,
        bordoloih@vmware.com, srivatsa@csail.mit.edu, srivatsab@vmware.com
Date:   Fri, 25 Oct 2019 16:02:07 -0700
Message-ID: <157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Fix a spelling mistake in the help text for PREEMPT_RT.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---

 kernel/Kconfig.preempt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index deff972..bf82259 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -65,7 +65,7 @@ config PREEMPT_RT
 	  preemptible priority-inheritance aware variants, enforcing
 	  interrupt threading and introducing mechanisms to break up long
 	  non-preemptible sections. This makes the kernel, except for very
-	  low level and critical code pathes (entry code, scheduler, low
+	  low level and critical code paths (entry code, scheduler, low
 	  level interrupt handling) fully preemptible and brings most
 	  execution contexts under scheduler control.
 

