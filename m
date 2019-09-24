Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F46BCD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633182AbfIXQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633170AbfIXQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:44:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003A121783;
        Tue, 24 Sep 2019 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343467;
        bh=0QVKQtbYTzc53uwo95bKg2rV7mwigxbBZrR2N+aprkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6kANdGBLF7IZyE2XaSxhP8zjjK+1sjLAqmbd1HcDHlXCEn41AhMqjMdl6iEaMw1B
         JU7g4XLUSSHck+K2hoktykfKVJfmDo+llHhr+lKcYbpaByoGv5Pj3xP5i6wGg1YTan
         zw+YYH8TQwy/X3j8auhgJp4Q2GgNfhjB8ejGaUBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Wang <kevin1.wang@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.3 60/87] drm/amd/powerpaly: fix navi series custom peak level value error
Date:   Tue, 24 Sep 2019 12:41:16 -0400
Message-Id: <20190924164144.25591-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Wang <kevin1.wang@amd.com>

[ Upstream commit 706feb26f890e1b8297b5d14975160de361edf4f ]

fix other navi asic set peak performance level error.
because the navi10_ppt.c will handle navi12 14 asic,
it will use navi10 peak value to set other asic, it is not correct.

after patch:
only navi10 use custom peak value, other asic will used default value.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index b81c7e715dc94..9aaf2deff6e94 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1627,6 +1627,10 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 static int navi10_set_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
 {
 	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->asic_type != CHIP_NAVI10)
+		return -EINVAL;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-- 
2.20.1

