Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E34A46D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 05:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfIADDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 23:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbfIADDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:03:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E7220674;
        Sun,  1 Sep 2019 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567306991;
        bh=SMxNxvrkxbzXxkUTbo+1kv6MN2DucbzGYGRY64lIMiE=;
        h=From:To:Cc:Subject:Date:From;
        b=SVks01K8wgBaAc81UgkoMxvRuE5qYE5kBZVhG5D3BzyfdEQs15ljwmlQ6AWsH7ASw
         eAWVIBgF5QKcH+0LdiMrnTzvGVBw+c32B3UT8FZNnVs9ieyoMUK6ct9OUtoyDpIY8t
         j/L0DUVW1FmQ/p22+h7BDn4ukXylbyJyTysKkqNk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix the dependency of x86 insn decoder selftest
Date:   Sun,  1 Sep 2019 12:03:08 +0900
Message-Id: <156730698806.16525.10389215865137674111.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since x86 instruction decoder is not only for kprobes,
it should be tested when the insn.c is compiled.
(e.g. perf is enabled but kprobes is disabled)

Fixes: cbe5c34c8c1f ("x86: Compile insn.c and inat.c only for KPROBES")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 71c92db47c41..bf9cd83de777 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -171,7 +171,7 @@ config HAVE_MMIOTRACE_SUPPORT
 
 config X86_DECODER_SELFTEST
 	bool "x86 instruction decoder selftest"
-	depends on DEBUG_KERNEL && KPROBES
+	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
 	depends on !COMPILE_TEST
 	---help---
 	 Perform x86 instruction decoder selftests at build time.

