Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358DE122D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEBTue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 15:50:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33416 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEBTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so991778qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZ54H5MP9upabrXqeLSqzX5B4e3SolToSymz2mrIX3g=;
        b=FsXqbJVv4RjRteYBjM0Eb+VX1/TtUdDikLizo73Bi9HiCMSOPFuAufT/n4Q0GOm+oL
         dx0vzWr1cd1TEJGqPMZnYqb2oMzIYKMj/ePX5r8SghQTOSPT4N/agsp3wwhIJDf1rrj+
         HSs+0UXs+k+LvehE+GG37RleWXUrjqHccmPQTzz4S0I59L6RTJhajKsH0qVTMC3sEd/i
         HlMdfkhfl0YrZkiUpk0wFgaHpm/8edFw4g3PRGazWh7UiQmMW5QeH1BQrN4kg8TBjVHF
         ygoZsBxt0bMRDzc4xnb5VWFy4ktlZ0nOtmNp54zZnkBMrV3XFQahq1cRPXt0kZRog3gn
         t47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ54H5MP9upabrXqeLSqzX5B4e3SolToSymz2mrIX3g=;
        b=gNjR3jzX1a+GhaciRLedKVupIQ+8poGcdUib4W063VXiO+PsgnTCVcm984Judtg0x+
         snNKRUqRv79dNAoUqBFgcILHI6iEL0w6sYG9uO370hGpqN5DL9aPMO/iU+tdzPwpkGZ8
         ELghp84lP+JmQIdIy04FHCi4JEaOS+w3lW5VxLpAGCWko5QDMagCrpbZ8yjbZ4WHw9jh
         GngV5NS3FBViua/Etyv5qUF0we9mxB82DHcMS+8S8ZgBC1bhXn9qTxPR4y4b1DGQ82wD
         3L2cp7WvmC9wCOPHoOoq6rKo9y1MoB8h+72sNSxCEhvIQ4lmKOseqwFdmtfN7o3ZlE2s
         V5CQ==
X-Gm-Message-State: APjAAAXKxrLTGqsr69PaOhHeLEaY6ZcVyH10VG5AFr6bNCRCHV5PhLF2
        euU7dM3PeA6HiUynyBETCeV/fg==
X-Google-Smtp-Source: APXvYqwAd8mPI1Y2X3nRzth4DBaEKIcYqgIeuz6v1B3p53DHZ6z1xy8o5RlN/aCWFGrWOEYwFDn/1w==
X-Received: by 2002:a0c:d1ad:: with SMTP id e42mr4626493qvh.208.1556826630783;
        Thu, 02 May 2019 12:50:30 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:30 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] drm/rockchip: Check for fast link training before enabling psr
Date:   Thu,  2 May 2019 15:49:49 -0400
Message-Id: <20190502194956.218441-8-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190502194956.218441-1-sean@poorly.run>
References: <20190502194956.218441-1-sean@poorly.run>
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

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-3-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-2-sean@poorly.run

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

