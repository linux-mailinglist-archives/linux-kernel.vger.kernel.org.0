Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636D5823E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfHERVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 13:21:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42183 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHERVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:21:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so36773129plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0FCyF18aUxWJ9+t/F+A4A3WWkl75FHwlH6+LVDGD7ag=;
        b=ABgb8foKstHmdhUxms2DovOOlq0l6QUHJViGEydEwgLscdMO/d4R5xr24wgG/b9Njb
         xcKnwHC2tWjjn2mJyhoWkeOHQ3ODIWTHIyEDBM4eB00Pv+pliKAu7ayOLNZwIC+Gs4EX
         MjlZplzIDkpfxHvd9xRqJNj/UdO0FSfBx2aAdloj0JJNctBGZS1i/x0Vt7VRK2Ir8Mxa
         5myOML+3JiGBgtsmTTY70Q+/lnpKX0AXLikbOrV5WXB7z16A/o/vWOGkVcS9AAkVxqDy
         8eAof8yxGaWtroJLaC/BDtTLRLdGYSsLunmoJl3+j09won7gc8CIyIVC9fphSkNdgGtP
         yc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0FCyF18aUxWJ9+t/F+A4A3WWkl75FHwlH6+LVDGD7ag=;
        b=qUkMxpuF/vIoIGMQq5u3BM3PMnEQTjlabsKJVIvSBJEjwpHApujzQQlayoKkZmOdUf
         sO3dWbtJg0WlwpQuZQjo0tmem8Kuipvmb38mo+KwysPdSqLaiE2vntNuoUT7dcDYaWOy
         EnKfGxtaCLOTOZrA3lbT2H68GYQgduddMJt2HZYp3oVfe7bMLWJPgZgEMzyMekXU1Bau
         +3QV/jBTOI+d2uUxtnrSITWRKWs0iYPdT0FHzU+rXxI6OhofjUryW7G3sLHmWyiSFkFm
         JyXnNiIRhT29Ng9LUPHbBAXh0jTuQ52zfChwJLFHVdaS6kbNv/kP988rgIO9hXoTDgm6
         T5IA==
X-Gm-Message-State: APjAAAWC0g1449wuNE5eakyb99qvMofBzIqhy5RHyijhxa2bfnoP8NU3
        FLRg022WUe1j9309qK/pLZE=
X-Google-Smtp-Source: APXvYqwIV0N1dyFjX7btKHmWvmn/Ut5d5y1exafohtGaYFcDrT2pwhL9Hwn9FlvYtNxUNgd7qo9Ozg==
X-Received: by 2002:a17:902:b28b:: with SMTP id u11mr138820204plr.11.1565025706185;
        Mon, 05 Aug 2019 10:21:46 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id a1sm51451703pgh.61.2019.08.05.10.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:21:44 -0700 (PDT)
Date:   Mon, 5 Aug 2019 22:51:38 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: amd: powerplay: Remove logically dead code
Message-ID: <20190805172138.GA4534@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Result of pointer airthmentic is never null

fix coverity defect:1451876

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ee739c0..a3acd77 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -736,8 +736,6 @@ static int smu_v11_0_write_watermarks_table(struct smu_context *smu)
 	struct smu_table *table = NULL;
 
 	table = &smu_table->tables[SMU_TABLE_WATERMARKS];
-	if (!table)
-		return -EINVAL;
 
 	if (!table->cpu_addr)
 		return -EINVAL;
-- 
2.7.4

