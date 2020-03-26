Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06096194341
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgCZPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:34072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgCZPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:32:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B3657FA;
        Thu, 26 Mar 2020 08:32:14 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.17.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6700E3F71E;
        Thu, 26 Mar 2020 08:32:12 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 1/2] init/kconfig: Add LD_VERSION Kconfig
Date:   Thu, 26 Mar 2020 21:01:59 +0530
Message-Id: <1585236720-21819-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option can be used in Kconfig files to compare the ld version
and enable/disable incompatible config options if required.

This option is used in the subsequent patch along with GCC_VERSION to
filter out an incompatible feature.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---

This patch series is based on Linux arm64 for-next tree [1]. More details
of this work can be found in the thread [2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2020-March/720257.html

 init/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 452bc18..68ddbcd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -17,6 +17,10 @@ config GCC_VERSION
 	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
 	default 0
 
+config LD_VERSION
+	int
+	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
+
 config CC_IS_CLANG
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
 
-- 
2.7.4

