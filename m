Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7965019A3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 04:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgDAC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 22:58:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731565AbgDAC6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:58:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66C657877F15F2D3AB0C;
        Wed,  1 Apr 2020 10:57:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 10:57:38 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <rmfrfs@gmail.com>, <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <chenzhou10@huawei.com>, <greybus-dev@lists.linaro.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: greybus: fix a missing-check bug in gb_lights_light_config()
Date:   Wed, 1 Apr 2020 11:00:17 +0800
Message-ID: <20200401030017.100274-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gb_lights_light_config(), 'light->name' is allocated by kstrndup().
It returns NULL when fails, add check for it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/staging/greybus/light.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d6ba25f..d2672b6 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1026,7 +1026,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
 
 	light->channels_count = conf.channel_count;
 	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
-
+	if (!light->name)
+		return -ENOMEM;
 	light->channels = kcalloc(light->channels_count,
 				  sizeof(struct gb_channel), GFP_KERNEL);
 	if (!light->channels)
-- 
2.7.4

