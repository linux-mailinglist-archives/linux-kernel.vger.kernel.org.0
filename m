Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56715A6D05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfICPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 11:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61231 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfICPhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:37:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EE3E4904;
        Tue,  3 Sep 2019 15:37:42 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D16AE19C78;
        Tue,  3 Sep 2019 15:37:41 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] tools/power/x86/intel-speed-select: Fix cpu-count output
Date:   Tue,  3 Sep 2019 11:37:29 -0400
Message-Id: <20190903153734.11904-4-prarit@redhat.com>
In-Reply-To: <20190903153734.11904-1-prarit@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 03 Sep 2019 15:37:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with 28 threads/socket but intel-speed-select reports
a cpu-count of 29.

Fix an off-by-one error in the cpu_count() function.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index d32af8210427..f81a28c6b586 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -304,7 +304,7 @@ static void set_cpu_present_cpu_mask(void)
 int get_cpu_count(int pkg_id, int die_id)
 {
 	if (pkg_id < MAX_PACKAGE_COUNT && die_id < MAX_DIE_PER_PACKAGE)
-		return cpu_cnt[pkg_id][die_id] + 1;
+		return cpu_cnt[pkg_id][die_id];
 
 	return 0;
 }
-- 
2.21.0

