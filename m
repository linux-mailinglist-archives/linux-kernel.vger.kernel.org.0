Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61F1143EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAUOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:00:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbgAUOAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:00:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E2C832175FCBBEF9725C;
        Tue, 21 Jan 2020 22:00:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 22:00:36 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <tao.zhou1@amd.com>, <Hawking.Zhang@amd.com>,
        <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 00/14] drm/amdgpu: remove unnecessary conversion to bool 
Date:   Tue, 21 Jan 2020 21:55:26 +0800
Message-ID: <20200121135540.165798-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series remove unnecessary conversion to bool in dir 
drivers/gpu/drm/amd/amdgpu/, which is detected by coccicheck.

Chen Zhou (14):
  drm/amdgpu: remove unnecessary conversion to bool in mmhub_v1_0.c
  drm/amdgpu: remove unnecessary conversion to bool in vega10_ih.c
  drm/amdgpu: remove unnecessary conversion to bool in navi10_ih.c
  drm/amdgpu: remove unnecessary conversion to bool in gfx_v10_0.c
  drm/amdgpu: remove unnecessary conversion to bool in sdma_v5_0.c
  drm/amdgpu: remove unnecessary conversion to bool in athub_v1_0.c
  drm/amdgpu: remove unnecessary conversion to bool in amdgpu_acp.c
  drm/amdgpu: remove unnecessary conversion to bool in soc15.c
  drm/amdgpu: remove unnecessary conversion to bool in nv.c
  drm/amdgpu: remove unnecessary conversion to bool in mmhub_v9_4.c
  drm/amdgpu: remove unnecessary conversion to bool in amdgpu_device.c
  drm/amdgpu: remove unnecessary conversion to bool in athub_v2_0.c
  drm/amdgpu: remove unnecessary conversion to bool in sdma_v4_0.c
  drm/amdgpu: remove unnecessary conversion to bool in gfx_v9_0.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 28 ++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
 15 files changed, 43 insertions(+), 45 deletions(-)

-- 
2.7.4

