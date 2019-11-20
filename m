Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0E103BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfKTNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfKTNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:07 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88E722475;
        Wed, 20 Nov 2019 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257027;
        bh=duNY+VBU6lUzCzx1T0ATt0/eCL5uIdsG7lRXCgb9EJY=;
        h=From:To:Cc:Subject:Date:From;
        b=fD9//T3lKbdwOprACds3bx1yCQNM32gU0WvZDmw//qGS1y1MLTaj8FstpMft/eQTb
         lzpkDWLhFl7Rdx59hEWmoVR2JYhmr1/Y0Aq5CuaPtUp2etybCxtkfGZ7vu4NjIVHhD
         ScNBzjsu4+vuNgTKj2Btd8qqi0851nOwA10KZJnU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:03 +0800
Message-Id: <20191120133703.11956-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/riscv/Kconfig.socs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 536c0ef4aee8..85199004c6ef 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -8,6 +8,6 @@ config SOC_SIFIVE
        select CLK_SIFIVE_FU540_PRCI
        select SIFIVE_PLIC
        help
-         This enables support for SiFive SoC platform hardware.
+	 This enables support for SiFive SoC platform hardware.
 
 endmenu
-- 
2.17.1

