Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB136849
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 01:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFEXod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 19:44:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFEXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:44:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so210298pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGZHkET7ircbdI4+qsEOTZZ3N7wqYFaIsKw134Y8zSg=;
        b=D/budo1PK18/IqefI0C+NDDtMB6Kq021s90lMxfG8mkD3QwgRZ3SpWJjeoeyjcMAjq
         qj7bZAPDW4RBkBNoGzwBg/d+5lm1QxrxIQBdze1XX4ZXAiZUxfn1h2CyqZwPUeYH+nd8
         XXZeeT5ys/4udAedP7+XQAEsiArU4JVoXlzOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGZHkET7ircbdI4+qsEOTZZ3N7wqYFaIsKw134Y8zSg=;
        b=P7QFxh2S44WGDagcU9Bg/b5tLBCs0+U4TCADI7ps+NKJcMBgCJWC02m/5yrDciGWg5
         6aazLcfboSucXjAAjawpHJaZUnuPjIQDxVCiRroD4h9NlWN6X2uvcph0qrqBLvP1ou+w
         j0jSMauQu0Ofph5xu8Goa7Mc//kc1v/f93pZaS1xUtmhk85ZOtzRI82h5Nv3zaqhid5b
         Vsy+rZpeRcftdAS8yeWu0rVcOoLNMRf8JSbvbICVjlb8GYnR3mD8nOZD+k1xvwMYnkbI
         Q+A6BsJPDnahczYmbuTdlFKwOOsR4BbI1IcOZ+VCDKPp47PhO9gp3zk8fdBJfZftCSbH
         dpKA==
X-Gm-Message-State: APjAAAVdAMf9rANhQDVURn0LB6yAmdouVivi8EKkiDDOUy7Yv0w2Jiqn
        6ywnPFpiMpOYjeXqC8S1T9OKLQ==
X-Google-Smtp-Source: APXvYqxFOCt0W56XzBova1UQmMRH+3FDeIu1QrMrvbTscJCf2fyKPmERQgzHuiUrdAh9B1tYQgUDGQ==
X-Received: by 2002:a63:5443:: with SMTP id e3mr408680pgm.265.1559778270052;
        Wed, 05 Jun 2019 16:44:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id ce3sm104736pjb.11.2019.06.05.16.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:44:29 -0700 (PDT)
From:   davidriley@chromium.org
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Riley <davidriley@chromium.org>
Subject: [PATCH 2/4] drm/virtio: Wake up all waiters when capset response comes in.
Date:   Wed,  5 Jun 2019 16:44:21 -0700
Message-Id: <20190605234423.11348-2-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Riley <davidriley@chromium.org>

If multiple callers occur simultaneously, wake them all up.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e62fe24b1a2e..da71568adb9a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -588,7 +588,7 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 		}
 	}
 	spin_unlock(&vgdev->display_info_lock);
-	wake_up(&vgdev->resp_wq);
+	wake_up_all(&vgdev->resp_wq);
 }
 
 static int virtio_get_edid_block(void *data, u8 *buf,
-- 
2.22.0.rc1.311.g5d7573a151-goog

