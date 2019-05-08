Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FF17DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfEHQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 12:09:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43662 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfEHQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id r3so13952985qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6sWye7vOcqRkubQDg1bib3x5zX/fJ7sX+bA/ddrNzA=;
        b=M9DbqMXxsg6gdTcr3U6UYjS/8AXwuGbum9KW43E8enhwhN1H0R5dv36jT64MH1xlWn
         bcKWLzSz0TFNkp040TyCh4dmg6sICaj9MHCNvjo7tH10V+mOko2YalfhimHEEr5lQ551
         jYgviwwt1Xormlt8X/oCX8rlNDoV5axtAngv1yTI4yxA6CCHULqXzk6VCsZNt+jMvjo8
         b5ZbTy2A5txbryGq03OaJ84/GrnC+TzgfQmnSmVMoo0UvSncJ9184Z4svXZaSyNFZhQG
         SXWVhrT/7bzya61fb34B6gJH8oAJtKuZCw/kNrN77nS2w1HR9qSuA9W7/iLAiq+oAqgd
         Gv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6sWye7vOcqRkubQDg1bib3x5zX/fJ7sX+bA/ddrNzA=;
        b=NYulBlU9sIYGeS8raCSRHQlEWC1O6v1lPHzgJ9v3sHu9CahYKE81oydVzQqvRzvHxg
         lMBU/ekZYM0wu4oHjy1YUgknvBWLviunVE+yrQyNTMOaMETIc12fuklZu7qe0qTmmVTF
         ZDaJNDir4dNcbmZqT7ZUNVpOJaKCDWbaQFtiWK9C4vbWl8vF7wnZoIQvKv3mhq7T5J06
         M7f5uOzAIBHiz1IN1oJehSf8BWt+CEPhSTGCm4PCXm8+AGFnWYOGl0qleUmZILVsc/hr
         yx5mB+dk1tYmgNq9dyCYFezo8glbUU5b7OmOHrL/tM3yuxXprfI6ZCiNVt6fgzHcXqGA
         zpug==
X-Gm-Message-State: APjAAAXTBCtZJXj08uCCJ3zyXI5yk4TSMoSpbvUXTiValJdrWHwADMdv
        /6KPllK/2k5GSGoQKmCPDIGn8w==
X-Google-Smtp-Source: APXvYqwo6mxDALGKSuzORSfL9rLrjWhNGfhiAJ5bnQe25PUPvfxNdfqYZfXg96kvP4i3gn/wsHozSQ==
X-Received: by 2002:ac8:2e74:: with SMTP id s49mr13218772qta.23.1557331777544;
        Wed, 08 May 2019 09:09:37 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:37 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] drm/rockchip: Check for fast link training before enabling psr
Date:   Wed,  8 May 2019 12:09:12 -0400
Message-Id: <20190508160920.144739-8-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508160920.144739-1-sean@poorly.run>
References: <20190508160920.144739-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Once we start shutting off the link during PSR, we're going to want fast
training to work. If the display doesn't support fast training, don't
enable psr.

Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-3-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-2-sean@poorly.run
Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-9-sean@poorly.run

Cc: Zain Wang <wzz@rock-chips.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 225f5e5dd69b..af34554a5a02 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1040,16 +1040,17 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	if (ret)
 		return ret;
 
+	/* Check whether panel supports fast training */
+	ret = analogix_dp_fast_link_train_detection(dp);
+	if (ret)
+		dp->psr_enable = false;
+
 	if (dp->psr_enable) {
 		ret = analogix_dp_enable_sink_psr(dp);
 		if (ret)
 			return ret;
 	}
 
-	/* Check whether panel supports fast training */
-	ret =  analogix_dp_fast_link_train_detection(dp);
-	if (ret)
-		dp->psr_enable = false;
 
 	return ret;
 }
-- 
Sean Paul, Software Engineer, Google / Chromium OS

