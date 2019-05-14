Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B411CC61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfENQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 12:02:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44912 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:02:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so15506307otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fSlgTFf8KtNta0rz8mLnXIN4jROdf8xysWOhaMNIqEU=;
        b=L9fBlpGqioNOmCkpRrttVJlWrp0wN+k9YLzpMu3TCyxWwKwuMOSUIxOcQoirY8iWBn
         viwTYQJ/CEYk91rd87TzX91kvczkZ/gVat7F1NLQdS7yC9JLlHMb4g15VavvKWeRzTiU
         aPPZc/OQtewTBuA4NmxgyV8U45sViu1PJD6egI+K1mOD77SlGApQ14wz3se/bbBZtvxT
         GTLp+pc1O1mcvhyqRhtSBUzjkJ1RUGl/5nKLRflIpGfRvMqVNmh1n3wd4BVU0COJyw1l
         R2f7JjTS2SRmbMrQmE3YINq/uKjmt3odgA2Sh9JCE+T/Qa2zF/TOczLow0J1feB2aMjq
         5/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fSlgTFf8KtNta0rz8mLnXIN4jROdf8xysWOhaMNIqEU=;
        b=JMCOUqiUE44qEho/TKJWV9p8UWpS3KYWzG7nrw5TVpxZeN+v27+NmmeSFnQ6zsEwo+
         PaHvu2UUuDnw3Msh1EHmUbF3GXqvJf1b83kHjxzjXQvJDuopwSywa+61r20rGj9Rdpzt
         ondMdLm6+HG3y3xphk3bp8GRtH/kxhI2r4CDJqB6NLThUReCoyMnIuWXnlkiM40y4L7R
         vBmF1qOwf11s2c/KMzszBL6URh/Mi/ckHJRi4XO7KF3U6HtPpntBBr8URtHi73E05RoU
         Zu9qk2eOMLxuoFESz6djTQTUnBqq4GWpNHhFnNcy39vkEguEAhhKSqGZyTjMp22nNvCq
         S+mw==
X-Gm-Message-State: APjAAAV/EoFGCChrrmlZMOqNTx92KfhAEPciqfchan+vQdDD+PGck87w
        AO2sngnuV4gnGoiB0hFWasCSs1ZDG0Y+Tg==
X-Google-Smtp-Source: APXvYqwss0BQEuHxOP2EKdRXu7b8gJYo7DvkW8SNjwnJuhVOSUneVcogIiRmPHKex4Qqqzc22fHN7A==
X-Received: by 2002:a05:6830:1097:: with SMTP id y23mr188736oto.108.1557849733699;
        Tue, 14 May 2019 09:02:13 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:fc47:9acf:eddd:8a77])
        by smtp.gmail.com with ESMTPSA id m20sm6498783otq.30.2019.05.14.09.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 09:02:12 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: vc04_services: Fix kernel type 'u32' over 'uint32_t'
Date:   Tue, 14 May 2019 11:02:07 -0500
Message-Id: <20190514160207.11573-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning issued by checkpatch
Prefer kernel type 'u32' over 'uint32_t'

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
index d1c57edbe2b8..90793c9f9a0f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
@@ -309,7 +309,7 @@ struct mmal_msg_port_parameter_set {
 	u32 port_handle;      /* port */
 	u32 id;     /* Parameter ID  */
 	u32 size;      /* Parameter size */
-	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
+	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
 };
 
 struct mmal_msg_port_parameter_set_reply {
@@ -331,7 +331,7 @@ struct mmal_msg_port_parameter_get_reply {
 	u32 status;           /* Status of mmal_port_parameter_get call */
 	u32 id;     /* Parameter ID  */
 	u32 size;      /* Parameter size */
-	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
+	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
 };
 
 /* event messages */
-- 
2.17.1

