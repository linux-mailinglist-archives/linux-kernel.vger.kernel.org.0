Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0157B99C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfGaGYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 02:24:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36477 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfGaGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:24:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so30030614plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qPNDXgZPeD/yc67o95C8RuRDptaWT4TdPlrwZmzPvAk=;
        b=InbuIdvwP3Y4gywzK0Nf+ECkQVeMzVN3Sv0btkVQFK76yx4gxApm3XQaG3b8xnC+mv
         VdbRiNEOCdmiQVWEI+5/wQ+vJfgfJFc0QvctI70OhP8jETrKN/Dk/+Y5XCFavYlmmzzF
         obmNJY6nOr29lkInsWfdKDWYfrSidiyAXs2JlhdwJnuSRyvtHYT1g6ps7PD+UrFhZb4a
         w932/xzIvt4PQVaSYiDrm2/c8WWNT6/Z54mz/kPKTyQLi+TdLrFZf+KuSb5QCgIUutUW
         BkHryJsBJE4/si7kvVsyK409c/7VnlAi3AuSf84+Xi06x8HHhqkXubZ9eSTZvtjpYNoz
         3gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qPNDXgZPeD/yc67o95C8RuRDptaWT4TdPlrwZmzPvAk=;
        b=Jpp6/5ac13LUOY8pPGxVqDCe4Uo+jbO7bqOnv5eOOvJUqwGhHomNEVftoucUDDjKN8
         Uy/srQeMDyBoMOGhD7iahHDhzdX9bYzE5SWtnCUsMgzEA6ZpkcIh1TLipgfLTw4j/k65
         k0QkFJcliD6f+TkvPFlyNCipULxuzZl8oa9vzpgmg3rFdTy5sHviXUpd3PyDodWMebzI
         BoBdzMYG6zymKMJ36IJmF9daVNxo6yzL+X8hExtB9znfqJGI4XOmgizma4Tkq5dv0n21
         CUiDliw3kS0ugNxCRHBD6r6mxQF+zeYoNWycC0UmFxNpO7kTTnRnJy8ECw1Zxp4c1tww
         EZMQ==
X-Gm-Message-State: APjAAAW9DAiW2GpJ9zLX7VlMkYPkDT0uXogkQMYTeNlxmVMODgN9qU8g
        BqCBLoBcyaH6UjEQNrOzmOM=
X-Google-Smtp-Source: APXvYqzDwdOaw51aou0XSnvwMPV94XYKJT1ktYDuiPl4gKkVyLYHDIMgCkcdcKASoo3qADpbxc7ZYA==
X-Received: by 2002:a17:902:7407:: with SMTP id g7mr120158084pll.214.1564554282501;
        Tue, 30 Jul 2019 23:24:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 11sm67552871pfw.33.2019.07.30.23.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 23:24:42 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2] drm: use trace_printk rather than printk in drm_dbg.
Date:   Wed, 31 Jul 2019 14:24:16 +0800
Message-Id: <20190731062416.26238-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
finally calls printk.
As amdgpu_ih_process is called from an interrupt handler,
and interrupt handler should be short as possible.

As printk may lead to bogging down the system or can even
create a live lock. printk should not be used in IRQ context.
Instead, trace_printk is recommended in IRQ context.
Link: https://lwn.net/Articles/365835

Reviewed-by: Joe Perches <joe@perches.com> 
Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Only make the interrupt uses the trace_printk to avoid
    all 4000+ drm_dbg/DRM_DEBUG uses emitting a trace_printk.

 drivers/gpu/drm/drm_print.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index a17c8a14dba4..747835d16fa6 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -236,9 +236,13 @@ void drm_dbg(unsigned int category, const char *format, ...)
 	vaf.fmt = format;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
-	       __builtin_return_address(0), &vaf);
-
+	if (in_interrupt()) {
+		trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+		       __builtin_return_address(0), &vaf);
+	} else {
+		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+		       __builtin_return_address(0), &vaf);
+	}
 	va_end(args);
 }
 EXPORT_SYMBOL(drm_dbg);
-- 
2.11.0

