Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931EC103C01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfKTNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbfKTNje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFC82251E;
        Wed, 20 Nov 2019 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257174;
        bh=KXX/JKwRu4ohqPW7ejgTiWHaFI0B/xv28AFyZomXDzM=;
        h=From:To:Cc:Subject:Date:From;
        b=0BU5guxnx+oiScud7GD6GK19b2XNEHWNSjAoRyJl+e0DMqiv+EH9QLC5Cy76/MNPb
         22ARFRfyjMRARJR5bTuvYbzyqfUiTC36kTncmo/Cs+i/2kj3rEsh/LxxRbcm5Q5YkD
         NiBe7PdhIytPqpAwMqANHrMYCbNqQK8dE0rB/bZs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:29 +0800
Message-Id: <20191120133930.13767-1-krzk@kernel.org>
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
 drivers/soc/fsl/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 4df32bc4c7a6..8e6f8e57ecd7 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -21,10 +21,10 @@ config FSL_GUTS
 	  into this driver as well.
 
 config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        select SOC_BUS
-        help
+	tristate "QorIQ DPAA2 DPIO driver"
+	depends on FSL_MC_BUS
+	select SOC_BUS
+	help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
 	  other DPAA2 objects. This driver does not expose the DPIO
-- 
2.17.1

