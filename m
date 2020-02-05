Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07081152970
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 11:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgBEKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 05:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgBEKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:51:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0B02085B;
        Wed,  5 Feb 2020 10:51:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izIH2-001NrU-R3; Wed, 05 Feb 2020 05:51:12 -0500
Message-Id: <20200205104929.313040579@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 05:49:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Hopefully last update for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Amol Grover (2):
      tracing: Annotate ftrace_graph_hash pointer with __rcu
      tracing: Annotate ftrace_graph_notrace_hash pointer with __rcu

Steven Rostedt (VMware) (2):
      bootconfig: Only load bootconfig if "bootconfig" is on the kernel cmdline
      ftrace: Add comment to why rcu_dereference_sched() is open coded

----
 Documentation/admin-guide/bootconfig.rst        |  2 ++
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 init/main.c                                     | 28 ++++++++++++++++++-------
 kernel/trace/ftrace.c                           |  4 ++--
 kernel/trace/trace.h                            | 27 +++++++++++++++++++-----
 5 files changed, 53 insertions(+), 14 deletions(-)
