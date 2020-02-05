Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD6153ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBEWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgBEWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:21:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E282D2072B;
        Wed,  5 Feb 2020 22:21:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izT3G-001Ozb-PO; Wed, 05 Feb 2020 17:21:42 -0500
Message-Id: <20200205222110.912457436@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 17:21:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Really, this is the last update for 5.6 before my pull request!
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (4):
      bootconfig: Use bootconfig instead of boot config
      bootconfig: Add more parse error messages
      tools/bootconfig: Show the number of bootconfig nodes
      bootconfig: Show the number of nodes on boot message

Steven Rostedt (VMware) (1):
      ftrace: Protect ftrace_graph_hash with ftrace_sync

----
 init/main.c             | 10 ++++++----
 kernel/trace/ftrace.c   | 11 +++++++++--
 kernel/trace/trace.h    |  2 ++
 lib/bootconfig.c        | 21 ++++++++++++++++-----
 tools/bootconfig/main.c |  1 +
 5 files changed, 34 insertions(+), 11 deletions(-)
