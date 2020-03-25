Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B587C1923B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCYJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 05:08:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCYJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:08:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so1909580wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVp8N3Y86PwDON5iNLeFPoqqE59j/nJ6HOnpicwvFYw=;
        b=b7M9444MjNBuwc+NdupdV9NJBwXQmDDARdLnAWQRPZCwEKEdoKmEkTMN6rTzkSq/Ev
         lA0tnWa51Jfc+72oCbnIyrp2Miipc74i4YZijLG7bRgYce7Wgf9kcUy0T96vgZvj8Y5x
         Pt+MKZX/HcMv27OjVADXuMnSaFlbxTxNv6fXGNarX2vX+DWos9GPnOn8U3QiTgXb43k8
         xZrRgAAunCi137t8E7cQOYrtgEI1EIxjkXRdQ18JbkhqQHhZtik6nWSHP/JYh6GVoHRX
         0TlR+cdjgoWhrD7oZ2sdk0fIZzoP72LORQ0OO2jBSBixFazDVHI59oLu3HQP1yk1z9OA
         nc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVp8N3Y86PwDON5iNLeFPoqqE59j/nJ6HOnpicwvFYw=;
        b=dqmFwnxMWK7CRG0OpxrjVs9x0odppV3hZPce54aklhKUqXdnq5O90Tc6tF8P4U0btd
         6OKxUtbKYHI16gfNxC3LHSnzPxxq7QAjwDMd8Rzpu/ov8wiBZoIhqxho+bdmBdnstIWC
         UAVV+IkKdZd2/op761jIEjuRE9OfReHAxwBCPqjEoPPTDX/xqU6DRsAfIc4pu1nDoSVy
         QckVNfbU0K3HMrDR6wTInB8D6VvpPokB5nYzvn2tz2KptdiP/lPBcj8NPCesH5yISKy1
         4F8hni8HEDKPlylxf1wKYgte1DUpSabYEeJ9iH1v5Vjgrt1R79kY1qbu7yCF9rLntGDu
         eKPQ==
X-Gm-Message-State: ANhLgQ3X5MxSPzAkY3nUiV9pWfLkLlOIHBHuzAQOTKHrhZQo/D4EDDy0
        gn+8qHNtLO2013Ab2u+Xt7Y=
X-Google-Smtp-Source: ADFU+vucVoFXg3vQHs7A87Ct1z694QEmqZDx6c7UlwYfcSJoaz4mdvAPRiSLD0uCfXOmBA7SN/BmpQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr2183980wrm.279.1585127323079;
        Wed, 25 Mar 2020 02:08:43 -0700 (PDT)
Received: from wasp.lan (250.128.208.46.dyn.plus.net. [46.208.128.250])
        by smtp.googlemail.com with ESMTPSA id 127sm8565048wmd.38.2020.03.25.02.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:08:42 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx-request@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bigbeeshane@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        mripard@kernel.org, airlied@linux.ie, David1.Zhou@amd.com
Subject: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user pages
Date:   Wed, 25 Mar 2020 09:07:41 +0000
Message-Id: <20200325090741.21957-4-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200325090741.21957-1-bigbeeshane@gmail.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to dma_map_sg may return segments / entries than requested
if they fall on page bounderies. The old implementation did not
support this use case.

Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 3b92311d30b9..b3380ffab4c2 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -528,7 +528,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 
 	r = -ENOMEM;
 	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents != ttm->sg->nents)
+	if (nents == 0)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-- 
2.26.0

