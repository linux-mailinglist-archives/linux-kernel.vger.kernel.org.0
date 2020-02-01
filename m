Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B732C14F953
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 19:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBASMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 13:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgBASMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:12:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D3E206E6;
        Sat,  1 Feb 2020 18:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixxFw-001Ikc-P6; Sat, 01 Feb 2020 13:12:32 -0500
Message-Id: <20200201181210.203806308@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 01 Feb 2020 13:12:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Some last minute fixes for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi (6):
      tracing: Change trace_boot to use synth_event interface
      tracing: Fix now invalid var_ref_vals assumption in trace action
      tracing: Consolidate some synth_event_trace code
      tracing: Remove check_arg() callbacks from dynevent args
      tracing: Remove useless code in dynevent_arg_pair_add()
      tracing: Use seq_buf for building dynevent_cmd string

----
 include/linux/trace_events.h     |   4 +-
 kernel/trace/trace_boot.c        |  31 +++---
 kernel/trace/trace_dynevent.c    | 110 ++++++++-----------
 kernel/trace/trace_dynevent.h    |  11 +-
 kernel/trace/trace_events_hist.c | 221 +++++++++++++++++++--------------------
 kernel/trace/trace_kprobe.c      |  12 +--
 6 files changed, 171 insertions(+), 218 deletions(-)
