Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2292814C828
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2Jgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 04:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:36:39 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DB02070E;
        Wed, 29 Jan 2020 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580290598;
        bh=FovxmkSLoGYjwUy09v29L1DQY/bqCUG4JbwqxUa8464=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zR777BlcnntCXVAWuaWcXn4kv1P3mwCuSrBmPhayY0wk3b9KvsUC6Ggt6udIqmV7i
         lGL0t27SK50tob50qBUQ7wwCxieIre8Ohk6AxGIjD158GrkVOxyklTAncZ6jMZm2/3
         GaW0/YHnUUhs/8eZttFByZUvTQNSoAeA+HWN7+ys=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/boot: Include required headers and sort it alphabetically
Date:   Wed, 29 Jan 2020 18:36:35 +0900
Message-Id: <158029059514.12381.6597832266860248781.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158029058421.12381.6615257646562417558.stgit@devnote2>
References: <158029058421.12381.6615257646562417558.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include some required (but currently indirectly included)
headers and sort it alphabetically.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2f616cd926b0..5aad41961f03 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -6,9 +6,16 @@
 
 #define pr_fmt(fmt)	"trace_boot: " fmt
 
+#include <linux/bootconfig.h>
+#include <linux/cpumask.h>
 #include <linux/ftrace.h>
 #include <linux/init.h>
-#include <linux/bootconfig.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/trace.h>
+#include <linux/trace_events.h>
 
 #include "trace.h"
 

