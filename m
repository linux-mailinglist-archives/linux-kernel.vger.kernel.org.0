Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EFDA4426
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfHaKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 06:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfHaKyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:54:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B866722D37;
        Sat, 31 Aug 2019 10:54:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i411F-0001IX-OD; Sat, 31 Aug 2019 06:54:09 -0400
Message-Id: <20190831105329.122820332@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 31 Aug 2019 06:53:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Updates for 5.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various fixes for tracing.


Denis Efremov (1):
      tracing: Make exported ftrace_set_clr_event non-static

Jakub Kicinski (1):
      tracing: Correct kdoc formats

Jisheng Zhang (1):
      ftrace/x86: Remove mcount() declaration

Naveen N. Rao (2):
      ftrace: Fix NULL pointer dereference in t_probe_next()
      ftrace: Check for successful allocation of hash

Steven Rostedt (VMware) (1):
      ftrace: Check for empty hash and comment the race with registering probes

Xinpeng Liu (1):
      tracing/probe: Fix null pointer dereference

----
 arch/x86/include/asm/ftrace.h |  1 -
 include/linux/trace_events.h  |  1 +
 kernel/trace/ftrace.c         | 17 +++++++++++++++++
 kernel/trace/trace.c          | 26 ++++++++++++++------------
 kernel/trace/trace_events.c   |  2 +-
 kernel/trace/trace_probe.c    |  3 ++-
 6 files changed, 35 insertions(+), 15 deletions(-)
