Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91A015C365
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 16:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgBMPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 10:40:52 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:48167 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgBMPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:40:47 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01DFdZHV005809;
        Fri, 14 Feb 2020 00:39:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHV005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581608376;
        bh=dqecOZAANxjvQ3trtEaHQkh+WvtX98O39pJAPhItCK8=;
        h=From:To:Cc:Subject:Date:From;
        b=iSn7y9stEH0GS1eu9X4sH5jPS0X4ZO9WgMOY40Ymos1qcTEFr9MSajcjv70Rt3qAF
         Wptf7W8HWPLqck3wHlwUJrPxI2/IDFX+3kCeeR4NGkxn892yQsMbdtYYnpoFXAtQqr
         UE0P831QydXlx/8xElFEm9rGkwB48e8S4OwRMRxhWnRqfbEfyPvXNFNu+Oru5qwPRz
         xaXwsu6uWfIJ+BtdmbXqqSUvuQc1OOvWeyD4WzxIyqyLtIlGRdctFGhUhKF4/G5peF
         Q71MP6onwpjCd4g96QW9GYTuyyiRp4KbDkVT5pN+HlD6pU+RrBlBuZpJx7p1frgjcI
         uHKQjhmgk0UHA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/radeon: remove unneeded header include path
Date:   Fri, 14 Feb 2020 00:39:24 +0900
Message-Id: <20200213153928.28407-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A header include path without $(srctree)/ is suspicious because it does
not work with O= builds.

You can build drivers/gpu/drm/radeon/ without this include path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index c693b2ca0329..9d5d3dc1011f 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-ccflags-y := -Idrivers/gpu/drm/amd/include
-
 hostprogs := mkregtable
 clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
 
-- 
2.17.1

