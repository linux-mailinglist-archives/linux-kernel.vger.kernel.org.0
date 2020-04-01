Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB819A386
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 04:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgDACWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 22:22:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731531AbgDACWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:22:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E631FEE263379FD4D8D0;
        Wed,  1 Apr 2020 10:22:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 10:22:28 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/i915/gt: fix spelling mistake "undeflow" -> "underflow"
Date:   Wed, 1 Apr 2020 10:25:06 +0800
Message-ID: <20200401022506.52965-1-chenzhou10@huawei.com>
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

There is a spelling mistake in comment, fix it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index b6cf284..3be6797 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -181,7 +181,7 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 	 * Ergo, if we put ourselves on the timelines.active_list
 	 * (se intel_timeline_enter()) before we increment the
 	 * engine->wakeref.count, we may see the request completion and retire
-	 * it causing an undeflow of the engine->wakeref.
+	 * it causing an underflow of the engine->wakeref.
 	 */
 	flags = __timeline_mark_lock(ce);
 	GEM_BUG_ON(atomic_read(&ce->timeline->active_count) < 0);
-- 
2.7.4

