Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9A1941EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCZOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgCZOtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:49:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217312076A;
        Thu, 26 Mar 2020 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234171;
        bh=Ug1D44mwlx8j3F/CjHJhs2v08/ZQjLO4bJ6bUCCSm98=;
        h=From:To:Cc:Subject:Date:From;
        b=YTXzjOdR9HmKH5G1vrzE5EcgwMp/HKuIKt6wYEB6z0UUl1D+lhxGIWGQRGDAs/axP
         Rxt2gR1ShmIfcdE0QvRt6sgE0X3r7+R3Enh5GnU+eNOg32iECPZchmWnUr5EGiDTSK
         rgVmJzYvQ3PxTRv3mmQggxMKFmq4liEAJizqtORc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH -tip 0/4] kprobes: Support __kprobes and NOKPROBE_SYMBOL in modules
Date:   Thu, 26 Mar 2020 23:49:23 +0900
Message-Id: <158523416289.24735.10455512519475919061.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series for adding support of __kprobes attribute
and NOKPROBE_SYMBOL() macro in modules. With this series,
kprobes user can add its handlers and sub-functions to kprobe
blacklist so that other kprobes don't probe it.

Note that user should not use both __kprobes and NOKPROBE_SYMBOL()
to same function. In that case, the function will appear twice
on the blacklist, and that is a waste of memory.

Thomas, it is easy to add ".noinstr.text" support to this series.
as same as __kprobes (.kprobes.text) support in [2/4], we can
add mod->noinstr_text_start and mod->noinstr_text_size and
register it in add_module_kprobe_blacklist().


Thank you,

---

Masami Hiramatsu (4):
      kprobes: Lock kprobe_mutex while showing kprobe_blacklist
      kprobes: Support __kprobes blacklist in modules
      kprobes: Support NOKPROBE_SYMBOL() in modules
      samples/kprobes: Add __kprobes and NOKPROBE_SYMBOL() for handlers.


 include/linux/module.h              |    6 +++
 kernel/kprobes.c                    |   67 ++++++++++++++++++++++++++++++++++-
 kernel/module.c                     |    7 ++++
 samples/kprobes/kprobe_example.c    |    6 ++-
 samples/kprobes/kretprobe_example.c |    2 +
 5 files changed, 85 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
