Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6455B5FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfIRIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfIRIzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:55:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B348F21897;
        Wed, 18 Sep 2019 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568796931;
        bh=Pmbxecf205bi2xT3Yqku7BvFlsQFvcN+McusEHpiYzc=;
        h=From:To:Cc:Subject:Date:From;
        b=fT+XyFmTMkFVykkJIXe89x9MLCzbdKolIuNYlW2GG0rVqcUSoVpLiWSQFo7Rurc3q
         O3jzNSLaYwCr76UffyDo729ZvuV8G2dBWKAYx+D1RgG5L0iOHjhskYwpkrFd0vPh1e
         MBwzovKUeD5+iCtCaM/yPos9yK/7tBjJ9oaYhD48=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com
Subject: [PATCH 0/3] tracing/probe: Fix some issues on multiprobe support
Date:   Wed, 18 Sep 2019 17:55:28 +0900
Message-Id: <156879692790.31056.9404391078827158266.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here are the patches to fix some issues on multiprobe support
(and add a testcase for the fix)

 [1/3] Fix to allow user to enable probe events on unloaded modules.
       This was supported before multiprobe support. Fix it.

 [2/3] Reject exactly same probe event. Multiprobe accepts the exact
       same probe as existing one, but it is meansingless and confusing.
       Reject the probe events which has exact same probe point and same
       arguments.

 [3/3] Add a testcase for [2/3].

Thank you,

---

Masami Hiramatsu (3):
      tracing/probe: Fix to allow user to enable events on unloaded modules
      tracing/probe: Reject exactly same probe event
      selftests/ftrace: Update kprobe event error testcase


 kernel/trace/trace_kprobe.c                        |   69 ++++++++++++++------
 kernel/trace/trace_probe.h                         |    3 +
 kernel/trace/trace_uprobe.c                        |   52 +++++++++++++--
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 
 4 files changed, 96 insertions(+), 29 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>
