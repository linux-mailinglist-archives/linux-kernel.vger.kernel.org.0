Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01082225D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfERIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 04:51:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:51:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8pAKa1732371
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:51:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8pAKa1732371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169471;
        bh=Nq6LqO1MNEwwcI90/cveX6gdF/RX80mWpOL6K8VOhPw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Q+5hS98RcCmVvvnXVwgqnuzVEQHsPN08i3BBI2lm57T0zixRRJLGypSQoe232D3YG
         fp48bzTefgt58jU2RrokMJeffodmH7UpN6UwGn/soRHd8YyBrR0yRDCvi202ihwD0Z
         zmYOu/AyaCCW0zhFpYC6WBg9czIIdQNQ3NMGScqnzvM6RNzGN/NiVUEx6LQJYxdnUz
         g52X/YZlbWBdQUfQs7Rky+m5Zfda2swdZ9oCTUUwAUchtRQjuAmWib60CXjUIlAYfC
         ba3VM3WBdHuTbjNdrZ7KwxbK0BZWCpj4e1OzE21vIzweh/TCVFn7S1QlN9UBMvD1zr
         2j5v9QlCMy6Kg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8pAPJ1732365;
        Sat, 18 May 2019 01:51:10 -0700
Date:   Sat, 18 May 2019 01:51:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6pjnnrzqt3x3n2cd6br3wk7k@git.kernel.org>
Cc:     peterz@infradead.org, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        kan.liang@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        hpa@zytor.com
Reply-To: kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, peterz@infradead.org,
          adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools x86 uapi asm: Sync the pt_regs.h copy with
 the kernel sources
Git-Commit-ID: 0ceb5499a8001e5ddac2c8bd7b45eb4c643469ad
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0ceb5499a8001e5ddac2c8bd7b45eb4c643469ad
Gitweb:     https://git.kernel.org/tip/0ceb5499a8001e5ddac2c8bd7b45eb4c643469ad
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 13:35:38 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

tools x86 uapi asm: Sync the pt_regs.h copy with the kernel sources

To get the changes in:

  878068ea270e ("perf/x86: Support outputting XMM registers")

That will be used in a followup patch to allow users to ask for some or
all of those registers to be collected in certain contatexts.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/x86/include/uapi/asm/perf_regs.h'
  diff -u tools/arch/x86/include/uapi/asm/perf_regs.h arch/x86/include/uapi/asm/perf_regs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-6pjnnrzqt3x3n2cd6br3wk7k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..ac67bbea10ca 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,8 +27,29 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
-
+	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+
+	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_XMM0  = 32,
+	PERF_REG_X86_XMM1  = 34,
+	PERF_REG_X86_XMM2  = 36,
+	PERF_REG_X86_XMM3  = 38,
+	PERF_REG_X86_XMM4  = 40,
+	PERF_REG_X86_XMM5  = 42,
+	PERF_REG_X86_XMM6  = 44,
+	PERF_REG_X86_XMM7  = 46,
+	PERF_REG_X86_XMM8  = 48,
+	PERF_REG_X86_XMM9  = 50,
+	PERF_REG_X86_XMM10 = 52,
+	PERF_REG_X86_XMM11 = 54,
+	PERF_REG_X86_XMM12 = 56,
+	PERF_REG_X86_XMM13 = 58,
+	PERF_REG_X86_XMM14 = 60,
+	PERF_REG_X86_XMM15 = 62,
+
+	/* These include both GPRs and XMMX registers */
+	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
 #endif /* _ASM_X86_PERF_REGS_H */
