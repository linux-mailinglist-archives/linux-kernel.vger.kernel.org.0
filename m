Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8711F90E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLOQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 11:35:32 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:44046 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLOQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:35:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bVPv4VQ6z9vYfQ
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 927-zLuvbqkw for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 10:35:31 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bVPv3M0jz9vYfL
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:35:31 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id y188so2834476ywa.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtqtAENkikt2OwSsUAKI6q95l8UgBNbet4mLKXhPLPc=;
        b=gASw7z/I0SjFUTMduO0mrbXnhtLKxXhWkOF1hA/NCG12Ch6gDZFEqMnbJIwzzEPoou
         +xH47X1jCoab581xt65AVJdaT3JqBWycPK5jVlQq0+xGLTyro0BNAy6T6oB1/wt/dles
         ag7qhX3VwtoyqJFRO+djy8VltI5NtuvPH+NoE3e2pZl1gm9KBPs0tNtqIYIV9YV+iP7j
         BHNwjeLz35FgXSkYJz0vrOhsE/tvHIKDsss25zHf4nVDcqCbzb7gM6ATSy0cbmgug3Q2
         XTlMUOK0GYYiGZRDWz5Esl0NS0AozgZJ4ge0Ve6AbtJCcyVVNp8l9cAL4TZxrmk86wn2
         VLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtqtAENkikt2OwSsUAKI6q95l8UgBNbet4mLKXhPLPc=;
        b=HmjJ4V7jgk4DL53OCh/hvo3VEip2XJc0Nafj/WxmKjO019S5FfGFhZmzp5R+OxG6xl
         3eQAGxfPkkhgFUVnEJ5ihOtDKIC2dvJud3Zt+4qGeeq/E/K5q9ZPegrQ4ePbVipQ+c4r
         w+D1DRTNozL0uwisGXe2mzYTx2r6Ux2JCLPxxDt2bkCiKJTe2DgU95l07DIlswdOETsS
         Sy/ArTehh2BBaVhp0p7hanXo+DcQXxpkEI7K5fv53AdI6Q7pgi7mPk8lyu4BTBXPqyQn
         olhbXKQVuxaemJCbxNdUkxpZdfU2k0sR85aWHTFr/TmTQaTbbxWaOsUwm7cwfX2LpS0j
         yliw==
X-Gm-Message-State: APjAAAV4TCp0NuSaj0P1+W7jA1ISf4vFPXg0cvOgc+0Fiwk0NKQ+OQau
        n9OiKlJeJCuE/nkQVr8dVc1nwJYFYOCm6jZISEzU7XrlH4cgi2+qhRo4ZoTe4R8/pL96Zaa3aiQ
        3bL8kaGRU8fUQbJwkqiANhFi8jrs9
X-Received: by 2002:a0d:cc4c:: with SMTP id o73mr16970362ywd.482.1576427730955;
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz926INkyG4z0GFI/Np7oPSQT09p97e6twIqiathpPSkhQbrht1R/pRTZ9FNegpZbKOIIU6sA==
X-Received: by 2002:a0d:cc4c:: with SMTP id o73mr16970343ywd.482.1576427730693;
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y9sm7261560ywc.19.2019.12.15.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: Avoid calling BUG() when object_map is not empty
Date:   Sun, 15 Dec 2019 10:35:27 -0600
Message-Id: <20191215163527.25203-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __rbd_object_map_load, if object_map contains data, return
error -EINVAL upstream, instead of crashing, via BUG. The patch
fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b184563cd32..6e9a11f32a94 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1892,7 +1892,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	int num_pages;
 	int ret;
 
-	rbd_assert(!rbd_dev->object_map && !rbd_dev->object_map_size);
+	if (rbd_dev->object_map || rbd_dev->object_map_size)
+		return -EINVAL;
 
 	num_objects = ceph_get_num_objects(&rbd_dev->layout,
 					   rbd_dev->mapping.size);
-- 
2.20.1

