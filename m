Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23187F5DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 08:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKIHy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 02:54:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34759 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 02:54:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id k7so5348142pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 23:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veiAcMlIgcLHjJxd0QNhUHza9s431ffRaEJpWcEHXlA=;
        b=ZrcVhD0E25ufPrmCCfZ8MdFHm7QQe97Zw1uyYMICsTUBdeTTZku7sXrCkCp00Y8WTj
         ssQNLd0wY4j5kVeBQOlyt+J8HxJQUV2+ZycfVCAFWt7NyqBsvWB60WV5wR8rfkQ2VY2N
         0K8O05POwFRF8UJTOljz9j40NxSX5E+k/TK+lMU7/7BG+Vfszm9WfoA7Kd13lSB/6FiK
         lOOu0ERBepCRgVwSyr/vXyegHkDjSp5ve0mC23B5Ju5n21ilfXQILL7E5RNlxV5IHaoC
         y95+fHo5YQQJQAT9NgMuHZ3tNSjwcx/qcRUnusSjy3QvTQpKL3rs+v2rC60U/EZI5Ozg
         4njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veiAcMlIgcLHjJxd0QNhUHza9s431ffRaEJpWcEHXlA=;
        b=seaEHwpTUb9RpSlej97W2wHEl+py7TqRtjPNIMyI48+kzxeR+4X0pkqafEVqaYqIXK
         Af9e9pz11cP0FRRTh+yCn8VVB2L1ANc90Ieme88CLnnpRq8SQKE2uQZrDXMK57SeGBi3
         l4+BcXwn0ay0VwzaYzYwcW2Z0yxSxr2BD+OGOfDNYrxpEdCGNmt+nGn2vbNcEvqE4y5Y
         Ceeq674c5uwF/+L386ioac8ACkstHuc91R5as7KHQudOOIFGCgClsAcJLd8b/jHwdLSR
         WbvldHyqu9XhVNK6hLLIAj0W/zTofQcdsJ2x6bXCmG6sUKarXJ2fN9QaHP8Hb+k2N0Rm
         8HEA==
X-Gm-Message-State: APjAAAVIJtrEvVE3yRKOzemdGdhpT0oXjBVZs2oYuOStDmDRp2mzZsrL
        CmRdVvmzFTEcKKeZmtwEAPw=
X-Google-Smtp-Source: APXvYqxvItN9OnqheTvov4hpS8eX99Ly+f08T42CJNk7Az9Z5y+C87MbZqWmuka9RwkjJGMYYz+pvw==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr14901704plk.135.1573286068169;
        Fri, 08 Nov 2019 23:54:28 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y1sm9578671pfq.138.2019.11.08.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 23:54:27 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/virtgpu: fix double unregistration
Date:   Sat,  9 Nov 2019 15:54:17 +0800
Message-Id: <20191109075417.29808-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_put_dev also calls drm_dev_unregister, so dev will be unregistered
twice.
Replace it with drm_dev_put to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0fc32fa0b3c0..fccc24e21af8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -138,7 +138,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 
 	drm_dev_unregister(dev);
 	virtio_gpu_deinit(dev);
-	drm_put_dev(dev);
+	drm_dev_put(dev);
 }
 
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
-- 
2.23.0

