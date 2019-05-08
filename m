Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410FC180F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfEHUYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEHUYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4FD20989;
        Wed,  8 May 2019 20:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7T-0007eK-SZ; Wed, 08 May 2019 16:24:51 -0400
Message-Id: <20190508202427.252736423@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Some more last minute changes and fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: b9416997603ef7e17d4de10b6408f19da2feb72c


Anders Roxell (1):
      tracing: Allow RCU to run between postponed startup tests

Colin Ian King (1):
      tracing: Fix white space issues in parse_pred() function

Elazar Leibovich (1):
      tracing: Fix partial reading of trace event's id file

Gustavo A. R. Silva (1):
      tracing: Replace kzalloc with kcalloc

Josh Poimboeuf (1):
      x86_64: Add gap to int3 to allow for call emulation

Masami Hiramatsu (3):
      tracing: uprobes: Re-enable $comm support for uprobe events
      tracing: probeevent: Do not accumulate on ret variable
      tracing: probeevent: Fix to make the type of $comm string

Peter Zijlstra (2):
      x86_64: Allow breakpoints to emulate call instructions
      ftrace/x86_64: Emulate call function while updating in breakpoint handler

Rasmus Villemoes (1):
      tracing: Eliminate const char[] auto variables

Srivatsa S. Bhat (VMware) (1):
      tracing: Fix documentation about disabling options using trace_options

Yangtao Li (1):
      ring-buffer: Fix mispelling of Calculate

----
 arch/x86/entry/entry_64.S            | 18 ++++++++++++--
 arch/x86/include/asm/text-patching.h | 28 +++++++++++++++++++++
 arch/x86/kernel/ftrace.c             | 32 ++++++++++++++++++++----
 kernel/trace/ftrace.c                |  2 +-
 kernel/trace/ring_buffer_benchmark.c |  2 +-
 kernel/trace/trace.c                 | 40 ++++++++++++++----------------
 kernel/trace/trace_events.c          |  3 ---
 kernel/trace/trace_events_filter.c   | 48 ++++++++++++++++++------------------
 kernel/trace/trace_probe.c           | 17 +++++++------
 kernel/trace/trace_probe.h           |  1 +
 kernel/trace/trace_probe_tmpl.h      |  2 +-
 kernel/trace/trace_uprobe.c          | 13 ++++++++--
 12 files changed, 137 insertions(+), 69 deletions(-)
