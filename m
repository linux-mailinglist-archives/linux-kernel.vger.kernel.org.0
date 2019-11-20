Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD085103CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfKTN6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTN6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:58:24 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F3722310;
        Wed, 20 Nov 2019 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258304;
        bh=Id5FGnBePEHJ10km5onKgh+P+DFvfIXEEipgxJQRF54=;
        h=From:To:Cc:Subject:Date:From;
        b=QF7dQomBetofAiw/gERCs6oMcAIKP7E4zshC/mmWrtjCgy2DrKsuHNBSKuEwa74NV
         sRjBlN9Smq1HMsYdS8KoTatGcIviLyZOFRtiLgfGPyeTZDj4dBbCAiQtYIf8j64DJA
         XOWvf4MISxO1zVC220MQR3alGse6QriRb/BIg548=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] virt: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:58:03 +0800
Message-Id: <20191120135803.18590-1-krzk@kernel.org>
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
 drivers/virt/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 363af2eaf2ba..cb5d2d89592f 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -18,17 +18,17 @@ config FSL_HV_MANAGER
 	depends on FSL_SOC
 	select EPAPR_PARAVIRT
 	help
-          The Freescale hypervisor management driver provides several services
+	  The Freescale hypervisor management driver provides several services
 	  to drivers and applications related to the Freescale hypervisor:
 
-          1) An ioctl interface for querying and managing partitions.
+	  1) An ioctl interface for querying and managing partitions.
 
-          2) A file interface to reading incoming doorbells.
+	  2) A file interface to reading incoming doorbells.
 
-          3) An interrupt handler for shutting down the partition upon
+	  3) An interrupt handler for shutting down the partition upon
 	     receiving the shutdown doorbell from a manager partition.
 
-          4) A kernel interface for receiving callbacks when a managed
+	  4) A kernel interface for receiving callbacks when a managed
 	     partition shuts down.
 
 source "drivers/virt/vboxguest/Kconfig"
-- 
2.17.1

