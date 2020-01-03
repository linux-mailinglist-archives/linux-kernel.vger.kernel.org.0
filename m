Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701BF12F29D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgACBMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:12:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgACBMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:12:01 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C210AB265EBC2507D87C;
        Fri,  3 Jan 2020 09:11:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 09:11:52 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Fixes coccicheck warnings
Date:   Fri, 3 Jan 2020 09:12:36 +0800
Message-ID: <1578013959-31486-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Ma Feng (3):
  drm/i915: use true,false for bool variable in i915_debugfs.c
  drm/i915/dp: use true,false for bool variable in intel_dp.c
  drm/i915: use true,false for bool variable in intel_crt.c

 drivers/gpu/drm/i915/display/intel_crt.c | 6 +++---
 drivers/gpu/drm/i915/display/intel_dp.c  | 4 ++--
 drivers/gpu/drm/i915/i915_debugfs.c      | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

--
2.6.2

