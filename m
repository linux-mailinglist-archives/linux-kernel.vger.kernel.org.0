Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD658153FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 09:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgBFIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 03:00:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41090 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBFIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so5913196wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtslodQDEgXVqwkRyzhRJwkNpBKdcN9adctiuwwsFK8=;
        b=L2eh/AIBOBoKs36wZcHz11fiAzDq43Pw5ipKiDecgQk0nUl4LJXxiJgW5Th9GcN8Q/
         Fwcv7yWWB4izr5HU6W8vJUxyq2v7Xj3m18/0FOyFe4WrqdfWt8dUTV89zVEbNqvfuhrQ
         E/XftoPiQIoPbwAnxtxs5rMoriBakauNmguh++s7rzxpXXwyCVfgZshsET0r13cEyYSQ
         EOGm1MRdILvq9vTNbRIYPNukonPHKmnDUTGi93SdDze7E7vrWj2hj6lBPayvRf47N9Rz
         9Zm3b7jagJvKZ2h5bI+HwhOqIx7pHEo4HULiOgd0dAF2kkXT94gt11ZKpAZWdezeQ7os
         wEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtslodQDEgXVqwkRyzhRJwkNpBKdcN9adctiuwwsFK8=;
        b=E+w83CvQsVT6YYYUeVPTTVeocl+d+LNaXHmqloP2ss5MJA4wNhqDHeGtuOj/HJvuIy
         jGvlrQWi9EGHirK8YiFWwECRPVQSFXUMxxJ4UWmfQHxM6WipEuwTNmLJ+NlLV02uEf8f
         99h317zoHA1RcDBWgxW0wWAfzEpTnHpU8ZlxBreKR/sF+5i8bfwyi1y2aDJRPDQ0EHEJ
         ts++kF65gbwmv/jZ4INyHnMqEZn20cQsKsHvoay1OgjvSZTVvCIT9Ej3CMcJhZeW7wWK
         MwgatFVvpWkZNDxekn1x0wlQ8FQPOPUsoV8/S7+lGsAgH67FMnBHo5gcXWIMbTrVDDC3
         1avw==
X-Gm-Message-State: APjAAAUCdZCThrqzBTsEHiZNtywwL+SNgayNTyUAckoD1R1TZeH97ZDE
        Aw8LG/ZZMEAzMpFuT4QUyhs=
X-Google-Smtp-Source: APXvYqwDE7CXTSG41Mvy/SDmIG5GoVxXXbsRfzAgT7Ei4QFwQqUh8jZSYyR6y3F/XUt/gspchMN/LQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr2360719wrm.356.1580976039303;
        Thu, 06 Feb 2020 00:00:39 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:38 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] drm/i915/color: conversion to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:05 +0300
Message-Id: <20200206080014.13759-5-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial conversion of the straightforward printk based logging macros to
the struct drm_device based logging macros in
i915/display/intel_color.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 2087a1852486..d44bd8287801 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1192,7 +1192,8 @@ static int check_luts(const struct intel_crtc_state *crtc_state)
 
 	/* C8 relies on its palette being stored in the legacy LUT */
 	if (crtc_state->c8_planes) {
-		DRM_DEBUG_KMS("C8 pixelformat requires the legacy LUT\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "C8 pixelformat requires the legacy LUT\n");
 		return -EINVAL;
 	}
 
-- 
2.25.0

