Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD8D0980
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfJIIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 04:21:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfJIIVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:21:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2659932AA2271B9FDEC2;
        Wed,  9 Oct 2019 16:21:00 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 16:20:49 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <darrick.wong@oracle.com>,
        <ebiggers@google.com>, <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH xfstests] generic/192: Move 'cd /' to the place where the program exits
Date:   Wed, 9 Oct 2019 16:27:57 +0800
Message-ID: <1570609677-49586-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running generic/192 with overlayfs(Let ubifs as base fs) yields the
following output:

  generic/192 - output mismatch
     QA output created by 192
     sleep for 5 seconds
     test
    +./common/rc: line 316: src/t_dir_type: No such file or directory
     delta1 is in range
     delta2 is in range
    ...

When the use case fails, the call stack in generic/192 is:

  local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc:316
  _supports_filetype					common/rc:299
  _overlay_mount					common/overlay:52
  _overlay_test_mount					common/overlay:93
  _test_mount						common/rc:407
  _test_cycle_mount					generic/192:50

Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
found.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/generic/192 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/192 b/tests/generic/192
index 50b3d6fd..5550f39e 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -15,7 +15,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+}
 
 _access_time()
 {
@@ -46,7 +51,6 @@ sleep $delay # sleep to allow time to move on for access
 cat $testfile
 time2=`_access_time $testfile | tee -a $seqres.full`
 
-cd /
 _test_cycle_mount
 time3=`_access_time $testfile | tee -a $seqres.full`
 
-- 
2.13.6

