Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412F961FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfGHNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 09:51:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:51:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MVaQW-1huLvS0AkO-00RbTc; Mon, 08 Jul 2019 15:51:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix building without CONFIG_HMM_MIRROR
Date:   Mon,  8 Jul 2019 15:51:24 +0200
Message-Id: <20190708135135.610355-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Try8nevSfQ6LJLOsIb7LCr5neA+PjlmdVukydwRVE7Gsov5fADa
 rW7QTzw6r1z5vpwJBY1rwNpqk5oevj8duGKPxzodhe7pnj94XxCMw8VtkWCHXQ8AeQo4cw+
 jGQLE+Qin3wqheYAl5VpnCH6JOMHyE21JSOrSco7yP/tUhiWrOgJz5dcHHWu1dYyV5Kxvmv
 iCd3NniMc510079Mss/Vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWYpwebFz1I=:G1x40m2rbJewCi8eDhXMRA
 TCM8b4h0pb+bOFNOYud9CwhQSArN3pKViWO3/FomWzVjqvf66+dEfBq5SAyKrFdJ4FALT1Nz9
 NHuKQFQTz8+XPMZjAkXpILgIPXkfWLk2MF3XEHnTfJQTGDbFfqNG+kKB6Ix4ZMORaBPXE2hQZ
 iPEDQp9r8aD6qvzFTXky2wIdUOP4hHHb65rJIO9+79etNmX7ItGOhHI/wB0MxyHsnCC6ng0dZ
 N+A5Cx/wuikkXyaDuzHrpMnG6gy9bnmjtsi+S8ubc0Z7CGl6YKizQpo5a8bax+YJooCoo9pWV
 ye+5nIom0Ckx/y3tsGSI973jBPtMkMg7Zzjg7kjlX0jmXiXV7QAXNn7lGY0XyIfZm8ssUaspa
 0WEX45aYFYqpod6YXeGBZop3+n2xIV6zNtVPofhp7ut5KD/eXUBi37Xy9Wvi7sQmSsolABjhG
 pq54VzAAlmrg8Q3I+Cd/l/y+2nd65CWBvmN8na3oxfd1by/BjjQISuWqZiVjNwknDIMu0Ulfm
 W8yrdIMOp3ub8pOwIpjrP25tm6MjO9rShUeLYul2v3nTcxI47ihp5YoQNDIandjoKk43Mf2Zn
 nNlxJThDHIoe6La8U3ay+g8KZS5HKHqervgh/UFvLY7LsSFVtafLjA1RrBmfMymu3wKvePT2k
 L92VYYRTamBbfwNSb9W0S2h2khRtGQpFnqVlkHuJbWuV310w0+KCX6cBTzbdpLlpnIkHqr+2i
 LtO/MZt6THXQPsYCU1K+9VxOizsIZPPo1jLTtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct hmm_mirror' is not defined without the Kconfig option set,
so we cannot include it within another struct:

In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:72:
drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_mn.h:69:20: error: field has incomplete type 'struct hmm_mirror'
        struct hmm_mirror       mirror;
                                ^
drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_mn.h:69:9: note: forward declaration of 'struct hmm_mirror'
        struct hmm_mirror       mirror;

Add the #ifdef around it that is also used for all functions operating
on it.

Fixes: 7590f6d211ec ("drm/amdgpu: Prepare for hmm_range_register API change")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 281fd9fef662..b8ed68943625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -65,8 +65,10 @@ struct amdgpu_mn {
 	struct rw_semaphore	lock;
 	struct rb_root_cached	objects;
 
+#ifdef CONFIG_HMM_MIRROR
 	/* HMM mirror */
 	struct hmm_mirror	mirror;
+#endif
 };
 
 #if defined(CONFIG_HMM_MIRROR)
-- 
2.20.0

