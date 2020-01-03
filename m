Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5F12F29C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgACBMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:12:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgACBMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:12:00 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DF79D2A8712AAF9FC4A;
        Fri,  3 Jan 2020 09:11:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 09:11:54 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drm/i915: use true,false for bool variable in i915_debugfs.c
Date:   Fri, 3 Jan 2020 09:12:37 +0800
Message-ID: <1578013959-31486-2-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1578013959-31486-1-git-send-email-mafeng.ma@huawei.com>
References: <1578013959-31486-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/i915/i915_debugfs.c:3078:4-36: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/i915_debugfs.c:3078:4-36: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/i915_debugfs.c:3080:4-36: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/i915_debugfs.c:3080:4-36: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index d28468e..4ead86a 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -3075,9 +3075,9 @@ static ssize_t i915_displayport_test_active_write(struct file *file,
 			 * testing code, only accept an actual value of 1 here
 			 */
 			if (val == 1)
-				intel_dp->compliance.test_active = 1;
+				intel_dp->compliance.test_active = true;
 			else
-				intel_dp->compliance.test_active = 0;
+				intel_dp->compliance.test_active = false;
 		}
 	}
 	drm_connector_list_iter_end(&conn_iter);
--
2.6.2

