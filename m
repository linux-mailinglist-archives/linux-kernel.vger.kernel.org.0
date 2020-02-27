Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB741716BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgB0MEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:04:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbgB0MEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:04:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so3005529wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RmVYnpM+0YRA6Cv2NCMoJPgFkzlEM1UmxN/+rA46XY=;
        b=eYp7pK095FWJZ22AF506/TxhHaBaOUrk6NBpcrFHMd7Q1CeGnht2M2Isss9iDeLBI8
         KL4fsGDE/euAxYh219pEjWMbkE1Xs7EKw5PSlShRq+Hf9AknfRpZQnInkBNGXTvhnX0J
         mLEnA01NnD/XNycEpdVZUJ08nsV4RU5aau8gTJmldLpHI5WtXFKFhf/SODX3oTnDnTN/
         UaEi/uF1vqwYto5JhGKr3gAajyyCrRqEIZZmeaclxt2e9imBYcWPbVlWopXp/2so0qWV
         UUPdH843sXBS99qT6Hi0/+ohXETPvMXjPWoOAENdeQWrVVWDXQmAyMPS306mgfOmtl5d
         277Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RmVYnpM+0YRA6Cv2NCMoJPgFkzlEM1UmxN/+rA46XY=;
        b=bMygfIB8TUdub/CE19p/ZyriHwWAA3Mydvr36gcHPV7yGJhgXvAFOhc1L9/H88VOZp
         uqRJogkwUZjySP6h78kTg3cP5JE2B+2LeTEBLoli6mpB7PO+uhD2lhc9TRipAUvSUhYt
         cCPFlmmuzH5lPYih6s0w6NzsXovEvGBwU4DFSn9NRI9Mw7nVA+TyIi7oZE43jpGr08Wx
         C8STVjyHX4BlhuOdJ/uuxPMAONtRCAOg+zbyoGWYHe33+aMfpTZbLLzvmNT86F0wqvYD
         bATNLO6qLH6dmPadTqWE65qLOHqQH9Hw1wlU7KfgFE6Ihs35rfnXBvmRjNhLgUVgOSng
         CB8g==
X-Gm-Message-State: APjAAAU+7KEw3ny++FthUYIQx2XTAke3pd3/D1KDNIfDgKm2/NIukPUf
        9xch/par9wITH5YMPtmUs6Y=
X-Google-Smtp-Source: APXvYqz4WeZdLGhzPJnokepnWxHo1W+4oAupLckaGCVy2TSEI09yxz0Zdl8ZBaoACC7g6gyM+DcRQQ==
X-Received: by 2002:a5d:424e:: with SMTP id s14mr4834741wrr.226.1582805042932;
        Thu, 27 Feb 2020 04:04:02 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:04:02 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/21] drm/arm: have malidp_debufs_init() return void
Date:   Thu, 27 Feb 2020 15:02:32 +0300
Message-Id: <20200227120232.19413-22-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there's no need for the return value in malidp_debugfs_init() after
the conversion of the drm_driver.debugfs_init() hook, (drm: convert the
.debugs_init() hook to return void), convert the malidp_debugfs_init()
function to return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 37d92a06318e..def8c9ffafca 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -548,7 +548,7 @@ static const struct file_operations malidp_debugfs_fops = {
 	.release = single_release,
 };
 
-static int malidp_debugfs_init(struct drm_minor *minor)
+static void malidp_debugfs_init(struct drm_minor *minor)
 {
 	struct malidp_drm *malidp = minor->dev->dev_private;
 
@@ -557,7 +557,6 @@ static int malidp_debugfs_init(struct drm_minor *minor)
 	spin_lock_init(&malidp->errors_lock);
 	debugfs_create_file("debug", S_IRUGO | S_IWUSR, minor->debugfs_root,
 			    minor->dev, &malidp_debugfs_fops);
-	return 0;
 }
 
 #endif //CONFIG_DEBUG_FS
-- 
2.25.0

