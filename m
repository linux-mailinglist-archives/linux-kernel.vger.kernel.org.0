Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4218DD49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfHNSq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfHNSq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:46:28 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1158B2084F;
        Wed, 14 Aug 2019 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808387;
        bh=pkGF1dPCmeJOOs72u3tXViFjHz/eh1ppNyNSBW7bzRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpXReTF2xTw8+F2VXVqN7rDazYTh+jWzb7FYM/TR6YkfzYpi4rmOOJiEuFHgah5/D
         cn85jd/1ds/gMROZCFXNfkoROr1qgIZnjWH1mrGnaBIuh9ndilVkVb6ef0gdFezX8C
         IYa/09j5LJSR1fONiAEzjCXdrFnEhDzv/6UWx+XM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/28] tools: Keep list of tools in alphabetical order
Date:   Wed, 14 Aug 2019 15:40:48 -0300
Message-Id: <20190814184051.3125-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When `make help` is executed it lists the possible tools to build,
though couple of entries is kept unordered. Fix it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-0ke3p64ksa0hnbueh52n3v3q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 68defd7ecf5d..7e42f7b8bfa7 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -10,6 +10,7 @@ help:
 	@echo 'Possible targets:'
 	@echo ''
 	@echo '  acpi                   - ACPI tools'
+	@echo '  bpf                    - misc BPF tools'
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
@@ -23,12 +24,11 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
-	@echo '  bpf                    - misc BPF tools'
+	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  spi                    - spi tools'
-	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb                    - USB testing tools'
-- 
2.21.0

