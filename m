Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B100E143EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:01:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbgAUOA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:00:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 678768EBA5D468A15A51;
        Tue, 21 Jan 2020 22:00:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 22:00:41 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <tao.zhou1@amd.com>, <Hawking.Zhang@amd.com>,
        <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 01/14] drm/amdgpu: remove unnecessary conversion to bool in mmhub_v1_0.c
Date:   Tue, 21 Jan 2020 21:55:27 +0800
Message-ID: <20200121135540.165798-2-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200121135540.165798-1-chenzhou10@huawei.com>
References: <20200121135540.165798-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

./drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c:526:40-45: WARNING:
	conversion to bool not needed here
./drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c:528:40-45: WARNING:
	conversion to bool not needed here

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index adfd8a6..49a3a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -523,9 +523,9 @@ int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		mmhub_v1_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		mmhub_v1_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
-- 
2.7.4

