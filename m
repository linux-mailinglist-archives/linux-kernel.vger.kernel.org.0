Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C487F122B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEBTrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 15:47:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38917 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:47:22 -0400
Received: by mail-io1-f65.google.com with SMTP id m7so1009423ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kN2LIb+QfrL8sIiIPydwyFeqIMx0USBkBKWhvSqCdeo=;
        b=JwM5v2d9KH7VGzJ73U1rGQ4UATz/oHxS5kXnZhwrTaLmE1qGi4HM6fQMJFl6+fg8+f
         92982zb09pcP8df/GXCtdec5nuHNPGqEAK8S4U8/BfmmRKHEZvFfQETtmzsm3u2i+bu/
         nOsJYsbqOmEaNGQE3nLIjiSsecQB6aq7Ra65g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kN2LIb+QfrL8sIiIPydwyFeqIMx0USBkBKWhvSqCdeo=;
        b=mf2PZYtlJ5/2kYtUucXUhpTc3c6fAO3YF4l7bxRog8x6PN4MiJLNortNsMsQGe0ya5
         bPpUIpsDl5vgM9tVKBn62MGFS+5kMsE/ztkchvX6WoxulMTxNjCBN7hQX8LLnBac+ILw
         zRvPvPztIAFSOaAf0/zZ8Dz3RdElUi/netDst2LVbHuexAirpuH3QYOynMNZr3ILwdPq
         L8hZBQAwlK1vaehBiFmOSITI0VfAqllBTMAeXIOkEccuTWYnwHLtDx+nsqPEkXI7+xW0
         C4M0+hXUS7LkS2d8fVqMxwdD8U5KbxxNvyLKK4FDRaC7UD6QJuxRyPc8pXojvbJG/skD
         9fzg==
X-Gm-Message-State: APjAAAXb7ls3UZntcRMBd6YZ7DlKyZ8Lgk/c68WANmUEHmm3FJzq6kqe
        7mO9oy/jB6/KyYGrR/T5upLtrw==
X-Google-Smtp-Source: APXvYqxctf1vnpMemVTqvGRy5BaSsYuC0FjClI7ZmiBti3yUwRd5i+u7uLmhR6kGGiZYdqPHbA71iA==
X-Received: by 2002:a6b:5a0e:: with SMTP id o14mr3747821iob.213.1556826441504;
        Thu, 02 May 2019 12:47:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a124sm50177itc.18.2019.05.02.12.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:47:20 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_host: cleanup do_rebind() return path
Date:   Thu,  2 May 2019 13:47:18 -0600
Message-Id: <20190502194718.15256-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup do_rebind() return path and use common return path.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/stub_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index bf8a5feb0ee9..2e4bfccd4bfc 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -201,7 +201,7 @@ static DRIVER_ATTR_RW(match_busid);
 
 static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
 {
-	int ret;
+	int ret = 0;
 
 	/* device_attach() callers should hold parent lock for USB */
 	if (busid_priv->udev->dev.parent)
@@ -209,11 +209,9 @@ static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
 	ret = device_attach(&busid_priv->udev->dev);
 	if (busid_priv->udev->dev.parent)
 		device_unlock(busid_priv->udev->dev.parent);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&busid_priv->udev->dev, "rebind failed\n");
-		return ret;
-	}
-	return 0;
+	return ret;
 }
 
 static void stub_device_rebind(void)
-- 
2.17.1

