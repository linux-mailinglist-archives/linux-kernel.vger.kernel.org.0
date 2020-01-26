Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A704149C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAZTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 14:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4690206F0;
        Sun, 26 Jan 2020 19:20:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSG-000zpZ-FM; Sun, 26 Jan 2020 14:20:20 -0500
Message-Id: <20200126191932.984391723@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Some very old (and some new) patches for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Carpenter (1):
      tracing: Remove unneeded NULL check

Hou Pengyang (1):
      tracing: Fix comments about trace/ftrace.h

Josef Bacik (1):
      tracing: Set kernel_stack's caller size properly

Luis Henriques (1):
      tracing: Fix tracing_stat return values in error handling paths

Steven Rostedt (VMware) (3):
      tracing: Fix very unlikely race of registering two stat tracers
      tracing: Decrement trace_array when bootconfig creates an instance
      tracing: Use pr_err() instead of WARN() for memory failures

----
 include/trace/trace_events.h |  9 ++++++---
 kernel/trace/ftrace.c        |  4 ++--
 kernel/trace/trace.c         | 24 ++++++++++++++----------
 kernel/trace/trace.h         | 12 ++++++++++++
 kernel/trace/trace_boot.c    |  1 +
 kernel/trace/trace_entries.h |  2 +-
 kernel/trace/trace_stat.c    | 31 +++++++++++++++++--------------
 7 files changed, 53 insertions(+), 30 deletions(-)
