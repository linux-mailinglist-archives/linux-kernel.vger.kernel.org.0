Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72BEAAFED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 02:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfIFAu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 20:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390787AbfIFAuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:50:25 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99009207E0;
        Fri,  6 Sep 2019 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567731024;
        bh=+Nnz0FIHQJ3jHYwiPpXCPIDVXG7NsASc8gVWuOyip0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsuXaaqGyaOfDGQ7DyKPVO1u6gl1Yd+AH8J/Sa9mAthkCyT1oiMDaKAt1ycfwvcNS
         AodFvZKMyOLo4Xw1WRvjL+fHn4N8sYado5rBcUSR3LW6LJAlO3rDmt+9kfiNbqEsvM
         yss5dQEs77VIhrrrRqt1aWZU+aPjool/Ok5y60EA=
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
Subject: [PATCH -tip v2 1/2] x86: xen: insn: Decode Xen and KVM emulate-prefix signature
Date:   Fri,  6 Sep 2019 09:50:19 +0900
Message-Id: <156773101914.29031.4027232648773934988.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156773100816.29031.12557431294039450779.stgit@devnote2>
References: <156773100816.29031.12557431294039450779.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode Xen and KVM's emulate-prefix signature by x86 insn decoder.
It is called "prefix" but actually not x86 instruction prefix, so
this adds insn.emulate_prefix_size field instead of reusing
insn.prefixes.

If x86 decoder finds a special sequence of instructions of
XEN_EMULATE_PREFIX and 'ud2a; .ascii "kvm"', it just counts the
length, set insn.emulate_prefix_size and fold it with the next
instruction. In other words, the signature and the next instruction
is treated as a single instruction.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Generalize the emulate-prefix handling not only for Xen but KVM.
  - Introduce insn.emulate_prefix_size instead of using insn.prefixes.
---
 arch/x86/include/asm/insn.h             |    6 +++++
 arch/x86/include/asm/xen/interface.h    |    7 ++++--
 arch/x86/include/asm/xen/prefix.h       |   10 +++++++++
 arch/x86/lib/insn.c                     |   36 +++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h       |    6 +++++
 tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++++
 tools/arch/x86/lib/insn.c               |   36 +++++++++++++++++++++++++++++++
 tools/objtool/sync-check.sh             |    3 ++-
 8 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/prefix.h
 create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 154f27be8bfc..5c1ae3eff9d4 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -45,6 +45,7 @@ struct insn {
 		struct insn_field immediate2;	/* for 64bit imm or seg16 */
 	};
 
+	int	emulate_prefix_size;
 	insn_attr_t attr;
 	unsigned char opnd_bytes;
 	unsigned char addr_bytes;
@@ -128,6 +129,11 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_has_emulate_prefix(struct insn *insn)
+{
+	return !!insn->emulate_prefix_size;
+}
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
index 62ca03ef5c65..fe33a9798708 100644
--- a/arch/x86/include/asm/xen/interface.h
+++ b/arch/x86/include/asm/xen/interface.h
@@ -379,12 +379,15 @@ struct xen_pmu_arch {
  * Prefix forces emulation of some non-trapping instructions.
  * Currently only CPUID.
  */
+#include <asm/xen/prefix.h>
+
 #ifdef __ASSEMBLY__
-#define XEN_EMULATE_PREFIX .byte 0x0f,0x0b,0x78,0x65,0x6e ;
+#define XEN_EMULATE_PREFIX .byte __XEN_EMULATE_PREFIX ;
 #define XEN_CPUID          XEN_EMULATE_PREFIX cpuid
 #else
-#define XEN_EMULATE_PREFIX ".byte 0x0f,0x0b,0x78,0x65,0x6e ; "
+#define XEN_EMULATE_PREFIX ".byte " __XEN_EMULATE_PREFIX_STR " ; "
 #define XEN_CPUID          XEN_EMULATE_PREFIX "cpuid"
+
 #endif
 
 #endif /* _ASM_X86_XEN_INTERFACE_H */
diff --git a/arch/x86/include/asm/xen/prefix.h b/arch/x86/include/asm/xen/prefix.h
new file mode 100644
index 000000000000..f901be0d7a95
--- /dev/null
+++ b/arch/x86/include/asm/xen/prefix.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
+#define _TOOLS_ASM_X86_XEN_PREFIX_H
+
+#include <linux/stringify.h>
+
+#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
+#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
+
+#endif
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 0b5862ba6a75..b7eb50187db9 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include <asm/inat.h>
 #include <asm/insn.h>
 
+/* For special Xen prefix */
+#include <asm/xen/prefix.h>
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +61,37 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+/* See handle_ud()@arch/x86/kvm/x86.c */
+static const insn_byte_t kvm_prefix[] = "\xf\xbkvm";
+
+static int __insn_get_emulate_prefix(struct insn *insn,
+				     const insn_byte_t *prefix, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (peek_nbyte_next(insn_byte_t, insn, i) != prefix[i])
+			goto err_out;
+	}
+
+	insn->emulate_prefix_size = len;
+	insn->next_byte += len;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+static void insn_get_emulate_prefix(struct insn *insn)
+{
+	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+		return;
+
+	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -76,6 +110,8 @@ void insn_get_prefixes(struct insn *insn)
 	if (prefixes->got)
 		return;
 
+	insn_get_emulate_prefix(insn);
+
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 37a4c390750b..568854b14d0a 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -45,6 +45,7 @@ struct insn {
 		struct insn_field immediate2;	/* for 64bit imm or seg16 */
 	};
 
+	int	emulate_prefix_size;
 	insn_attr_t attr;
 	unsigned char opnd_bytes;
 	unsigned char addr_bytes;
@@ -128,6 +129,11 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_has_emulate_prefix(struct insn *insn)
+{
+	return !!insn->emulate_prefix_size;
+}
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/tools/arch/x86/include/asm/xen/prefix.h b/tools/arch/x86/include/asm/xen/prefix.h
new file mode 100644
index 000000000000..f901be0d7a95
--- /dev/null
+++ b/tools/arch/x86/include/asm/xen/prefix.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
+#define _TOOLS_ASM_X86_XEN_PREFIX_H
+
+#include <linux/stringify.h>
+
+#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
+#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
+
+#endif
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 79e048f1d902..ce04e43e0749 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include "../include/asm/inat.h"
 #include "../include/asm/insn.h"
 
+/* For special Xen prefix */
+#include "../include/asm/xen/prefix.h"
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +61,37 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+/* See handle_ud()@arch/x86/kvm/x86.c */
+static const insn_byte_t kvm_prefix[] = "\xf\xbkvm";
+
+static int __insn_get_emulate_prefix(struct insn *insn,
+				     const insn_byte_t *prefix, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (peek_nbyte_next(insn_byte_t, insn, i) != prefix[i])
+			goto err_out;
+	}
+
+	insn->emulate_prefix_size = len;
+	insn->next_byte += len;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+static void insn_get_emulate_prefix(struct insn *insn)
+{
+	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+		return;
+
+	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -76,6 +110,8 @@ void insn_get_prefixes(struct insn *insn)
 	if (prefixes->got)
 		return;
 
+	insn_get_emulate_prefix(insn);
+
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 0a832e265a50..34143ea3d477 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -4,6 +4,7 @@
 FILES='
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
+arch/x86/include/asm/xen/prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
@@ -46,6 +47,6 @@ done
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/xen/prefix.h[\">]"'
 
 cd -

