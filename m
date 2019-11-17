Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81CEFFBD8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKQWNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfKQWNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B07B206E1;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn8-0002pO-5x; Sun, 17 Nov 2019 17:13:10 -0500
Message-Id: <20191117221256.228674565@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:12:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Some more updates for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 128161f47bc3797b0d068da13e311770685d6e4f


Artem Bityutskiy (1):
      tracing: Increase SYNTH_FIELDS_MAX for synthetic_events

Colin Ian King (1):
      ftrace/selftests: Fix spelling mistake "wakeing" -> "waking"

Steven Rostedt (VMware) (5):
      ftrace: Add modify_ftrace_direct()
      ftrace/samples: Add a sample module that implements modify_ftrace_direct()
      ftrace: Fix accounting bug with direct->count in register_ftrace_direct()
      ftrace: Add another check for match in register_ftrace_direct()
      ftrace: Add helper find_direct_entry() to consolidate code

----
 include/linux/ftrace.h                             |   6 ++
 kernel/trace/ftrace.c                              | 119 +++++++++++++++++----
 kernel/trace/trace_events_hist.c                   |   2 +-
 samples/ftrace/Makefile                            |   1 +
 samples/ftrace/ftrace-direct-modify.c              |  88 +++++++++++++++
 samples/ftrace/ftrace-direct.c                     |   2 +-
 .../ftrace/test.d/direct/ftrace-direct.tc          |   2 +-
 .../ftrace/test.d/direct/kprobe-direct.tc          |   4 +-
 8 files changed, 200 insertions(+), 24 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-modify.c
