Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5BAB052
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfIFBpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 21:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfIFBpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:45:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1421206A3;
        Fri,  6 Sep 2019 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567734343;
        bh=lRua2zvyLgvotqYOjbb+UVo5g3Ivo1xIo+HFgNhUcSE=;
        h=From:To:Cc:Subject:Date:From;
        b=nuJ5FzVqwGlmsc0Kk6PpuDOwlyGC6hh8MzyANH4Hjc+FHgxfSUacEv/FHImp5F5Vb
         wsR61Snl9pj8CBVU1Yf5Zt3td7q4UfwAUo+xgnI+ErDgCmc63AkfW03GZxMmnvo5aV
         W7ApSsrbMamTzz5FsSjQzkkFNssKP1adkV1CbzjI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip v3 0/2] x86: kprobes: Prohibit kprobes on Xen/KVM emulate prefixes
Date:   Fri,  6 Sep 2019 10:45:38 +0900
Message-Id: <156773433821.31441.2905951246664148487.stgit@devnote2>
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

Here is the 3rd version of patches to handle Xen/KVM emulate
prefix by x86 instruction decoder.

These patches allow x86 instruction decoder to decode
Xen and KVM emulate prefix correctly, and prohibit kprobes to
probe on it.

Josh reported that the objtool can not decode such special
prefixed instructions, and I found that we also have to
prohibit kprobes to probe on such instruction.

This series can be applied on -tip master branch which
has merged Josh's objtool/perf sharing common x86 insn
decoder series.

In the 2nd version, I added KVM emulate prefix support and generalized
the interface. (insn_has_xen_prefix -> insn_has_emulate_prefix)
Also, I added insn.emulate_prefix_size for those prefixes because
that prefix is NOT an x86 instruction prefix, and the next instruction
of those emulate prefixes can have x86 instruction prefix. So we
can not use insn.prefix for it.

In this 3rd version, I just fixed tools/perf/check-headers.sh so
that it can ignore the difference of xen/prefix header path.

Thank you,

---

Masami Hiramatsu (2):
      x86: xen: insn: Decode Xen and KVM emulate-prefix signature
      x86: kprobes: Prohibit probing on instruction which has emulate prefix


 arch/x86/include/asm/insn.h             |    6 +++++
 arch/x86/include/asm/xen/interface.h    |    7 ++++--
 arch/x86/include/asm/xen/prefix.h       |   10 +++++++++
 arch/x86/kernel/kprobes/core.c          |    4 +++
 arch/x86/lib/insn.c                     |   36 +++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h       |    6 +++++
 tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++++
 tools/arch/x86/lib/insn.c               |   36 +++++++++++++++++++++++++++++++
 tools/objtool/sync-check.sh             |    3 ++-
 tools/perf/check-headers.sh             |    2 +-
 10 files changed, 116 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/prefix.h
 create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
