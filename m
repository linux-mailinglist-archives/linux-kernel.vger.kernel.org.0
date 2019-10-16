Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD28D98EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403796AbfJPSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 14:14:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58324 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:14:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIEnLo062713;
        Wed, 16 Oct 2019 13:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249689;
        bh=3jWr866vKfNto/Gt15iz+tfbmgradkrpgMq5Hxt+fQk=;
        h=From:To:CC:Subject:Date;
        b=AP76/FEYiOVA8nHvxb9yB8uStnPF48PsCmg6Zpc6xrvpJz6SBhjBglQJ/z3dSuW3U
         eQmfJEbAkqGFgIxQnwO9cO9GuCWgLHT38rzDu+EZrSDpnYkDve2eL0k/9A2cvZ0yC3
         DfSw5e1TXz3JxhV8apKjgB3dJbAjahCA40frBfrs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIEnSB026121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:14:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:14:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:14:49 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIEm3W066416;
        Wed, 16 Oct 2019 13:14:49 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIElZ02382;
        Wed, 16 Oct 2019 13:14:47 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 02/10] cxl: remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:14:35 -0400
Message-ID: <20191016181443.24790-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/misc/cxl/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index f0263d1a1fdf..c57ec87bc0a6 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -178,7 +178,7 @@ static ssize_t perst_reloads_same_image_store(struct device *device,
 	if ((rc != 1) || !(val == 1 || val == 0))
 		return -EINVAL;
 
-	adapter->perst_same_image = (val == 1 ? true : false);
+	adapter->perst_same_image = (val == 1);
 	return count;
 }
 
-- 
2.17.1

