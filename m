Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A536C195F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfI2UHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 16:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2UHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:07:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2902321835;
        Sun, 29 Sep 2019 20:07:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iEfTw-00080k-61; Sun, 29 Sep 2019 16:07:48 -0400
Message-Id: <20190929200642.036511084@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Sep 2019 16:06:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Minor fixes for the last pull request
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some final fix ups that will be sent to Linus shortly.

Changbin Du (1):
      mm, tracing: Print symbol name for call_site in trace events

Masami Hiramatsu (1):
      tracing/probe: Fix to check the difference of nr_args before adding probe

Nathan Chancellor (1):
      tracing: Fix clang -Wint-in-bool-context warnings in IF_ASSIGN macro

Navid Emamdoost (1):
      tracing: Have error path in predicate_parse() free its allocated memory

Steven Rostedt (VMware) (1):
      selftests/ftrace: Fix same probe error test

----
 include/trace/events/kmem.h                              |  7 ++++---
 kernel/trace/trace.h                                     | 10 +++++-----
 kernel/trace/trace_events_filter.c                       |  6 ++++--
 kernel/trace/trace_probe.c                               | 16 ++++++++++++++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc         |  2 +-
 5 files changed, 30 insertions(+), 11 deletions(-)
