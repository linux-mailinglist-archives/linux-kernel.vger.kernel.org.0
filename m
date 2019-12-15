Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E713811FAD0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfLOTnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 14:43:50 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36260 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:43:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47bZb93zFYz9vYVX
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NfC1-1CpMHG6 for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 13:43:49 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47bZb92plnz9vYVj
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 13:43:49 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id y188so3087177ywa.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzUVfiEDZWnnZ8iTI733utxeYaoLpIiip1KoZGu7VT0=;
        b=fQT5U401aqJdtyEC3PeaqB8M1c9gazre6yrbix1n3u84kw0WobKU+W0kQm50sncgaM
         ui9X/Jue0JRBKrEjayU78aedygD8tYhaTLHoaauTs+h4W3MabLiJq5eV8DghyA+Nv3Ca
         osGouTl5sH9bAYp5w1Tz8RISjxkuJDXjxOr+mGKuwmX5D7ugmFjWRnMYX16qt7iImkSz
         AeYLd8xRzh9yUiLGAg0yI9+6UauGwDz+QpjlQFOxxwtuv2Afq5FowA1MT7ayA/XAahgd
         Whp+BRGVgO65scHHeX+DtRhu04WMBdHaTQ8Ocz3fb3LMZqKyEcjpzeqW0cNWptrXOvgf
         4FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzUVfiEDZWnnZ8iTI733utxeYaoLpIiip1KoZGu7VT0=;
        b=f6APrTsCO+GRHRiZmpV5Ita+YZGiiJurSvNCxPJMU8lJCWiFTJIhXns13mVF/XphUa
         watChflvF3gkT0xIueq1slHTCbLTqjGBqajznuakrSDK4qTZU7dXZwRf2CLOsIapopXp
         uBGZPl8MPdI6jF8oQGdnTO3A9TIMrz6h/o0jgl56NWuljciQff+6N1qm19eV90OHr2eJ
         O2dz9sTcSU1awH3NSanPGV7dVO8Nkh6AgLnIth5UL54B1+4a6KPve/56pgluQA7K/sap
         6hEBYCYkzCnplItWV49dqAbzCKFrpQmYFKgCG5SdCh6udSlZav8jitgbf/3gJwp55AYt
         YRQA==
X-Gm-Message-State: APjAAAXpq/vbY2WX43pkl+FvXOL4T3i01UykD/9QC3nTpLiq/fqyy4kc
        6Sfl/Y0k+bl0LqYUoWhKE9RvZdgql6uMHOrQQ38jdIzctqw2WH8TX+/PtPohL0v4x837geItN1g
        sbjh2wEjZvO+hU3ynf6HkyAIuEtkC
X-Received: by 2002:a0d:f585:: with SMTP id e127mr17247497ywf.155.1576439028878;
        Sun, 15 Dec 2019 11:43:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwh+uZ2y7jBdt0l8mdoCQ5qrh/XYRpRcorJY+Fip/K20Q5s1zWb0E1EsZQV/zWoIBzmlmKfow==
X-Received: by 2002:a0d:f585:: with SMTP id e127mr17247484ywf.155.1576439028663;
        Sun, 15 Dec 2019 11:43:48 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g29sm7441920ywk.31.2019.12.15.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:43:48 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: remove duplicate check on parent and avoid BUG_ON
Date:   Sun, 15 Dec 2019 13:43:44 -0600
Message-Id: <20191215194345.4679-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_dev_init, parent is checked for NULL via assert after
checked in devm_drm_dev_init(). The patch removes the duplicate
check and replaces the assertion with WARN_ON. Further, it returns
-EINVAL consistent with the usage in devm_drm_dev_init.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/drm_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 1b9b40a1c7c9..7c18a980cd4b 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -622,7 +622,8 @@ int drm_dev_init(struct drm_device *dev,
 		return -ENODEV;
 	}
 
-	BUG_ON(!parent);
+	if (WARN_ON(!parent))
+		return -EINVAL;
 
 	kref_init(&dev->ref);
 	dev->dev = get_device(parent);
@@ -725,7 +726,7 @@ int devm_drm_dev_init(struct device *parent,
 {
 	int ret;
 
-	if (WARN_ON(!parent || !driver->release))
+	if (WARN_ON(!driver->release))
 		return -EINVAL;
 
 	ret = drm_dev_init(dev, driver, parent);
-- 
2.20.1

