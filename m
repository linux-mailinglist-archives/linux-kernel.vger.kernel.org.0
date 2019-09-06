Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6692DAB900
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfIFNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 09:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390862AbfIFNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:13:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E2E206BB;
        Fri,  6 Sep 2019 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567775633;
        bh=rZzxI9XArt0wbskwU2r8uJHAgPdmUcSFpX/eT3zQGMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6NY01TImkhzgeTZiksXsH1gnuCvp59kbibTxZmzs4RbcDHmv/N8J/RTAVQ1u2WUM
         gNBp8lMkjd6IlByDMIOGHwx0Z7DL/Xa6VMvWQykvlni9e1vmH4ZVGHPTnbOotvK1oO
         Lmo+YFCSuclG7ZsK7KMSa+YJj0y4flOxq8/Qb3oc=
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
Subject: [PATCH -tip v4 1/4] x86/asm: Allow to pass macros to __ASM_FORM()
Date:   Fri,  6 Sep 2019 22:13:48 +0900
Message-Id: <156777562873.25081.2288083344657460959.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156777561745.25081.1205321122446165328.stgit@devnote2>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __stringify() at __ASM_FORM() so that user can pass
code including macros to __ASM_FORM().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/asm.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ff577c0b102..1b563f9167ea 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -7,9 +7,11 @@
 # define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
 #else
-# define __ASM_FORM(x)	" " #x " "
-# define __ASM_FORM_RAW(x)     #x
-# define __ASM_FORM_COMMA(x) " " #x ","
+#include <linux/stringify.h>
+
+# define __ASM_FORM(x)	" " __stringify(x) " "
+# define __ASM_FORM_RAW(x)     __stringify(x)
+# define __ASM_FORM_COMMA(x) " " __stringify(x) ","
 #endif
 
 #ifndef __x86_64__

