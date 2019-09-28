Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A17C1086
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfI1J7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 05:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfI1J7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:59:09 -0400
Received: from localhost.localdomain (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6E42082F;
        Sat, 28 Sep 2019 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569664748;
        bh=gyAcwJ1hJo15OrmAdgA+VqFAtaxjuEcLjPSQ6BpR1wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHwkHYcdiGJnLHrxXLJAAUq6NenSFNJ8CyLTLZSxgIfH8a0xuWswA1EW/LgWw3OIp
         ApsTSR5LFSG9hRbEQBGOyG7YAn0kBEHIgV/NExwCDGqSHg4oUhVwx68uZu4KG4Df/e
         2TdWaiwYrIjKM+iCtuGpy/DI/RjGLjvoNOsayEwE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com
Subject: [PATCH] tracing/probe: Fix to check the difference of nr_args before adding probe
Date:   Sat, 28 Sep 2019 02:59:08 -0700
Message-Id: <156966474783.3478.13217501608215769150.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
References: <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to check the difference of nr_args before adding probe
on existing probes. This also may set the error log index
bigger than the number of command parameters. In that case
it sets the error position is next to the last parameter.

Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index baf58a3612c0..905b10af5d5c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -178,6 +178,16 @@ void __trace_probe_log_err(int offset, int err_type)
 	if (!command)
 		return;
 
+	if (trace_probe_log.index >= trace_probe_log.argc) {
+		/**
+		 * Set the error position is next to the last arg + space.
+		 * Note that len includes the terminal null and the cursor
+		 * appaers at pos + 1.
+		 */
+		pos = len;
+		offset = 0;
+	}
+
 	/* And make a command string from argv array */
 	p = command;
 	for (i = 0; i < trace_probe_log.argc; i++) {
@@ -1084,6 +1094,12 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 {
 	int i;
 
+	/* In case of more arguments */
+	if (a->nr_args < b->nr_args)
+		return a->nr_args + 1;
+	if (a->nr_args > b->nr_args)
+		return b->nr_args + 1;
+
 	for (i = 0; i < a->nr_args; i++) {
 		if ((b->nr_args <= i) ||
 		    ((a->args[i].type != b->args[i].type) ||

