Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753EC128BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLUVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 16:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfLUVLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 16:11:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C502067C;
        Sat, 21 Dec 2019 21:11:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iim29-000o0t-01; Sat, 21 Dec 2019 16:11:33 -0500
Message-Id: <20191221211106.338673631@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 21 Dec 2019 16:11:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Some fixes for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keita Suzuki (1):
      tracing: Avoid memory leak in process_system_preds()

Prateek Sood (1):
      tracing: Fix lock inversion in trace_event_enable_tgid_record()

Steven Rostedt (VMware) (1):
      tracing: Have the histogram compare functions convert to u64 first

Sven Schnelle (2):
      samples/trace_printk: Wait for IRQ work to finish
      tracing: Fix endianness bug in histogram trigger

----
 kernel/trace/trace.c                |  8 ++++++++
 kernel/trace/trace_events.c         |  8 ++++----
 kernel/trace/trace_events_filter.c  |  2 +-
 kernel/trace/trace_events_hist.c    | 21 ++++++++++++++++++++-
 kernel/trace/tracing_map.c          |  4 ++--
 samples/trace_printk/trace-printk.c |  1 +
 6 files changed, 36 insertions(+), 8 deletions(-)
