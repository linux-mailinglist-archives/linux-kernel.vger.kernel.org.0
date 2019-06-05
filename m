Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F536714
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFEVx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 17:53:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38312 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFEVx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:53:56 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so5970692itk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I2SsjTdzTZEHUxAqiggwpUY+KXh/NOOkKtPa/yMzz0=;
        b=Co8iNK2a9A1fNqnfONf4EZtCkxCEMeflTY2RgMj5UAeX9iBMblNROUhk/7PG5sexsy
         nzG8Fv98QGykA6+rriBwqbVy0rVOOi2ziZ4kvB/jgrCQYuBIWbfiynEYLodGKBM3FuJM
         PlZIpqTQTTlpQ5Fnt2KEEwU8Sawk5YWXX4AcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I2SsjTdzTZEHUxAqiggwpUY+KXh/NOOkKtPa/yMzz0=;
        b=Qak0KowDu1mmlqprWA/uBIrfzUfI9uA6RXnLAZ6foX49EpUQNFlQvijBxv1JwRiuPS
         +G/KJlI62DatBoF1z1svVba4BHfC4c0vOBJBlH/UqV6BwWBygPv/8J8uY8sdIIO5vIEB
         UK/P9Lvg53+tRC9Vx9NRmRhyfIqG7hcp+7W9xMaD8nX6E9jMaMAyX7kB8vuo4I7uY61P
         GK/ueCVobhI8z2EXQv8T6yZk0f3ij7MwHtl2KFqB6VElDrxKCvrNHdTF2TiVLsCFZYb9
         dHp2npNUKhyq8w3/4Jxy6A3J+rbzY1JLlZlcIV1Qxs6ipdSeB3vkkTgstpm/XsXvvCpo
         UUXw==
X-Gm-Message-State: APjAAAXjXSY2jLUpFsw6Wa0IglSw2H76sJFiBil7nqqvippJGTxs1YWe
        MZ0krMDXaUfrcmdFgrUifaKArA==
X-Google-Smtp-Source: APXvYqwo7/OmYdJk0f03BI8THXymBnnjXZ7LNUkEWfH3fKkYbTpt+yceqV3Fqxxri7hGr//wJpjDVw==
X-Received: by 2002:a02:aa0d:: with SMTP id r13mr22403757jam.129.1559771635752;
        Wed, 05 Jun 2019 14:53:55 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e127sm37484ite.33.2019.06.05.14.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:53:55 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, ezequiel@collabora.com,
        paul.kocialkowski@bootlin.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: v4l2-core: fix uninitialized variable error
Date:   Wed,  5 Jun 2019 15:53:48 -0600
Message-Id: <d0d1cd16f3995d8c22a5a4a0d2018482cb739354.1559764506.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1559764506.git.skhan@linuxfoundation.org>
References: <cover.1559764506.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following cppcheck error:

Checking drivers/media/v4l2-core/v4l2-ioctl.c ...
Checking drivers/media/v4l2-core/v4l2-ioctl.c: CONFIG_VIDEO_ADV_DEBUG...
[drivers/media/v4l2-core/v4l2-ioctl.c:2470]: (error) Uninitialized variable: sd

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 333e387bafeb..205addb949ce 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2445,7 +2445,7 @@ static int v4l_dbg_g_chip_info(const struct v4l2_ioctl_ops *ops,
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	struct video_device *vfd = video_devdata(file);
 	struct v4l2_dbg_chip_info *p = arg;
-	struct v4l2_subdev *sd;
+	struct v4l2_subdev *sd = NULL;
 	int idx = 0;
 
 	switch (p->match.type) {
-- 
2.17.1

