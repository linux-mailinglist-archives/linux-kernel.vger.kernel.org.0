Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4197D7148A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfGWJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 05:04:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfGWJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:04:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so19089188pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MPf9RPeL/uxC5UjVT4jE3NmOb5yj3FuUkeED/rFltg=;
        b=WTdR+4zSg2l9S1pE6t7RB0pIQF/RIKMKLRVj+cQQhJtxQ1dc3tgTJajHkR8H3x/oeT
         UbiRnyrUG4uTRpaZ+PCPpCoUbQlHPizh91A62hlAu9Y/v2gPPzwR9Cl68YGbOxdpAdB2
         /74R7z3VgVNteaZ/DXIqW6z9KTl6Jn92gQeRFbZKYSXgJLCa1l97aqupC3NkZvBh5HrE
         QqYbQmHAvo3YdTcIrfiYhcG2xipINklOi6ngh+xodXTnJUr1chs3h3Yx7+8HMVd2OnEq
         DTH60YLSud+5gvW7476A28VbTUnPdV8UuPAi5xftjtMS/r1U1e5+U+DfsePoBA/u+5y4
         RK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MPf9RPeL/uxC5UjVT4jE3NmOb5yj3FuUkeED/rFltg=;
        b=Epwx7AsMH0aZPAijV82AjmjRuZ5GLRAlH1szJyDERQQgdYbQmG7BRy9MXIL2n+rzpq
         fxGbNttHP9AV3vSweqcvqIQaf+3lILP2jsYpGSjaIi/yXR1cX/3CXtpPdYSG562i7aQE
         qXcmnFdQH6mcoV277zvOykj/vpq51WUxeocuCJM7B/G7arGPxw+VPispGumf3xDZKbB0
         z1sXoABYCJQvSfpVDHK8jp+Eye1tiAPY0uzXgSyZ9UzogcWywDOpUGoaPooOJU9Qw6B7
         QUdjZUWYQmoc3pfVB8tIFLGFTFf/yvcwrsY9eRvUkC5dgJ3SQYIDLIplxJFEG81CfzDU
         EUmA==
X-Gm-Message-State: APjAAAUz0cU4+7/xfE1y4Xxs8+b06qUXWwC4tZjN5tjXY7FtDM5Bxhcz
        tUpr+2yo7nEcOirWoz1D2uY=
X-Google-Smtp-Source: APXvYqz6OOtga1jDqVlvMDvoLUuC/Mk1Os5tfDXEr3aBcJR6B2AJwD7FkZYzlUkxOPanBqx9RrDDdQ==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr31719094pjr.116.1563872680802;
        Tue, 23 Jul 2019 02:04:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h11sm42713175pfn.120.2019.07.23.02.04.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:04:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/amd/display: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 17:04:22 +0800
Message-Id: <20190723090421.27532-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4a29f72334d0..524e1e19017e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2428,8 +2428,7 @@ static ssize_t s3_debug_store(struct device *device,
 {
 	int ret;
 	int s3_state;
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(device);
 	struct amdgpu_device *adev = drm_dev->dev_private;
 
 	ret = kstrtoint(buf, 0, &s3_state);
-- 
2.20.1

