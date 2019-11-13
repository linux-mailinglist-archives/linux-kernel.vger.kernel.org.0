Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0BBFB094
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:37:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfKMMhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:37:22 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2414F03F8CB951FDDDD;
        Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:10 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <Rex.Zhu@amd.com>,
        <evan.quan@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
Date:   Wed, 13 Nov 2019 20:44:27 +0800
Message-ID: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes various unrelated gcc '-Wunused-but-set-variable'
warnings.

yu kuai (7):
  drm/amdgpu: remove set but not used variable 'mc_shared_chmap' from
    'gfx_v6_0.c' and 'gfx_v7_0.c'
  drm/amdgpu: remove set but not used variable 'amdgpu_connector'
  drm/amdgpu: remove set but not used variable 'count'
  drm/amdgpu: remove set but not used variable 'invalid'
  drm/amdgpu: remove set but not used variable 'threshold'
  drm/amdgpu: remove set but not used variable 'state'
  drm/amdgpu: remove set but not used variable 'us_mvdd'

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c               |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c               |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c             |  4 ++--
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c  |  7 ++-----
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
 7 files changed, 8 insertions(+), 27 deletions(-)

-- 
2.7.4

