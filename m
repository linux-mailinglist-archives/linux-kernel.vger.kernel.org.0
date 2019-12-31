Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768D712DBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLaU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 15:57:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 15:57:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so35978656edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/L0UDpnttYF4BqWVkxCJIlx3yMpKiM8ZTy0/08IBArQ=;
        b=QksdBBrjGEgK9wuUn1CisFauT6ltKaiIeSdhWC5YXyRot6/jzbcbbYtUu/70RF+xti
         nCyTghD7/hpqOweTC7VYhL6uYudRBFLBJ8KYgGZKmETJYqrgLo5rwJ2FjqrhWMEtGZYB
         VvSgVX6KyEU/6R8p+Q6IbLHP9ejsMfQfm4Mul3OYe0GngEikiWDVxJDtbcT8jq9fs3/Q
         jlQ0l5WZr3qeSJfk1WVlx0dwH5SdUeFmwCowEs3NIV7MFCXiFhHqCpWE0ZsNeAyIaNOA
         PQqqd4r/wTJ1/dvlTtOPozBZeQFvBDI+cr7HMCnMkHWCJdQCDP9v05oCe95pp3v6X7Wo
         QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/L0UDpnttYF4BqWVkxCJIlx3yMpKiM8ZTy0/08IBArQ=;
        b=By1LLJAkNeM7eMMQ2MJ0eiIGqFy7zkb2c/EYYbrS7XE7wvRjyUQ3W1CB8bSKBT6bK0
         wun4QZdheyqHTOgEc/dqGTtQFWGe3aFF8qZmCvjH9uYUmikzbybuuIoC85B4ER/Bc9hn
         WcXHly1Y8TkVf6gG2+HUapzKjECE/WjBRGSxkQGfa5fB1hSB6+CSRDsadjRWJco2PfCh
         6fJvgUvgz3+IzYVjm3bkGtnXNP4RPp1GtgWkvxI+qYDvX/N+G006rIXuayvYzNhBUgPu
         ORwIfuAEgiKrpvn7Hxx566lOvcuzbZDGwwa4gOk8QnVoNhkrbQ4ELtLS+tXJAmkZm23X
         uypA==
X-Gm-Message-State: APjAAAW/HHn0zXBI+k/KZ95oIFlcLsJ12ylUej+b/FD7OHSPc8PuanmN
        jctW6COKDAgSc5Qdx8dHXxM=
X-Google-Smtp-Source: APXvYqzHOV8xpOMmY6pgT4CHyziZ4IY9SHUbXafxJvwikQKUKZw/R+cByu8fvnA9nN3kliR7j6BW5A==
X-Received: by 2002:a50:ef17:: with SMTP id m23mr77217345eds.106.1577825858489;
        Tue, 31 Dec 2019 12:57:38 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id u23sm6035905edq.74.2019.12.31.12.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 12:57:38 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: use NULL for pointer assignment.
Date:   Tue, 31 Dec 2019 23:57:34 +0300
Message-Id: <20191231205734.1452-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of 0 in the pointer assignment with NULL to address the
following sparse warning:
drivers/gpu/drm/nouveau/nouveau_hwmon.c:744:29: warning: Using plain integer as NULL pointer

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index d445c6f3fece..1c3104d20571 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -741,7 +741,7 @@ nouveau_hwmon_init(struct drm_device *dev)
 			special_groups[i++] = &pwm_fan_sensor_group;
 	}
 
-	special_groups[i] = 0;
+	special_groups[i] = NULL;
 	hwmon_dev = hwmon_device_register_with_info(dev->dev, "nouveau", dev,
 							&nouveau_chip_info,
 							special_groups);
-- 
2.17.1

