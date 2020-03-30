Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA8197AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgC3LmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:42:01 -0400
Received: from foss.arm.com ([217.140.110.172]:51330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgC3LmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484FD31B;
        Mon, 30 Mar 2020 04:42:00 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.17.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5997C3F52E;
        Mon, 30 Mar 2020 04:41:58 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v2 1/2] init/kconfig: Add LD_VERSION Kconfig
Date:   Mon, 30 Mar 2020 17:11:38 +0530
Message-Id: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
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
Changes since v1:
* None.

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

