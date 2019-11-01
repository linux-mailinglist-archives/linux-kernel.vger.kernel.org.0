Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54532ECA87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKAVtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 17:49:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37115 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:49:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so12110535qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZRXOfCkDmbQwzCISueAd+Ee+dZ/XgL8g6yvVaK0HEk=;
        b=VtECGWAYmAgHh809vWPORt9NEntfwNpVsMgB0GsJLCUiDrG2fR7ttFlYizoeMWxrKa
         151etwuDqGi0fPOtVUtF3rwpc+3ZVN5ko3UALyVZ0eFlAytqKHSlmUvWPjzpGIjCvVTk
         LfQEtmq49mMblA3C1Qou3Zvc7w4/oup1yP+Rn443dOp1e3X/PKh4M6E1rpwNtoNYDP3o
         p9hJXg04jrqExuGZPGI1FPKMbQOgJQfGxo7zUjiWzBq2A72ONh6yN2+cCi7JxGBQudMd
         IgkXdgCDvsHfgtVPiRFBRTO9CBu0rD81aY8wDXpvOS9zxL39rlQpX65O+ZLz4335X04S
         CotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZRXOfCkDmbQwzCISueAd+Ee+dZ/XgL8g6yvVaK0HEk=;
        b=XJf35H3lRZscNDKKIZ9rEmn5OM2Q8ZpzcrO8G6feaAAaBTOHvYDO+YNMnfnDPooC2x
         /zOKr4EZPA6A4MV39nLjHMILMl93ZOe4jqXX69MYPlIIR4ZUZ4+C514YyJjGN3ha0pYb
         Clk9RC7DFPt5X8P0UQ78F0MvUHxJpoUi2AN5ukt5HaApsK8Kz+6M5i4i6vAo1Zhebn1Y
         d8AHhfmDXUBRMl9Y/05W0ek2tARZ9gEhJ9Lv7WHSmi8kK9DguTCKd45DbWijvPAZ1kUN
         BJO4YiqckMTYAvOLUL7cpVJxTcf9rAPeYr6ZLoS9W+LoD57VWDRsDsOBHtwMe4eqppnR
         Tu9g==
X-Gm-Message-State: APjAAAVxBzuZQDhZOYnEC2Sof10l4QbmCCOXk+pYjSUEw6HuGkF27SF9
        R6SQas/PxhqBjOIzVnMBtCg=
X-Google-Smtp-Source: APXvYqx0SrL2i9tPsPunuyTY/WLdRVfHllsiDntoDA5pM8CyTIe7JPi13cVHHHhgPWFVcLRPuFLktQ==
X-Received: by 2002:a37:490c:: with SMTP id w12mr2661454qka.101.1572644946513;
        Fri, 01 Nov 2019 14:49:06 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-84-14.wifi.ic.unicamp.br. [177.220.84.14])
        by smtp.gmail.com with ESMTPSA id w24sm5482300qta.44.2019.11.01.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:49:05 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 VKMS 2/2] drm/vkms: Changing a 'Todo' to a 'TODO' in code comment
Date:   Fri,  1 Nov 2019 18:48:48 -0300
Message-Id: <20191101214848.7574-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
References: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the task introduction for the word 'TODO'. With the TODO word all
in uppercase, as is the standard, it's easier to find the tasks that have
to be done throughout the code.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 88890ddfc4bd..4af2f19480f4 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -54,7 +54,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
  * at vaddr_dst using buffer's metadata to locate the new values
  * from vaddr_src and their destination at vaddr_dst.
  *
- * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
+ * TODO: Use the alpha value to blend vaddr_src with vaddr_dst
  *	 instead of overwriting it.
  */
 static void blend(void *vaddr_dst, void *vaddr_src,
-- 
2.20.1

