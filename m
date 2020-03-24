Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8ED191197
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCXNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDE920789;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=Ng776RDVUtwc7KQiVz21I8I2Wgral1f/GNSOxXixasQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHDflqEmvQI9nzCYw+cOZBh+6Csjeu4WGE0kjxRg4U5tRlnEx5Os94JIrI79DZIYu
         aL54J2/kivNSx22ZKFQI83c4Njfu+8tGAHXfOdhp4xT5Sm0Z4TLnBBE9+roelWbjmQ
         zooin59ZflkKlh/vi9B+BDFTm13RWOKD+p1vTveo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025qp-Ib; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 03/20] media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
Date:   Tue, 24 Mar 2020 14:42:56 +0100
Message-Id: <ff872710986d3a26fe952f990d93219ad89e473e.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V4L2 PCI skeleton is not part of the V4L2 core. Move it
to appear together with the other PCI drivers, at the end,
as this is something that normal users don't even need to
bother.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/Kconfig       | 10 ++++++++++
 drivers/media/v4l2-core/Kconfig | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/Kconfig b/drivers/media/pci/Kconfig
index dcb3719f440e..9336f8446cf0 100644
--- a/drivers/media/pci/Kconfig
+++ b/drivers/media/pci/Kconfig
@@ -56,5 +56,15 @@ endif
 
 source "drivers/media/pci/intel/ipu3/Kconfig"
 
+config VIDEO_PCI_SKELETON
+	tristate "Skeleton PCI V4L2 driver"
+	depends on PCI
+	depends on SAMPLES
+	depends on VIDEO_V4L2 && VIDEOBUF2_CORE
+	depends on VIDEOBUF2_MEMOPS && VIDEOBUF2_DMA_CONTIG
+	help
+	  Enable build of the skeleton PCI driver, used as a reference
+	  when developing new drivers.
+
 endif #MEDIA_PCI_SUPPORT
 endif #PCI
diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
index 39e3fb30ba0b..26276b257eae 100644
--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -31,16 +31,6 @@ config VIDEO_FIXED_MINOR_RANGES
 
 	  When in doubt, say N.
 
-config VIDEO_PCI_SKELETON
-	tristate "Skeleton PCI V4L2 driver"
-	depends on PCI
-	depends on SAMPLES
-	depends on VIDEO_V4L2 && VIDEOBUF2_CORE
-	depends on VIDEOBUF2_MEMOPS && VIDEOBUF2_DMA_CONTIG
-	help
-	  Enable build of the skeleton PCI driver, used as a reference
-	  when developing new drivers.
-
 # Used by drivers that need tuner.ko
 config VIDEO_TUNER
 	tristate
-- 
2.24.1

