Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA7A8154
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDLpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDLpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:45:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1263F20820;
        Wed,  4 Sep 2019 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597553;
        bh=l8d1aa7jQJ/+VWO5N87LIpHbBJvkf1x8vkxmsAaaPmw=;
        h=From:To:Cc:Subject:Date:From;
        b=RFtNBZbRmcEoaVoPNrGJW0/6TiJdHVXY7qaUXkrvTVCtEuxjgH9/5O28TJaV4fSxT
         laVSLarKnl7bRJ+WnLYsvIC/yZHTXmb54ccLzTD6jwTLq0beVHLnaNN7M+rMh2z0os
         eryfvmNkA9h5RntyMUq3ogjeQQEn98EF+J/K7iWg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip 0/2] x86: Prohibit kprobes on XEN_EMULATE_PREFIX
Date:   Wed,  4 Sep 2019 20:45:47 +0900
Message-Id: <156759754770.24473.11832897710080799131.stgit@devnote2>
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

These patches allow x86 instruction decoder to decode
xen-cpuid which has XEN_EMULATE_PREFIX, and prohibit
kprobes to probe on it.

Josh reported that the objtool can not decode such special
prefixed instructions, and I found that we also have to
prohibit kprobes to probe on such instruction.

This series can be applied on -tip master branch which
has merged Josh's objtool/perf sharing common x86 insn
decoder series.


Thank you,

---

Masami Hiramatsu (2):
      x86: xen: insn: Decode XEN_EMULATE_PREFIX correctly
      x86: kprobes: Prohibit probing on instruction which has Xen prefix


 arch/x86/include/asm/insn.h             |    2 +
 arch/x86/include/asm/xen/interface.h    |    7 ++++-
 arch/x86/include/asm/xen/prefix.h       |   10 +++++++
 arch/x86/kernel/kprobes/core.c          |    4 +++
 arch/x86/lib/insn.c                     |   43 +++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h       |    2 +
 tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++
 tools/arch/x86/lib/insn.c               |   43 +++++++++++++++++++++++++++++++
 tools/objtool/sync-check.sh             |    3 +-
 9 files changed, 121 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/prefix.h
 create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
