Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22B172CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgB1AB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:01:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgB1ABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so455325pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFmbceD7QHP2G9Ca/GnJtf4RpKTt/GJIPcRUSUwSzaM=;
        b=cPSt7bG5f9am1KrbI/3idQAzXifp6xRIa4U46unWv7iH/cibsg+eZ8l1rB6LPI4A3J
         8rCXT984f0GR9+WFpo9bKN6sz8MJaqhBVXKhhhDkItlzI97jFLioOsVRSWGgtH1SyOcq
         nZKW7rm5ajlWmnAvixODO9wGmSW1zN7cSoBKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFmbceD7QHP2G9Ca/GnJtf4RpKTt/GJIPcRUSUwSzaM=;
        b=qbkvDtP6rLu6DOtOujHrAvjtOXwGFYEWu19bmj/4VweM4wNc24abiAX+CxPTvmM311
         LpTCD3eXJXVgQLZb/ySTjJbdRDeOeJfhDT4b5jJ9Q1kh2630MJnfcenySOltqmfWjjwA
         f/uAngdb5l25WAOBh4HFS/sSYXFFTIuPDxH+JZ8ld993AbaERa8wEHyGiXzZjXI6bnM9
         P0th0odTZmK1CNvtVDDtOx8skJI66uj7urrHMzpEJwW1KuNCTuOpknBo7tobAm47Y63j
         3du/TXUaIeQ2PmZMlWzOiTocUSNfllQKHAx3yzcPw55DvcSUNIiZHTZw0OHstoBd9hMZ
         NoGA==
X-Gm-Message-State: APjAAAU92ev8Pa/Kkq1H2OzZwxJmeZC7CduAUBm5BmxQjol4O+WEKwe6
        eIKN5qmUMZZ59006BwS9uiBHjw==
X-Google-Smtp-Source: APXvYqxzxq/RTsPVyBecAqne+dw68kSQHDmNiBFv21TtsNfqzjAmpUojokc1C1FJiTR3aVdLqW7w3Q==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr1371193plk.0.1582848084250;
        Thu, 27 Feb 2020 16:01:24 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:23 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 08/11] x86/boot/64: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:53 -0800
Message-Id: <20200228000105.165012-9-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use absolute reference for transition
between address spaces and relative references when referencing global
variables in the same address space. Ensure the kernel built with PIE
references the correct addresses based on context.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head_64.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4bbc770af632..40a467f8e116 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -87,7 +87,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
 SYM_CODE_END(startup_64)
 
@@ -119,7 +120,8 @@ SYM_CODE_START(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -137,7 +139,7 @@ SYM_CODE_START(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -234,11 +236,12 @@ SYM_CODE_START(secondary_startup_64)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	movabs  $.Lafter_lret, %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
-	movq	initial_code(%rip), %rax
+	leaq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
+	pushq	(%rax)		# target address in negative space
 	lretq
 .Lafter_lret:
 SYM_CODE_END(secondary_startup_64)
-- 
2.25.1.481.gfbce0eb801-goog

