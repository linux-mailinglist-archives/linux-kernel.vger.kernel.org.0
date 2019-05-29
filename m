Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888FA2D4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 06:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfE2EdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 00:33:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfE2EdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:33:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id 33so546050pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ft5rXWQC7qZY1CC5FQHfzy5+fXUuRaC5FnUn1SYIJ4g=;
        b=O1dTBsRrFCdqAtUCxdSSwWT4O4+8pA5iN/NI4QP1btNMkoWtTdJA8hUZEzvzDDLm/j
         Hcwwe0s4uucPXyAQewv5YvmkPEyxUtT5rE7NPwgAZ6vIkeB0Iq5D2if/NkZz+3upZTCN
         FcZrAaNp1aGxH8Qbufp8pQXEEGwe2dpGlpqrEEKE1ySPkBcYGsp7C1Q9J6lIcO2tNAX+
         h9svGXXBHaKPQrvApeVRUndqgwv5j61p+gaIGSfhFnKnRDuD1mCT5cxs9Ezb+JUSw4va
         dU6E1dAXQZzdQma8+KD+Rv58qLRNYLv04HeHvjdLzvyu1hGW7NyNFpYBpHIHSq5F8GHH
         1Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ft5rXWQC7qZY1CC5FQHfzy5+fXUuRaC5FnUn1SYIJ4g=;
        b=HZg8VSeP9wFRm3GAjzg8zOlonhAOO6OJNLvhAh+5/RJ4WamNqCEVV/jH5LLNoH7dOs
         3KQ4ugTVCouIt5CNvfYskx62jooUbzqENrJ0FbPRDfrf8ToJskLtw5jrjjTuKBiZiXgb
         FrtnpELv8QRbyYxeXpBAqEWXl8UBSLkVhLsW8K5C/R3rdhUMjI7bjEF6Cdpu+o6z7rWo
         YKmB6soeu436U0yFKvSkMpdbEYErM92P5Y8WC8G/0FBoD8DMeFaJSMLadZt7VsCfemoo
         9u8JiDC0NiEoqb0LUDdK+1nWgNeiN6ykM7CiESMxzMJzeKxocEIZeoqpVhS/crWMSzhk
         kbSQ==
X-Gm-Message-State: APjAAAVcNhAVKWLQuFJc3+qPm4hR2lUaNEjJN3Gd2qENczsI808rJbrJ
        olwRZRUpWsWJ9n+AtPn3nqw=
X-Google-Smtp-Source: APXvYqzmyT7S78n/4DsveAwjgO/UKzog2hne8xPNPJxEP9EbTQGVRIVLElZgyGiLsZfQo/nbHZ3mHw==
X-Received: by 2002:a62:d205:: with SMTP id c5mr144778666pfg.219.1559104379972;
        Tue, 28 May 2019 21:32:59 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id p16sm27777757pfq.153.2019.05.28.21.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 21:32:59 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, kenneth.feng@amd.com, Hawking.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/amd/powerplay: avoid possible buffer overflow
Date:   Wed, 29 May 2019 12:34:07 +0800
Message-Id: <1559104447-26810-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the clock level enforced is within the allowed
ranges in case PP_SCLK and PP_MCLK.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 707cd4b..ae6cbe8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1836,6 +1836,12 @@ static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 	case PP_SCLK:
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
+		if (soft_max_level >= data->dpm_table.gfx_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.gfx_table.count - 1);
+			return -EINVAL;
+		}
 
 		data->dpm_table.gfx_table.dpm_state.soft_min_level =
 			data->dpm_table.gfx_table.dpm_levels[soft_min_level].value;
@@ -1856,6 +1862,12 @@ static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 	case PP_MCLK:
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
+		if (soft_max_level >= data->dpm_table.gfx_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.gfx_table.count - 1);
+			return -EINVAL;
+		}
 
 		data->dpm_table.mem_table.dpm_state.soft_min_level =
 			data->dpm_table.mem_table.dpm_levels[soft_min_level].value;
-- 
2.7.4

