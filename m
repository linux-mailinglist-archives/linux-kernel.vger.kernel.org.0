Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03811902A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCXAPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:15:49 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29697 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCXAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:15:47 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 02O0EHnv026701;
        Tue, 24 Mar 2020 09:14:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 02O0EHnv026701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585008866;
        bh=kQokSOGafKM9qlMy9Knp7M7g8No8/5Dc4IXiyrgHWNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKLMYgiC0h8xGXZ+vkn32yE2vMwKGCmJDFBEK0pcJQYejUEkp8oA7wrQfhVfyoBv6
         xsqRdj3hJhEyPw0iKcAolxDhBsxQ3Fif3ZtfbqMf0OLP7MVN3SvmkWaGLeys7mwBpx
         hr7rmt3hkP8O/wEt4UW0kesGPQZsf97budesAb3tsIfASyS7TMn10G2sQldtEz3plu
         UIzzg7lOQ6ykVt4blr/uVxZWQSH6iHT1O8+J/xdErOSNiAX+UZbnjxrsnRBX3B6zup
         rh4qu13PclcrfOg/esoEXrxkOmL7RTFTjyPPmFrHRuiyJO5sL5mNdZaLuNmoCkqFPw
         86qFI+k9csL4A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 8/9] x86: add comments about the binutils version to support code in as-instr
Date:   Tue, 24 Mar 2020 09:13:57 +0900
Message-Id: <20200324001358.4520-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324001358.4520-1-masahiroy@kernel.org>
References: <20200324001358.4520-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We raise the minimal supported binutils version from time to time.
The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
required binutils version to 2.21").

We need to keep these as-instr checks because binutils 2.21 does not
support them.

I hope this will be a good hint which one can be dropped when we
bump the minimal binutils version next time.

As for the Clang/LLVM builds, we require very new LLVM version,
so the LLVM integrated assembler supports all of them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
---

Changes in v2: None

 arch/x86/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f32ef7b8d5ca..4c57cb3018fb 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,10 +178,15 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 endif
 
 # does binutils support specific instructions?
+# binutils >= 2.22
 avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
+# binutils >= 2.25
 avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)
+# binutils >= 2.24
 sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=1)
+# binutils >= 2.24
 sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
+# binutils >= 2.23
 adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
 
 KBUILD_AFLAGS += $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
-- 
2.17.1

