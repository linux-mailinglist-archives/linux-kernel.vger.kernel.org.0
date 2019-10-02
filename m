Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B0C4A33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfJBJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 05:06:57 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:52171 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFaat-00057p-JN; Wed, 02 Oct 2019 11:06:47 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: Document ICC_CTLR_EL3.PMHE setting requirements
Date:   Wed,  2 Oct 2019 10:06:13 +0100
Message-Id: <20191002090613.14236-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002090613.14236-1-maz@kernel.org>
References: <20191002090613.14236-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It goes without saying, but better saying it: the kernel expects
ICC_CTLR_EL3.PMHE to have the same value across all CPUs, and
for that setting not to change during the lifetime of the kernel.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/booting.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index d3f3a60fbf25..5d78a6f5b0ae 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -213,6 +213,9 @@ Before jumping into the kernel, the following conditions must be met:
 
       - ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
       - ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
+      - ICC_CTLR_EL3.PMHE (bit 6) must be set to the same value across
+        all CPUs the kernel is executing on, and must stay constant
+        for the lifetime of the kernel.
 
   - If the kernel is entered at EL1:
 
-- 
2.20.1

