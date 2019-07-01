Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62604127A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfECGTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:19:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfECGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dr8iiJcg2+vpOn+Dy6n/2x3VLOxcn420oALuCMcHAYQ=; b=fDT8KNYBDWca
        T9aeBLBddt9HqUeB8emGNL3VUNDwa1/5/+x1cjE87LzLYGW/NVHGcTQUN8kRta5PiyUd+nhnv+Md6
        W/NXC5pOIGjqy9Pn6Yt6RD2pw1XAKm7BprfCQhPS0d80hAfwTZCUCLlXCLnWOYAXcDSCg5TBhKoml
        X1yhg=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRX2-0000Xx-9i; Fri, 03 May 2019 06:18:54 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 33DF7441D5A; Fri,  3 May 2019 07:18:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Applied "regulator: da9xxx: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190503053637.25911-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503061847.33DF7441D5A@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9xxx: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fd2f02f9724c416221b42af95e1a7a57fa42d681 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 3 May 2019 13:36:37 +0800
Subject: [PATCH] regulator: da9xxx: Switch to SPDX identifier

Convert Dialog Semiconductor DA9xxx regulator drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da903x.c           | 16 ++++++----------
 drivers/regulator/da9052-regulator.c | 20 +++++++-------------
 drivers/regulator/da9055-regulator.c | 20 +++++++-------------
 drivers/regulator/da9062-regulator.c | 19 +++++--------------
 drivers/regulator/da9210-regulator.c | 23 ++++-------------------
 drivers/regulator/da9210-regulator.h | 17 +----------------
 drivers/regulator/da9211-regulator.c | 20 +++++---------------
 drivers/regulator/da9211-regulator.h | 11 +----------
 8 files changed, 36 insertions(+), 110 deletions(-)

diff --git a/drivers/regulator/da903x.c b/drivers/regulator/da903x.c
index 33e8f3b8d2bd..5493c3a86426 100644
--- a/drivers/regulator/da903x.c
+++ b/drivers/regulator/da903x.c
@@ -1,13 +1,9 @@
-/*
- * Regulators driver for Dialog Semiconductor DA903x
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- * Copyright (C) 2008 Compulab Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulators driver for Dialog Semiconductor DA903x
+//
+// Copyright (C) 2006-2008 Marvell International Ltd.
+// Copyright (C) 2008 Compulab Ltd.
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index b90a7ac3f3de..e18d291c7f21 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -1,16 +1,10 @@
-/*
-* da9052-regulator.c: Regulator driver for DA9052
-*
-* Copyright(c) 2011 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9052-regulator.c: Regulator driver for DA9052
+//
+// Copyright(c) 2011 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index bcbc2fbd7fea..c025ccb1a30a 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -1,16 +1,10 @@
-/*
-* Regulator driver for DA9055 PMIC
-*
-* Copyright(c) 2012 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator driver for DA9055 PMIC
+//
+// Copyright(c) 2012 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a7d929b7776a..a02e0488410f 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1,17 +1,8 @@
-/*
- * Regulator device driver for DA9061 and DA9062.
- * Copyright (C) 2015-2017  Dialog Semiconductor
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator device driver for DA9061 and DA9062.
+// Copyright (C) 2015-2017  Dialog Semiconductor
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 528303771723..f9448ed50e05 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -1,22 +1,7 @@
-/*
- * da9210-regulator.c - Regulator device driver for DA9210
- * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9210-regulator.c - Regulator device driver for DA9210
+// Copyright (C) 2013  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9210-regulator.h b/drivers/regulator/da9210-regulator.h
index 749c550808b6..b1f1a607c208 100644
--- a/drivers/regulator/da9210-regulator.h
+++ b/drivers/regulator/da9210-regulator.h
@@ -1,22 +1,7 @@
-
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9210-regulator.h - Regulator definitions for DA9210
  * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
  */
 
 #ifndef __DA9210_REGISTERS_H__
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 4d7fe4819c1c..da37b4ccd834 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -1,18 +1,8 @@
-/*
- * da9211-regulator.c - Regulator device driver for DA9211/DA9212
- * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
- * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9211-regulator.c - Regulator device driver for DA9211/DA9212
+// /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
+// Copyright (C) 2015  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9211-regulator.h b/drivers/regulator/da9211-regulator.h
index 2cb32aab4f82..1201e7cc056c 100644
--- a/drivers/regulator/da9211-regulator.h
+++ b/drivers/regulator/da9211-regulator.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9211-regulator.h - Regulator definitions for DA9211/DA9212
  * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DA9211_REGISTERS_H__
-- 
2.20.1

