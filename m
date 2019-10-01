Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2032C3E62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJARRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:17:17 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.168]:49137 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbfJARRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:17:17 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 494F01C0B35
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 12:17:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FLlxid7VOBnGaFLlxiniJu; Tue, 01 Oct 2019 12:17:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jC0pGUu7ONuzkPakCaJslm1ocJh657+ItbAmjclYWMM=; b=QWf83RelFguqGhlDxQ6/HFUfl3
        GvphUs5+tkyDqG3+vEECMw5exhU1IzdQvvArvCj0gYk6uqgXuJIYWtzrRukcPheZB6HNhRTTOWU/n
        yZm2mvmLnoSdVNgMyd3j73MVGYLt+lzmjrHgz5spEvsy+7YOHp9Bscs6Bq4TyhyiX5ul5xrt0nHZa
        anH9mrT9Ao1IK5cd8M3ns55y2oGbu2fHQOJfJaCBmcxFVaLMkuBGUD9UmKJowcv6e910Q45bj3iUk
        FWjOswbBXh4hAcVDClwVW4Lqa9JkTPbkRNtMH31jluqSr5iuEjso/aXyqCaQmRrl5TJy2WtuZOFFr
        36Y9x2ZA==;
Received: from [187.192.22.73] (port=45568 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iFLlv-002uRD-J7; Tue, 01 Oct 2019 12:17:12 -0500
Date:   Tue, 1 Oct 2019 12:16:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Message-ID: <20191001171635.GA17306@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iFLlv-002uRD-J7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:45568
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notice that there is a *continue* statement in the middle of the
for loop and that prevents the code below from ever being reached:

	r = amdgpu_ring_test_ring(ring);
	if (r) {
		ring->sched.ready = false;
		goto done;
	}

Fix this by removing the continue statement and updating ring->sched.ready
to true before calling amdgpu_ring_test_ring(ring).

Notice that this fix is based on
commit 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")

Addresses-Coverity-ID 1485608 ("Structurally dead code")
Fixes: 28c17d72072b ("drm/amdgpu: add VCN2.5 basic supports")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

Any feedback is greatly appreciated.

 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 395c2259f979..47b0dcd59e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -258,6 +258,7 @@ static int vcn_v2_5_hw_init(void *handle)
 		adev->nbio_funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 						     ring->doorbell_index, j);
 
+		ring->sched.ready = true;
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
@@ -266,8 +267,7 @@ static int vcn_v2_5_hw_init(void *handle)
 
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 			ring = &adev->vcn.inst[j].ring_enc[i];
-			ring->sched.ready = false;
-			continue;
+			ring->sched.ready = true;
 			r = amdgpu_ring_test_ring(ring);
 			if (r) {
 				ring->sched.ready = false;
@@ -276,6 +276,7 @@ static int vcn_v2_5_hw_init(void *handle)
 		}
 
 		ring = &adev->vcn.inst[j].ring_jpeg;
+		ring->sched.ready = true;
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
-- 
2.23.0

