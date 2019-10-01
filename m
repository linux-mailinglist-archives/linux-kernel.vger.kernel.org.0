Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23D1C30E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfJAKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:05:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:05:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2526520wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MDb9V236X1+2wHmiAI972wYH+mIXz1A27mj3ckuSylc=;
        b=dRz45ZFY/schW2hdmyXXNc3wJcAsEVReWhJjUlkPT3gXsJwjTVpueT54F3hg02bn9r
         hdmLfZCJhrsE8tww83KORRm7Q3/S9bgaKD4/XB9pfXX2o1G5Jv0XepvCxjQNh+oIeAPb
         CDCjNL7BYGMbzctAo1ekCSB8gw/hPyrY8S5hCKceSF1+Vyzo3rEzzyWO676Q+EYBCjxP
         pdtd5+vEI3sImuzydVEe7hRfjcoz0d7lVv3nVo3CJtoeUylWEFhPAd1qjueaFTHSrpxk
         ktzfG4awi8Pa7yCqVvfiLNgS29xhWjsv/cRdRCvq1GyXkfhh2XTQzr2eboOAOjyTWO2J
         VkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MDb9V236X1+2wHmiAI972wYH+mIXz1A27mj3ckuSylc=;
        b=JRH7s8aAc70+wI7EO7XOU8/xps6IUCnZD7MH7QWgjcHolboA9T3OLjwHiwh5xzsUl4
         qwJgXDzyiTqXW57b76+7/gFWmVDuOmS2gGafzsmXqw897TFlTDoOt39EYBVQ13gvljla
         BJLbkhA1gFDd+W32J8QayfEjE1ATAgM4AyU858pl0e4gHY8A3oWVOuv1SGrVM9vJHQ8A
         YZf4gY20cEmj4RFIjfg/3fCGke/rvOhd+uYQrS0uztcdsgFYKLWcjxuGW+16k5pAD1Uz
         qzZcBKUK7N+IXCYwDMQEgh9z7ehXnLxUFZtHLmbJ3MAcGIYtnr4KGKmd8mu2x4eTB7tz
         bE/Q==
X-Gm-Message-State: APjAAAW4TvMB3W/BqEN5rrDewYvRX9sTSNX9DM9901xe2+j41LhLzBke
        YKPYGXS6694nmMIY2dXn85OHjix5eqQ=
X-Google-Smtp-Source: APXvYqw/rjLK3L8BZATVfqRz06QNfAaTJW8lK7seOMEM3ex/HDidB5Ngszz5C/Uh3mwqJXGp46yxIw==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr3006333wme.105.1569924316278;
        Tue, 01 Oct 2019 03:05:16 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id j1sm34277253wrg.24.2019.10.01.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 03:05:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] mtd: st_spi_fsm: remove unused field from struct stfsm
Date:   Tue,  1 Oct 2019 12:05:10 +0200
Message-Id: <20191001100510.13962-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The 'region' field in struct stfsm is unused and can be removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- fixed the commit message: it now says field instead of variable

 drivers/mtd/devices/st_spi_fsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index f4d1667daaf9..1888523d9745 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -255,7 +255,6 @@ struct stfsm_seq {
 struct stfsm {
 	struct device		*dev;
 	void __iomem		*base;
-	struct resource		*region;
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct flash_info       *info;
-- 
2.23.0

