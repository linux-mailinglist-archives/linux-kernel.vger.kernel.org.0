Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752B0BEA13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 03:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfIZB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 21:27:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbfIZB10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:27:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18EF625132B84FCB9BB5;
        Thu, 26 Sep 2019 09:27:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 09:27:21 +0800
To:     Joe Perches <joe@perches.com>, <apw@canonical.com>,
        <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] scripts: Move ipc/ to kernel/ipc/: don't check the ipc dir
Message-ID: <bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com>
Date:   Thu, 26 Sep 2019 09:26:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
the files"), we met some error messages:

  ./scripts/checkpatch.pl:
  "Must be run from the top-level dir. of a kernel tree"

  ./scripts/get_maintainer.pl:
  "The current directory does not appear to be a linux kernel source tree.

Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
v1 -> v2:
 - update the subject "scripts:" instead of "toplevel:"

 scripts/checkpatch.pl     | 2 +-
 scripts/get_maintainer.pl | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edf..6117d0e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1097,7 +1097,7 @@ sub top_of_kernel_tree {
 	my @tree_check = (
 		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
 		"README", "Documentation", "arch", "include", "drivers",
-		"fs", "init", "ipc", "kernel", "lib", "scripts",
+		"fs", "init", "kernel", "lib", "scripts",
 	);

 	foreach my $check (@tree_check) {
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 5ef5921..2e42aeb 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1109,7 +1109,6 @@ sub top_of_kernel_tree {
 	&& (-d "${lk_path}drivers")
 	&& (-d "${lk_path}fs")
 	&& (-d "${lk_path}init")
-	&& (-d "${lk_path}ipc")
 	&& (-d "${lk_path}kernel")
 	&& (-d "${lk_path}lib")
 	&& (-d "${lk_path}scripts")) {
-- 
2.7.4

