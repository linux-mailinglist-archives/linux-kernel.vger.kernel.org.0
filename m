Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885BC17C58D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCFSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 13:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgCFSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9FA2067C;
        Fri,  6 Mar 2020 18:40:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jAHu0-002e04-Lw; Fri, 06 Mar 2020 13:40:52 -0500
Message-Id: <20200306184052.521292991@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 13:40:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 5/8] locallock: Include header for the `current macro
References: <20200306184035.948924528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.106-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit e693075a5fd852043fa8d2b0467e078d9e5cb782 ]

Include the header for `current' macro so that
CONFIG_KERNEL_HEADER_TEST=y passes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/locallock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34..81c89d87723b 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -3,6 +3,7 @@
 
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 #ifdef CONFIG_PREEMPT_RT_BASE
 
-- 
2.25.0


