Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984F0103C33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfKTNli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbfKTNle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7269122506;
        Wed, 20 Nov 2019 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257293;
        bh=TvtozhjDwpRJVBxBUpOs1PtrdTlKyZb+b/pl/mmK7Gw=;
        h=From:To:Cc:Subject:Date:From;
        b=xRJh+D9pNTRuVw3WMzYMIYhpW4ZML2atQq58RKQr71b3tCW9yRqvIjcWf5kG4NiFB
         gGv8G2tQKimzfcKTigUp81rkuVSRm5gFjkXdhPA8c3Bsu25c9CyvKvvs8AYuXeAuEy
         pkYgao6q913MCVtLpf3dY8rYdvFGqjKI41SCMXb8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:30 +0800
Message-Id: <20191120134130.15127-1-krzk@kernel.org>
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
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0b9d78a0f3ac..510aca6c50bd 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -82,7 +82,7 @@ config IOMMU_DEBUGFS
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "IOMMU passthrough by default"
 	depends on IOMMU_API
-        help
+	help
 	  Enable passthrough by default, removing the need to pass in
 	  iommu.passthrough=on or iommu=pt through command line. If this
 	  is enabled, you can still disable with iommu.passthrough=off
-- 
2.17.1

