Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78291DD71A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJSHYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 03:24:41 -0400
Received: from h3.fbrelay.privateemail.com ([131.153.2.44]:44232 "EHLO
        h3.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfJSHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:24:41 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2019 03:24:40 EDT
Received: from MTA-10-4.privateemail.com (mta-10.privateemail.com [68.65.122.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 33DFE80843
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 03:24:40 -0400 (EDT)
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
        by MTA-10.privateemail.com (Postfix) with ESMTP id 2144160038;
        Sat, 19 Oct 2019 03:24:39 -0400 (EDT)
Received: from wambui.zuku.co.ke (unknown [10.20.151.221])
        by MTA-10.privateemail.com (Postfix) with ESMTPA id A45FA60033;
        Sat, 19 Oct 2019 07:24:35 +0000 (UTC)
From:   Wambui Karuga <wambui@karuga.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm/amd/amdgpu: make undeclared variables static
Date:   Sat, 19 Oct 2019 10:24:26 +0300
Message-Id: <20191019072426.20535-1-wambui@karuga.xyz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the `amdgpu_lockup_timeout` and `amdgpu_exp_hw_support` variables
static to remove the following sparse warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:103:19: warning: symbol 'amdgpu_lockup_timeout' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:117:18: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?

Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3fae1007143e..c5b3c0c9193b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
 int amdgpu_hw_i2c = 0;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
-char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
@@ -114,7 +114,7 @@ int amdgpu_vm_block_size = -1;
 int amdgpu_vm_fault_stop = 0;
 int amdgpu_vm_debug = 0;
 int amdgpu_vm_update_mode = -1;
-int amdgpu_exp_hw_support = 0;
+static int amdgpu_exp_hw_support;
 int amdgpu_dc = -1;
 int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
-- 
2.23.0

