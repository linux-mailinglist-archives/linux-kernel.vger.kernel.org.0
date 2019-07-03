Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D35E71E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGCOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfGCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7481A218A6;
        Wed,  3 Jul 2019 14:48:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1higYn-0005gZ-90; Wed, 03 Jul 2019 10:48:37 -0400
Message-Id: <20190703144741.181267753@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 10:47:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: A few updates to fix bugs in the latest -rc release
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will be sending out a pull request soon.

Eiichi Tsukata (1):
      tracing/snapshot: Resize spare buffer if size changed

Jiri Kosina (1):
      ftrace/x86: Anotate text_mutex split between ftrace_arch_code_modify_post_process() and ftrace_arch_code_modify_prepare()

Petr Mladek (1):
      ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()

Steven Rostedt (VMware) (1):
      ftrace/x86: Add a comment to why we take text_mutex in ftrace_arch_code_modify_prepare()

Takeshi Misawa (1):
      tracing: Fix memory leak in tracing_err_log_open()

----
 arch/x86/kernel/ftrace.c | 10 ++++++++++
 kernel/trace/ftrace.c    | 10 +---------
 kernel/trace/trace.c     | 24 +++++++++++++++++++-----
 3 files changed, 30 insertions(+), 14 deletions(-)
