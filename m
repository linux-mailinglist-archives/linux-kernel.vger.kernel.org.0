Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E623276475
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfGZL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 07:28:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45219 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfGZL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so51068760lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k2Hu9dgPAg4mXrYLegY3cs+pkVK6DYl+EmmNBVrs0g=;
        b=t8y9cuVI9+Yw19d8Lc6hWctxqxTCLkf+u1eC14W4J2NPPlqR5niIOpj/3Z6d0OtM/Y
         rTbYPQ30898Z1Dawsea0lsSoS6sks+mGr6HRiwT8DeDLpqq0wygMq3vzAhZkRDBZqFjq
         O9senNIWyuA3TPlYmPwaIcePkNEFE/HGREu5sjatKCeOvylXVwqKi8UUwcs9GUJLLq1A
         Fptqlzm0mzopq4E/Zvr2lhTDMd/AGFjNBofA/0xovrBZvfGsH7NK7MICsPtiDdXKjs1E
         94HbESg/f9jtKEfzdKW3WRLDb/O2lypJ6taEfpAfmSVV0Zyvo3KJ1rnuwIqFitDzz/n0
         gCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k2Hu9dgPAg4mXrYLegY3cs+pkVK6DYl+EmmNBVrs0g=;
        b=RAPflS0XlD9vq/O4Qgi6HclDdYNsqhsdimPQDaUkf4Qe8dvnQydw4pJt72+Ol3cO1C
         SpkdtF7JBndEO4b+tGPUx3VQSnDKhV6Thms8lIyYWzFvvoAb7TpOuRqe0JAcpclWWAH9
         c4vyAN6x0EDF7wmhQc+D3/Ga47wIHlgQYwGoe9FJ72Ss9Q/pZ+Rqiio6A5TFps5e/1jq
         aTVyK3EECUkzqZ7yokMLqVhRxNl+a8oaMfSCD2rOOQhj0bTI5+gxgHe1aodhMAhKCHwZ
         fEabbq1B+CJNFBvZ7Bz6Nyfy7ZW03WxVze1znn2zKVT83I58gvWkznK4pIykHaRan+Nw
         DLqw==
X-Gm-Message-State: APjAAAX12VWtnhW08qzdTjzSOJh0UAB5BWSljavJysuiY7sQ1mAmu5Fs
        GjbDAPgYCdW6IJSQFt3Nkn2+tA==
X-Google-Smtp-Source: APXvYqw+KmhWFJ1zRECph4WisbngzrlfWOBHrpPa5lKCQnCIAhc96KBxovwxIYgG7Y9bz3Q2OIIhRw==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr50119116ljw.13.1564140521750;
        Fri, 26 Jul 2019 04:28:41 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id m28sm9918367ljb.68.2019.07.26.04.28.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:41 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] video: fbdev: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:35 +0200
Message-Id: <20190726112835.19928-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warnings
was starting to show up:

../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   info->fix.ypanstep = 2;
   ~~~~~~~~~~~~~~~~~~~^~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
  case V4L2_PIX_FMT_NV16:
  ^~~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   info->fix.ypanstep = 2;
   ~~~~~~~~~~~~~~~~~~~^~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
  case V4L2_PIX_FMT_NV16:
  ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index ac0bcac9a865..c249763dbf0b 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1594,6 +1594,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+		/* Fall through */
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
@@ -2084,6 +2085,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+		/* Fall through */
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
-- 
2.20.1

