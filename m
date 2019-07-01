Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5D1652F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEGNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 09:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEGNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EF3205C9;
        Tue,  7 May 2019 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557237336;
        bh=vDzTqlXITUzg3T8pnIDpoEHrO2yG9pk+pTAcWYM3+PE=;
        h=From:To:Cc:Subject:Date:From;
        b=aGlY/D2ES1sUi4/uuCnYQvFI3EzqEWySUE1xbryQMnVnXXAxkESE+iRnPSCXvp2/J
         yTE1V6CpDo6kmn50a4C7jeAxwHnFfk8sRt0c1mLHY0RQoaurYLWW7RxvFIVVOBsydx
         ALVEO9SFqxDkMcDwDMO4x2/MTWW3G899ZeGkP0NE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing: probeevent: Fix probe argument parser and handler
Date:   Tue,  7 May 2019 22:55:22 +0900
Message-Id: <155723732200.9149.10482668315693777743.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 3rd version of series to fix several bugs in probe event
argument parser and handler routines.

In this version I updated patch [1/3] according to Steve's comment.


I got 2 issues reported by Andreas, see
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html

One issue is already fixed by Andreas (Thanks!) but $comm handling
issue still exists on uprobe event. [1/3] fixes it.
And I found other issues around that, [2/3] is just a trivial cleanup,
[3/3] fixes $comm type issue which occurs not only uprobe events but
also on kprobe events. Anyway, after this series applied, $comm must
be "string" type and not be an array.

Thank you,

---

Masami Hiramatsu (3):
      tracing: uprobes: Re-enable $comm support for uprobe events
      tracing: probeevent: Do not accumulate on ret variable
      tracing: probeevent: Fix to make the type of $comm string


 kernel/trace/trace_probe.c      |   13 +++++++------
 kernel/trace/trace_probe.h      |    1 +
 kernel/trace/trace_probe_tmpl.h |    2 +-
 kernel/trace/trace_uprobe.c     |   13 +++++++++++--
 4 files changed, 20 insertions(+), 9 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>
