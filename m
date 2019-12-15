Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9F11FABB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfLOTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 14:21:39 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51400 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:21:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47bZ5Y2WMsz9vYVX
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ONH_mUIW0FTK for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 13:21:37 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47bZ5Y1D6xz9vYVj
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 13:21:37 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id l8so77119ybm.22
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vHOqiJl20VaJGpwJ/DttRyIXYs0oZzT4qiDHtKALOA=;
        b=XwkLQ/E+DIobu7olpQXcCUCO7xgWE16Wa+sqh198+1y2rWLsbgYeAtZPo4ATxLWAqT
         T8vWLEWjUe4KqkXBKyC+62kbzFkuOtkxer4fq23IUHJbGAQDj64DFtHm+kpNe2oxX208
         e0dQ2BD9rXOPFMFn+1qabFkqPlI6WfG901cX3YmXLLUpviJ2C1BobnEpvHhM1iUMTriA
         Y3KHs/XW6wbjL24W84XLn/BzdiuXAtj0vjMQOW9Q6frQFA9uX5oRnLOXXf5v0Bas8ABO
         llFVO7zrOHwm8kcPgz+6hu9y73wBkNIJ5L00KdVC3M6VfX8KW6MHmKm9A3W7UEqpOfWo
         RW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vHOqiJl20VaJGpwJ/DttRyIXYs0oZzT4qiDHtKALOA=;
        b=DN/fXSCbPn9VtD4Py7XBr1U0kQJgNf5iBTSEqTQwlaYIBpWKbLORGS9yI/pDk3ezB6
         52yzW87UbmcR9SQY+ZXv/BsAkUL64frUAqts9SXu8rdJU55fBKm28mVShZRv7mTfzZdw
         Gvsd1EKSZ0gbCUfrQ16v3xxIqpT1WrVRO5WSszNNw92oLLkT8ITk8xMcpTkIkKuRcGdp
         aaiAzIjCAbHeB4U0TOALf8eqtbgM9CSZa/69AO7nBxhhosK30OhhHWwcmWbKAftb5rRu
         mp/NKKeTjDigshNoZPW8CxPDsbF2zvyF/bsleemS8Z4fqyeQRk2UKgfrBK5Lm5v8P/NZ
         fd7w==
X-Gm-Message-State: APjAAAV4LCNn3wMPBpMifzaQODK+n/TQ+bZl9tc/h1WboZ2p1An3/Khx
        u5hpRl6E5r1AzQtvPa3QjEJpYu/PBuy/oNA/GdyUaqj0iLGfZ+V6++IV+j6szQrQHgxJXoagGe/
        Itu9CQJGTD4vsSAF1KIZjVDMV47AU
X-Received: by 2002:a25:ca03:: with SMTP id a3mr16801066ybg.326.1576437696609;
        Sun, 15 Dec 2019 11:21:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaR6yQwrbYT3Z38wr+UIe4edmcqRkTgpqg+r4yw4b+9er5V3fIAM9v8isICn729UCWrJAffw==
X-Received: by 2002:a25:ca03:: with SMTP id a3mr16801054ybg.326.1576437696352;
        Sun, 15 Dec 2019 11:21:36 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id a12sm7488523ywa.95.2019.12.15.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:21:36 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7146: Avoid using BUG_ON as an assertion
Date:   Sun, 15 Dec 2019 13:21:33 -0600
Message-Id: <20191215192133.3765-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In video_begin and video_end, saa7146_format_by_fourcc can return
NULL and is checked via BUG_ON. However, by returning the error
to the callers upstream, we can avoid the crash and handle it via
recovery code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/common/saa7146/saa7146_video.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_video.c b/drivers/media/common/saa7146/saa7146_video.c
index d16122039b0c..1b6b5d43ad3e 100644
--- a/drivers/media/common/saa7146/saa7146_video.c
+++ b/drivers/media/common/saa7146/saa7146_video.c
@@ -345,7 +345,8 @@ static int video_begin(struct saa7146_fh *fh)
 
 	fmt = saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
 	/* we need to have a valid format set here */
-	BUG_ON(NULL == fmt);
+	if (NULL == fmt)
+		return -EINVAL;
 
 	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
 		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
@@ -398,7 +399,8 @@ static int video_end(struct saa7146_fh *fh, struct file *file)
 
 	fmt = saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
 	/* we need to have a valid format set here */
-	BUG_ON(NULL == fmt);
+	if (NULL == fmt)
+		return -EINVAL;
 
 	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
 		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
-- 
2.20.1

