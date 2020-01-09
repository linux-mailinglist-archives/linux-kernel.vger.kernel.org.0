Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC92135130
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 03:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgAICBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 21:01:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgAICBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:01:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so5547906wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 18:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iYe0+gSx0d6kGqoHpE4txDtuMtPfG3guwT+JpC3OQQM=;
        b=D+zOKGF7kFgdTPhDPFegg+Uv/CgFb3MtgSvgMoe+duxkqTlONnQdG10WClr1LlpZZb
         wDyLbdPfaxCoysMGexy176+7GzzC5oN1MhaYwawc4wrAOL+4CJv7TXSf9WqUKGMy/5Oa
         lW5iXSwBkV+eqmcDU+MIKsODI/sM+PWjVR9Zx2uqRflyY4T6d0Y5lHoSbpf//Zk9C3lH
         fPlTeFXB3OsMcri6LCMcgqL+/ckuvqmm5dPTf+jvNxzXHfBhnG2CnVVZr5qxwfnDyF0H
         9pbVs4bI6lJzSgTHTpehgIdWC1qsdMalMrITCKYiWakcf44gaEWklotEKpkgY4vZ1UgS
         pZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYe0+gSx0d6kGqoHpE4txDtuMtPfG3guwT+JpC3OQQM=;
        b=dkaoNSOMi1GKl6FPT7rAO93KlmV1Pg+hRv5ETHxUClPkexbaOtY9l/v4d3NBfDf23+
         NOC6UAppPzUXDhRkovIc1iwRPYLhNrWecM6Il8LdyBKc30dDGkYRYKt8ZFEFWMIeE7Rt
         HvHtTjZW7NrIHa9dEDFCSepsHJhO/20cqJbhPjVoFteLYYYyyk4EM5Nivecx1H1xlGJx
         6wqo9cjwJM88fSXYwZsN9vkFi2R9485ivfwopozsS9LDIr5c/vONFtsYYA2Xu0kh8jnX
         l2TWHDeQdIx0M/MGFuxBL97iuwHMVMWM0i1/6b0QzrliVdCQgIJel2PNGzTKep/0ktjC
         49Xg==
X-Gm-Message-State: APjAAAVBkryZEf/0C/Zz0XNU7rL7a8iUkFet9bHCg+m5voG2AO2duNjb
        tk6OtHEiQkgH3txwYjC0bRk=
X-Google-Smtp-Source: APXvYqwa5iYqVH4uRycxFuqjSA7ueov7SHiBiFp9OLDyAjAxjWY/ZAWwCfvpN43U3M8Nofej6oIxWA==
X-Received: by 2002:adf:9427:: with SMTP id 36mr7858974wrq.166.1578535292556;
        Wed, 08 Jan 2020 18:01:32 -0800 (PST)
Received: from localhost.localdomain ([2001:8a0:e1c7:2401:691a:32ac:afc5:3de7])
        by smtp.gmail.com with ESMTPSA id m7sm1051793wma.39.2020.01.08.18.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 18:01:32 -0800 (PST)
From:   andre.pascoal.bento@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        andrepbento <andre.pascoal.bento@gmail.com>
Subject: [PATCH 101/101] Accessibility: braille: braille_console: fixed three missing black lines coding style
Date:   Thu,  9 Jan 2020 02:01:25 +0000
Message-Id: <20200109020125.16019-1-andre.pascoal.bento@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: andrepbento <andre.pascoal.bento@gmail.com>

Fixed three missing blank lines after declaration.

Signed-off-by: andrepbento <andre.pascoal.bento@gmail.com>
---
 drivers/accessibility/braille/braille_console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 1339c586bf64..ac713906009f 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -225,6 +225,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
 	case KBD_POST_KEYSYM:
 	{
 		unsigned char type = KTYP(param->value) - 0xf0;
+
 		if (type == KT_SPEC) {
 			unsigned char val = KVAL(param->value);
 			int on_off = -1;
@@ -264,6 +265,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 {
 	struct vt_notifier_param *param = _param;
 	struct vc_data *vc = param->vc;
+
 	switch (code) {
 	case VT_ALLOCATE:
 		break;
@@ -272,6 +274,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 	case VT_WRITE:
 	{
 		unsigned char c = param->c;
+
 		if (vc->vc_num != fg_console)
 			break;
 		switch (c) {
-- 
2.17.1

