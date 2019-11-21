Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA5104935
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 04:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKUDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 22:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfKUDVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:01 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8AA208CE;
        Thu, 21 Nov 2019 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306461;
        bh=BqQct8MurXEaQBIdn4W/JxxMj+Cw1+0kP+2a1H36etY=;
        h=From:To:Cc:Subject:Date:From;
        b=wkTTcG/LeOpnQx+o0eJ95hmXusT7EtPXbJmXmcWOSzLxoD8b5QuXmh3ozlkv6gdM0
         siTTLCQ1N0XcKG+HqCit0fOPuz0Yn63XPj5QikxODO3Q9mOfxJ7CB7BKkk5FTLOiEJ
         f+ouWsVKT2xqhbUcmsi+aETAPi9pioz+/o3pJV0I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:57 +0100
Message-Id: <1574306457-6251-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 arch/riscv/Kconfig.socs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 536c0ef4aee8..f89b73281737 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,13 +1,13 @@
 menu "SoC selection"
 
 config SOC_SIFIVE
-       bool "SiFive SoCs"
-       select SERIAL_SIFIVE
-       select SERIAL_SIFIVE_CONSOLE
-       select CLK_SIFIVE
-       select CLK_SIFIVE_FU540_PRCI
-       select SIFIVE_PLIC
-       help
-         This enables support for SiFive SoC platform hardware.
+	bool "SiFive SoCs"
+	select SERIAL_SIFIVE
+	select SERIAL_SIFIVE_CONSOLE
+	select CLK_SIFIVE
+	select CLK_SIFIVE_FU540_PRCI
+	select SIFIVE_PLIC
+	help
+	 This enables support for SiFive SoC platform hardware.
 
 endmenu
-- 
2.7.4

