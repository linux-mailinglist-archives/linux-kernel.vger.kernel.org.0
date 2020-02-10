Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00B157DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgBJOph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbgBJOpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D942082F;
        Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1AJb-001Vx9-4N; Mon, 10 Feb 2020 09:45:35 -0500
Message-Id: <20200210144455.531096382@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Feb 2020 09:44:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo A. R. Silva (1):
      tracing/kprobe: Fix uninitialized variable bug

Masami Hiramatsu (2):
      tools/bootconfig: Fix wrong __VA_ARGS__ usage
      bootconfig: Remove unneeded CONFIG_LIBXBC

Steven Rostedt (VMware) (1):
      bootconfig: Use parse_args() to find bootconfig and '--'

----
 init/Kconfig                            |  1 -
 init/main.c                             | 37 ++++++++++++++++++++++++++-------
 kernel/trace/trace_kprobe.c             |  2 +-
 lib/Kconfig                             |  3 ---
 lib/Makefile                            |  2 +-
 tools/bootconfig/include/linux/printk.h |  2 +-
 6 files changed, 33 insertions(+), 14 deletions(-)
