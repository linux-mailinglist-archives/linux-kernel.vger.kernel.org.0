Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDDFE7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 23:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKOWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 17:34:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41343 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfKOWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so5617389plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1ouRyNa+k6U3bqzEPdoAfpCVsnWSnRUjkxZ+vQnSI0=;
        b=AkA2Dg+SrHTn4/EJ8QynEGN7oPoQ/Aw5fRHMyXpEW6Y6keS6gO6VdGp+FDJ81HaCck
         LfkmYzBp8QrNwaymjk9ee0qPdxlC88qX2CcJuOT+KoHhzb0ptMpflS2O2yk9g1xcwj+i
         OsUJI152IuEDboSfUp+G5xjZAwG1t7A0XU/A7qB4I1ptcuIK1x3v8NMEcAQoZZq4bi4E
         Be+sv3Xu57IO52n36rJiyMgg2w2e6EQhjAwLZeheDCHSoe140YiXAwaGdpXT8hHFrlti
         FWcDYu761P26xKgxM27ycYqxbciEuu1T6zlil6sWl1pcyhuIHyDlPl4vUH/r7fLTJUmm
         52MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1ouRyNa+k6U3bqzEPdoAfpCVsnWSnRUjkxZ+vQnSI0=;
        b=qlaDrbIXBxG8J1105GRXaShN616NHlzaAMd/lzAL8XC2XW1OVX8btuMGWMRxCRMvMz
         W3DeqM8qtzGN6L/UfNirE5IAtYCLigwN9bVo56AHg+tGRoQ1EZsL/Bh/FLHhLVn31VLr
         NzU/zeRnOybLgvaTgrBwDT99etao7KrlnEMRcD8Ta1WkMwPS7PSyoHm1OLxXmEWgT1ET
         uWkkDEe1mUn5rBPrcJSUVrQagSrVM3Yl1/hbFKmfkoa3l0nI+9DaLqZzBYbh2HwRClGT
         dyIh8ljifrkCkH3sJSZk1Ai6Uzofl0pYj3InEusthVDNFPobhWTXIp2YGgfmU/UaAzqA
         zb8w==
X-Gm-Message-State: APjAAAWD7G+OmUINkB6UOEiFojsaEWBM3L9Xoa4TCsXToFaxGEQgc0Qv
        tveiGwlztw6uiuCgD5ak41vRb0spSS4=
X-Google-Smtp-Source: APXvYqxC58jH+YVSM8IOmV0kV1VyZBdQVm7yePJM+Y2/BxjPAGsb3xhTH2/dY5iUX2I2iGcgQm94xQ==
X-Received: by 2002:a17:90a:9705:: with SMTP id x5mr22110495pjo.37.1573857254692;
        Fri, 15 Nov 2019 14:34:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:14 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 19/20] media: ov5640: fix framerate update
Date:   Fri, 15 Nov 2019 15:33:55 -0700
Message-Id: <20191115223356.27675-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

commit 0929983e49c81c1d413702cd9b83bb06c4a2555c upstream

Changing framerate right before streamon had no effect,
the new framerate value was taken into account only at
next streamon, fix this.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/media/i2c/ov5640.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index a3bbef682fb8..2023df14f828 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2572,8 +2572,6 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
 	if (frame_rate < 0)
 		frame_rate = OV5640_15_FPS;
 
-	sensor->current_fr = frame_rate;
-	sensor->frame_interval = fi->interval;
 	mode = ov5640_find_mode(sensor, frame_rate, mode->hact,
 				mode->vact, true);
 	if (!mode) {
@@ -2581,7 +2579,10 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
 		goto out;
 	}
 
-	if (mode != sensor->current_mode) {
+	if (mode != sensor->current_mode ||
+	    frame_rate != sensor->current_fr) {
+		sensor->current_fr = frame_rate;
+		sensor->frame_interval = fi->interval;
 		sensor->current_mode = mode;
 		sensor->pending_mode_change = true;
 	}
-- 
2.17.1

