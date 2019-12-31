Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5A12D6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 09:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfLaINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 03:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLaINP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:13:15 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973C0206DA;
        Tue, 31 Dec 2019 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577779995;
        bh=hfE39/Gv5Iwa6G47MWrgKyKEeO72OE9CD+IYD/ghGHU=;
        h=From:To:Cc:Subject:Date:From;
        b=yMbRBU93KkBocrvNgb3slVR1y+1ZNxeWj4pms4RkCJFCJY7YmCT0tReba7JpEq+4P
         xtj5lYZ2FoIeor0WnuWCY1yxuS95xMH74jmZVMnEkMMiWp6VkDS6/lM6m7ub8mm2YP
         J2wMCnjbX8oFWwbIRelRjOhiBIY94Rpz+oHLLA7E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] drm/rockchip: Add missing vmalloc header
Date:   Tue, 31 Dec 2019 09:12:36 +0100
Message-Id: <1577779956-7612-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockship DRM GEM code uses vmap()/vunmap() so vmalloc header must be
included to avoid warnings like (on IA64, compile tested):

    drivers/gpu/drm/rockchip/rockchip_drm_gem.c: In function ‘rockchip_gem_alloc_iommu’:
    drivers/gpu/drm/rockchip/rockchip_drm_gem.c:134:20: error:
        implicit declaration of function ‘vmap’ [-Werror=implicit-function-declaration]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 7582d0e6a60a..0d1884684dcb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -6,6 +6,7 @@
 
 #include <linux/dma-buf.h>
 #include <linux/iommu.h>
+#include <linux/vmalloc.h>
 
 #include <drm/drm.h>
 #include <drm/drm_gem.h>
-- 
2.7.4

