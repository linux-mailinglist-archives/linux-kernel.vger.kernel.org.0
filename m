Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0803D139CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgAMWjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 17:39:41 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:36592 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578955179; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=kNgfs7X7Hc2KMC4GmA/0j/L2r8y2/xanqtW2YzGNGlY=;
        b=dO2SQ1ze1bOawsHpR4SIOgjYX8yfI7zX/R9UfQDHO02QyLXz7eqP5sj95aquMqo293Y37D
        l7idTcBSjPF+24gzmK/GRI87sqQ/0RefagWqX04gVc9cVtnPnxAL7YCFhXCKx8W8gSoGmn
        F71wLNoB5oHHp5J6wE6NgUyR1wfexT4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Corentin Chary <corentin.chary@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] platform/x86: asus-nb-wmi: Support left round button on N56VB
Date:   Mon, 13 Jan 2020 19:39:27 -0300
Message-Id: <20200113223927.102509-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The N56VB laptop has a round button located on the left side above the
keyboard. Map it to F13 since it does not have any predeterminated
purpose.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b361c73636a4..6f12747a359a 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -471,6 +471,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x67, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV */
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
+	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
-- 
2.24.1

