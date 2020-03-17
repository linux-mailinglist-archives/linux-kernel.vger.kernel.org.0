Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4C1882A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCQL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 07:57:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43642 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:57:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so820067pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=reLOWOkyOr/OEERg8SMjO4vQQYztbY0LPaW1Ag7Mvu0=;
        b=a5dL+3hZYsRgN+XL4RosZQPVyQLcy0j1su9Kf57V6u2Jr/P3sqGGhHYMIWlZv3oIxF
         ztkVNkJhzj/t8Ru4sXhR0EvUpnx0W6rGsUGJyS22tr3oGpybjDfSlAwLNMT07FKcGPx5
         gQP/ymAfjCI1/QEnZdEqDRx2MBdhJhGm5gU8YpiNj2lQw0dUYhggrlbrtaCUgOPRAD5P
         HxMfha+m+rLlO223wfXTmat4mLe4LZMQLtE+k7wQZcIBMIu5IpeYh7o+M4Os3Nm2hIo7
         54gmj3aPVEPKNuPumepEG6kl4kMGKz4qS1rwIM7Pn9NA4D+vx79sLBh1Rd3l2fjYPnaO
         p75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=reLOWOkyOr/OEERg8SMjO4vQQYztbY0LPaW1Ag7Mvu0=;
        b=s3pFshTYGMyf9Od4EoVcnZA6SPi98TLoJJFlT3gRUNFwtIwCHRxLBDyJDUVEbOnW8r
         Yd/p/6JB137N3izEfwZh+I0TOYGuCB/6VTiSIyo5PUHSTNdrZXna67hUTa7LfwUEjWJr
         FRXVfJavc9Tr9P/c3Ngtp3mSI80YcljHIcXSHrOZ/0sYsTNzzsr9vWsa3MMRf7UkrOdH
         SYRbMJh1KW91Ek52Gv8tIdz30p88oMpxwufqWx28KTllrlGsRs66I4HKDxgVJn8lyO+6
         WagwSPr5w1AP+CcHGoXSoNVQ77mTmoFuUbIfMNoafNl2gxdh/pKZlEKlwwT0FUXVtiH0
         ecew==
X-Gm-Message-State: ANhLgQ2+G9hSDcr+ULO11CzR0tNHQ4t0Z4OkRTpiBQtM116CnfaHcGWD
        fO1e+8Fu+eQ+17SYPutpQlc=
X-Google-Smtp-Source: ADFU+vsonZ4VgH7OBfq/2iUoI9YURQEAVqgFARtnFAPYb/E8KAYpc3AGx2SzdldWShrappeNUHCsMA==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr4561213pgk.96.1584446218828;
        Tue, 17 Mar 2020 04:56:58 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id 8sm3129051pfv.65.2020.03.17.04.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 04:56:58 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] drm/amd/powerplay: remove redundant check in smu_set_soft_freq_range
Date:   Tue, 17 Mar 2020 19:56:53 +0800
Message-Id: <20200317115653.9463-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

min(max) is type of uint32_t, min < 0(max < 0) is never true.
move it.

Addressed-Coverity: ("Unsigned compared against 0")
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 96e81c7bc266..fdaea0cc2828 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -222,9 +222,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 {
 	int ret = 0;
 
-	if (min < 0 && max < 0)
-		return -EINVAL;
-
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
-- 
2.17.1

