Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B9C87BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfJBMCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 08:02:40 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQ5nE-1iSsrQ1Bbs-00M5vI; Wed, 02 Oct 2019 14:02:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Roman Li <Roman.Li@amd.com>, Huang Rui <ray.huang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: hide another #warning
Date:   Wed,  2 Oct 2019 14:01:23 +0200
Message-Id: <20191002120136.1777161-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NGWmbgtBQPd36ajMsUKwWTLmLmAiDhXD+Mtxk8YE6bumOY91z5j
 ElTVg9ErXeu19zyaJjHShChe33oD/sZNS+NC2xYgJxGSP+Cv3fiUPnJQyoF55GFnKYLRXfE
 2W6ePyEZZZnJqvhJcnEYxyIsGj4XVU0SqmkvNUws9vUBxgum1tpeEkHDr3eU9mOfpWs5/qK
 c2OuGSj7VRRq4HZWHmlZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tHfRN4OBGvs=:fW2ZMTKDtL5J46tSOTYwo7
 hI7G13ULkv0U0gsFqYPM7VIrS2vVTeLAAKk8Zocotl1a26VnKSzf9ACjbySMHLqn/YLFLM/an
 jeeK1w0O6FziurC6udZLBxSQ+w0xuShgNAS0dmb85TNlZUEbFIPBKcifVb3SOOLztBaPCGUoS
 NoehdFJs+5F06tEFkYh7RwCws57iJl9IDF36NDU172d0j651NCYKxiRTwuVJwq8v1pMMgNB5F
 GsyPI9invPbWQ3Qabv8Vl541BCJz9kq9SiLAynFCEGBppk4/2heBNKiysrhzUyY1GCFXFTpyR
 jm8R4mSKoHnYymZBfQmM21Ya5YRoWOxjZlL5b29/a/vCjHR60Mbhn6O4fWvYjFyKZM+oeDBHm
 jvmamJcUpz4LrKYPTScimQTnJiMNSF6TegjnGok+Avkuq6CXLEt76q7OcOrdcL3RlIj8N3Z93
 0Mcr4Ca4s6pOIPFYp2MpBCsdAc496jndQymEUZ1kzL+QHE2Vm189XY8O8uy3FO62o9wg6jW8r
 20Z2Rigz+n98Qn70o/GL7dR0t6pn5/+Ah8CUB8BUj7UuRb4B5Y1r204f9PrdCZoJd1bxNtGv1
 T/35lymzxTtG0LHfNqneYlv6dW8w81olD7OcLsd8EpnRNH21ddoiXrNZzEMkRJYeEK2UZvYN6
 v4BAKGf6lXNAe8dPzPVonqnshdSOGTOcS/U6YliDF3sFT3NUiOwme5Svxk92FTSkEJ+jGVWle
 zPH8uxRgIf9rDysK359hEjmf07lC2vhIYljzmzZSr4bZGDx2dka+aX71oDLFS+QXMs3GTAdRB
 gGHLG73VBU/aKAB1EmzCuuwYNDAJcYU/AGCdbyVwGlLKwDQX9iLOiFzUNQOoVeVwDVO2oo8tH
 jD/cUlQlPEXbqVI5PSqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier patch of mine disabled some #warning statements
that get in the way of build testing, but then another
instance was added around the same time.

Remove that as well.

Fixes: b5203d16aef4 ("drm/amd/amdgpu: hide #warning for missing DC config")
Fixes: e1c14c43395c ("drm/amdgpu: Enable DC on Renoir")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f70658a536a9..a337d980b434 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -771,8 +771,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
                 else if (amdgpu_device_has_dc_support(adev))
                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#else
-#       warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
 #endif
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		break;
-- 
2.20.0

