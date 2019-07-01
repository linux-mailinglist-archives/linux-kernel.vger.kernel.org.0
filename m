Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E184A88B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfFRRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 13:37:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfFRRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SCTAf51g4JywlDJnkbkfASERNcj/35F5Z5E+VT3RGQM=; b=XjC3JsOQ/vU6mI3undkJC/Mv2
        7Kq/NyVKjKkT7xeEjdrWu1Lohs8EHbMEQ41O5tRBTUoTJj5xDbJ2yP+l2bW9W/2RXbMQiOfgerfOg
        zWrrZRMrV7/VdPb953NanM7MqSz426DUUOOQrRBk+eLIbKT8Ekv4HvSmSVIZ6JisXy15o=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdI2f-0005G4-Gx; Tue, 18 Jun 2019 17:37:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BF100440046; Tue, 18 Jun 2019 18:37:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: core: Make entire header comment C++ style
Date:   Tue, 18 Jun 2019 18:37:07 +0100
Message-Id: <20190618173707.17713-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes things look more consistent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c    | 15 +++++++--------
 drivers/regulator/helpers.c | 11 +++++------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index aff1f2cefe4b..eb5670d7dcbb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * core.c  --  Voltage/Current Regulator framework.
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- * Copyright 2008 SlimLogic Ltd.
- *
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- */
+//
+// core.c  --  Voltage/Current Regulator framework.
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+// Copyright 2008 SlimLogic Ltd.
+//
+// Author: Liam Girdwood <lrg@slimlogic.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index b9ae45d2d199..4986cc5064a1 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * helpers.c  --  Voltage/Current Regulator framework helper functions.
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- * Copyright 2008 SlimLogic Ltd.
- */
+//
+// helpers.c  --  Voltage/Current Regulator framework helper functions.
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+// Copyright 2008 SlimLogic Ltd.
 
 #include <linux/kernel.h>
 #include <linux/err.h>
-- 
2.20.1

