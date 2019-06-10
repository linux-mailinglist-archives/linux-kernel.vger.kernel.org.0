Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C03BE40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbfFJVSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 17:18:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38021 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfFJVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:18:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so4139858plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWLAT9NRUlrvBrwvfr/QvssLLaOWbMrJHilGpaJk6Vg=;
        b=BTzCAwo8NHk+PHsfqTl2EKRbG/LlCt1ISxn+UsNbzk38J68Eg/Mk2VTGW55dB5oXjA
         XIhFJ4r7p/+0R5+GQoR+EfDPsQMC6lPpPTAx6o0dks7q+pOjNdAs5/Izn17m7TOcluBx
         hsV9CQJVZjpaUFYHgo07Z55lsL5rHeKj9BY5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWLAT9NRUlrvBrwvfr/QvssLLaOWbMrJHilGpaJk6Vg=;
        b=Duj+DOma2mgkhxZhh1rx7ABmDw2wPhCYn3M8JTF3aN9XSrNXT2/37VgZ/ABOXD9RmX
         PpAw7H0DwkYmb+G1KGp5vkwV2x7cjk/tdjvntdrQrTnKcpWF/MFRp39G14/LBai1YBKG
         vjNKSdfvqfUZ/JG5IoqEkCydlhRNUGH4t2jjoqVZO+rVnXsGl8rbeKmNX25RJYn8VAIk
         h7DrVOeehZeu474rgUk4MdRu5EhdQzrymwDRtVuRx50qCcp/TwMeosdSMfKiU+6qdNOZ
         foSSaySvialiuO1IjCcYUh/R8xJ/g9kRGhNl2WS62TuPIucsbiRd2sIegS73Eg8XoP+B
         FXYQ==
X-Gm-Message-State: APjAAAWQeuDnUPXFi+xybw3bTTRU5vRoZPvsjTZ0lZIlpg1uDPgAVyP7
        N+ptnBZEPzxKCFsQoG0cnuW0nQ==
X-Google-Smtp-Source: APXvYqwfPRIJrAHffgJVE/PjgxqqcuAjPPWZKIHoej5vh8l1LwNLGrzjub7p09dUcEeYhj9/su30qw==
X-Received: by 2002:a17:902:a716:: with SMTP id w22mr72043801plq.270.1560201502923;
        Mon, 10 Jun 2019 14:18:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id y13sm14241062pfb.143.2019.06.10.14.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:18:22 -0700 (PDT)
From:   davidriley@chromium.org
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2 2/4] drm/virtio: Wake up all waiters when capset response comes in.
Date:   Mon, 10 Jun 2019 14:18:08 -0700
Message-Id: <20190610211810.253227-3-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
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
2.22.0.rc2.383.gf4fbbf30c2-goog

