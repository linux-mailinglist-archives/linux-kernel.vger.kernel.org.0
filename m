Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FF105311
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKUN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbfKUN3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:35 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E188020708;
        Thu, 21 Nov 2019 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342975;
        bh=0aOPNq5lXI55EI7T6Z/U8tjiPKHmWfdsWlLmyY7a3Rs=;
        h=From:To:Cc:Subject:Date:From;
        b=vZ/TGfN092xHxItzh1k40rwiwOfUH8RR41oFZrUozW73w3jkMOB3rXuCRdOAIfZsf
         tZHj0xy3DLTiYeAppfN2UI574SG+rSkdRLCthqDlTkUbg4VhY2htsgnKfHHrdCyp08
         SNHZoCZPyj8TdNLeMi5hNX454ZyZqJdCZsiCsVeg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:30 +0800
Message-Id: <20191121132930.29544-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/amd/acp/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kconfig
index d968c2471412..19bae9100da4 100644
--- a/drivers/gpu/drm/amd/acp/Kconfig
+++ b/drivers/gpu/drm/amd/acp/Kconfig
@@ -2,11 +2,11 @@
 menu "ACP (Audio CoProcessor) Configuration"
 
 config DRM_AMD_ACP
-       bool "Enable AMD Audio CoProcessor IP support"
-       depends on DRM_AMDGPU
-       select MFD_CORE
-       select PM_GENERIC_DOMAINS if PM
-       help
+	bool "Enable AMD Audio CoProcessor IP support"
+	depends on DRM_AMDGPU
+	select MFD_CORE
+	select PM_GENERIC_DOMAINS if PM
+	help
 	Choose this option to enable ACP IP support for AMD SOCs.
 	This adds the ACP (Audio CoProcessor) IP driver and wires
 	it up into the amdgpu driver.  The ACP block provides the DMA
-- 
2.17.1

