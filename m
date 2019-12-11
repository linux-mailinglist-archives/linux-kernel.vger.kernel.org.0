Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7711AD98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfLKOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbfLKOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:34:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F0C20836;
        Wed, 11 Dec 2019 14:34:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1if34q-0010bL-ME; Wed, 11 Dec 2019 09:34:56 -0500
Message-Id: <20191211143422.570348522@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 09:34:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: More updates for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alexei Starovoitov (1):
      ftrace: Fix function_graph tracer interaction with BPF trampoline

Steven Rostedt (VMware) (1):
      module: Remove accidental change of module_enable_x()

YueHaibing (1):
      tracing: remove set but not used variable 'buffer'

----
 arch/x86/kernel/ftrace.c           | 14 --------------
 include/linux/ftrace.h             |  5 +++++
 kernel/module.c                    |  6 +-----
 kernel/trace/fgraph.c              |  9 +++++++++
 kernel/trace/ftrace.c              | 19 +++++++------------
 kernel/trace/trace_events_inject.c |  2 --
 6 files changed, 22 insertions(+), 33 deletions(-)
