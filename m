Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731F81637D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBRX4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 18:56:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33701 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgBRX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:56:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so1084015pjs.0;
        Tue, 18 Feb 2020 15:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i3Cj6jCmg8Re6HCriaAPvQ8Bt49I/I/XDNaSdtPwqac=;
        b=iRujqTRISwGHP3FrC4HAQHsTqDffJ+OB/WFIZ8dqRIiGjwCWFYx4CFAxupO5MWnQXa
         d3rVvJuJ5l8SnEwqdviSYlBmdGgcTPNrJ+HoZjxBX3FD5N5KwNg6Uf6tqtQXnUncRDOq
         jLIj/xFZWknt1R9cPThVquMLLvfvrcYv2Uf7hJeZvSTPJhIDGCqxRfPs2bnTyR2epNpd
         UEgRa+bMcUOxFlXK1TxWRcNJZ4NPwbm3OoPBi0oKhBT+TiNY9TualZ12pSy/JimnF80b
         ZlgWdEDQin+GsFR91+qUeWx8iM7XRGb92vgjdn/oUQsUiZ2adrDA3p3WXLX9iW+rZHR0
         dbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i3Cj6jCmg8Re6HCriaAPvQ8Bt49I/I/XDNaSdtPwqac=;
        b=FRQzFCpqYEiCnXHg9HTotBPEN1y2qaehazZlIQ4cszIwbADVeGgEWqvte0wVOKVLt9
         9WM2cHyrneVOi0T0CpCIWJAVQDFkZgVX7tv3ltH9xIPVNSkGj3GjB+a/ZfeaNv6zyq8Q
         Zk3WXVWERbUTAMFcUHIAAzUOwZMn0J0ymSgq2M5sv20pJJhVCRBEF7dvRId7YmsfIKjJ
         XkPMn1196CjZECQOgZ4LXanW+MJ5C6Fo58DiTEVyqZ0AzYCal/U70ybDDjKWM06mBlhF
         jgwXe4QzuiuJFWTWDIWU+wqW9+dGqyDBRYuME7U3MIbYaN31A8fUbxfuL5dC6WccLVxp
         R/+w==
X-Gm-Message-State: APjAAAUmms9zEHpqZN1QJl+sDpbFi3rrLJrC+clFUBD0IRMqMpeqpe9e
        E9oUdJxwROOqJLnbFPAugpU/PWa5bhc=
X-Google-Smtp-Source: APXvYqwisrukoS6yd93rdtw5m0FL5P7Ha4WhyctQfgcrYnU5l7WoT8AAOrF4pDzWWvOMx6BXpKzm0Q==
X-Received: by 2002:a17:902:aa0b:: with SMTP id be11mr22317242plb.181.1582070172122;
        Tue, 18 Feb 2020 15:56:12 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::5:1718])
        by smtp.gmail.com with ESMTPSA id d3sm80558pjx.10.2020.02.18.15.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:56:11 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/2] usb: gadget: aspeed: fixup usb1 device descriptor at init time
Date:   Tue, 18 Feb 2020 15:56:00 -0800
Message-Id: <20200218235600.6763-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218235600.6763-1-rentao.bupt@gmail.com>
References: <20200218235600.6763-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch moves fixup-usb1-device-descriptor logic from get_descriptor
handler to "ast_vhub_fixup_dev_desc" function so the device descriptor
is only patched once (at vhub init time).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 4e3ef83283a6..b8bf54b12adc 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -76,13 +76,6 @@ static struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bNumConfigurations	= 1,
 };
 
-/* Patches to the above when forcing USB1 mode */
-static void ast_vhub_patch_dev_desc_usb1(struct usb_device_descriptor *desc)
-{
-	desc->bcdUSB = cpu_to_le16(0x0100);
-	desc->bDeviceProtocol = 0;
-}
-
 /*
  * Configuration descriptor: same comments as above
  * regarding handling USB1 mode.
@@ -316,10 +309,6 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 	if (len > dsize)
 		len = dsize;
 
-	/* Patch it if forcing USB1 */
-	if (desc_type == USB_DT_DEVICE && ep->vhub->force_usb1)
-		ast_vhub_patch_dev_desc_usb1(ep->buf);
-
 	/* Shoot it from the EP buffer */
 	return ast_vhub_reply(ep, NULL, len);
 }
@@ -878,6 +867,15 @@ static void ast_vhub_fixup_dev_desc(struct ast_vhub *vhub)
 		if (of_str[id])
 			ast_vhub_str_array[i].s = of_str[id];
 	}
+
+	/*
+	 * Update USB Release Number and Protocol code if vhub is running
+	 * at USB 1.x speed.
+	 */
+	if (vhub->force_usb1) {
+		ast_vhub_dev_desc.bcdUSB = cpu_to_le16(0x0100);
+		ast_vhub_dev_desc.bDeviceProtocol = 0;
+	}
 }
 
 void ast_vhub_init_hub(struct ast_vhub *vhub)
-- 
2.17.1

