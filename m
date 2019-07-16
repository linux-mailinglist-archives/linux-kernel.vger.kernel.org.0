Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E566AF78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfGPTA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 15:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfGPTA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B4720693;
        Tue, 16 Jul 2019 19:00:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hnSh6-0006Bu-Kg; Tue, 16 Jul 2019 15:00:56 -0400
Message-Id: <20190716190014.840939538@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 16 Jul 2019 15:00:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: last minute changes before pushing
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bah, I had this tested last week before going on PTO and forgot to push
it to my for-next branch. But it's for this merge window.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: f86a1152e15c6b5913f9ec03a2bd97ca70c1ed82


Cong Wang (3):
      tracing: Pass type into tracing_generic_entry_update()
      tracing: Let filter_assign_type() detect FILTER_PTR_STRING
      tracing: Make trace_get_fields() global

Steven Rostedt (VMware) (2):
      ftrace/selftests: Return the skip code when tracing directory not configured in kernel
      ftrace/selftest: Test if set_event/ftrace_pid exists before writing

----
 include/linux/trace_events.h                    |  9 ++++++
 kernel/trace/trace.c                            |  8 +++---
 kernel/trace/trace_event_perf.c                 |  3 +-
 kernel/trace/trace_events.c                     |  8 ------
 kernel/trace/trace_events_filter.c              |  3 ++
 tools/testing/selftests/ftrace/ftracetest       | 38 +++++++++++++++++++++----
 tools/testing/selftests/ftrace/test.d/functions |  4 +--
 7 files changed, 51 insertions(+), 22 deletions(-)
