Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB2143FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAUOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:39:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:39:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8545E2253D;
        Tue, 21 Jan 2020 14:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ituhA-000dwS-Dl; Tue, 21 Jan 2020 09:39:56 -0500
Message-Id: <20200121143847.609307852@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 21 Jan 2020 09:38:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changbin Du (1):
      tracing: xen: Ordered comparison of function pointers

Masami Hiramatsu (2):
      tracing/uprobe: Fix double perf_event linking on multiprobe uprobe
      tracing: trigger: Replace unneeded RCU-list traversals

Masami Ichikawa (1):
      tracing: Do not set trace clock if tracefs lockdown is in effect

Steven Rostedt (VMware) (1):
      tracing: Fix histogram code when expression has same var as value

----
 include/trace/events/xen.h          |   6 +-
 kernel/trace/trace.c                |   5 ++
 kernel/trace/trace_events_hist.c    |  63 ++++++++++++++----
 kernel/trace/trace_events_trigger.c |  20 ++++--
 kernel/trace/trace_kprobe.c         |   2 +-
 kernel/trace/trace_probe.c          |   5 +-
 kernel/trace/trace_probe.h          |   3 +-
 kernel/trace/trace_uprobe.c         | 124 +++++++++++++++++++++++-------------
 8 files changed, 163 insertions(+), 65 deletions(-)
