Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDADDB706
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503422AbfJQTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 15:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503411AbfJQTLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:11:01 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273F121835;
        Thu, 17 Oct 2019 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571339460;
        bh=WlfWj5+CPevvRuRaMzN+6aoPq35YA+FKL885H/YUNNA=;
        h=From:To:Cc:Subject:Date:From;
        b=1I0PTFp6nUreKkGzWho6AJPh2qpFaR0hxCsZlK9ixui2Fn2U0WlwR8pNbSV/aEmZG
         DXjtncuHZPjYVbZ+Ir68+SDDaCzF/TJ5lF5IJEqJyL1M0qCa+1wusXhMPff4aReyOF
         7EmhRRU01SzqrmLWBHekg3ItDpypzfGNMwyMNCGs=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     catalin.marinas@arm.com
Cc:     dinguyen@kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: enable the Cadence QSPI controller
Date:   Thu, 17 Oct 2019 14:10:49 -0500
Message-Id: <20191017191049.3571-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Cadence QSPI controller driver that is on the Stratix10 and
Agilex platforms.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e05c39eab08..cd596df2edfc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -211,6 +211,7 @@ CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
-- 
2.20.0

