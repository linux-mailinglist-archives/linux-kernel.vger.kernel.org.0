Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3EA9472
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfIDVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 17:05:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:47224 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbfIDVF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:05:27 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id E80261A652C;
        Wed,  4 Sep 2019 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1567631127; bh=RLM1V7holiv5uXxR58b5zPqf00nxc2ymX8fdlGsPBOs=;
        h=From:To:Subject:Date:From;
        b=A3wowv/MIngUNkpsgk59MMoIHhiDyIi6FhwyI39b9jnKZgmF0poaC7Jh0GD4dSm+K
         PYmi5kdloCu8LfuedeZmcW3Jtxvs2kKNd2VvHjmgdGtdBMAv75hw1NKs1RANcqaZ8n
         7qdLwlMEg2vM+uzjZqcjLOXQu0AXcIf1ggjwietE=
X-Riseup-User-ID: 4E284FA5E98CD97C1A4A4A34D27E74924627F18E6477D22557B90FBBC61CF950
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 63C952231D9;
        Wed,  4 Sep 2019 14:05:25 -0700 (PDT)
From:   Leandro Ribeiro <leandrohr@riseup.net>
To:     lkcamp@lists.libreplanetbr.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] staging: rtl8723bs: Remove return statement from void function
Date:   Wed,  4 Sep 2019 21:06:31 +0000
Message-Id: <20190904210631.13599-1-leandrohr@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:

"WARNING: void function return statements are not generally useful"

Signed-off-by: Leandro Ribeiro <leandrohr@riseup.net>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 79c1e3edb189..7760fd0eb6c9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -1406,7 +1406,6 @@ void rtl8723b_set_ap_wowlan_cmd(struct adapter *padapter, u8 enable)
 	rtl8723b_set_Fw_AP_Offload_Cmd(padapter, enable);
 	msleep(10);
 	DBG_871X_LEVEL(_drv_always_, "-%s()-\n", __func__);
-	return ;
 }
 #endif /* CONFIG_AP_WOWLAN */
 
-- 
2.20.1

