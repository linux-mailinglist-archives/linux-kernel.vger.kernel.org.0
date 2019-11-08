Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8FF5067
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKHP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:59:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:45620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbfKHP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:59:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5083DB45F;
        Fri,  8 Nov 2019 15:59:03 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] checkpatch: remove "ipc" from list of expected toplevel directories
Date:   Fri,  8 Nov 2019 17:04:28 +0100
Message-Id: <20191108160428.9632-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl uses a list of expected directory names to understand if it's
being run from the top of a kernel tree. Commit 76128326f97c ("toplevel:
Move ipc/ to kernel/ipc/: move the files") removed a toplevel directory, so
checkpatch.pl need to update its list.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6fcc66afb088..93b8fd1eea57 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1099,7 +1099,7 @@ sub top_of_kernel_tree {
 	my @tree_check = (
 		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
 		"README", "Documentation", "arch", "include", "drivers",
-		"fs", "init", "ipc", "kernel", "lib", "scripts",
+		"fs", "init", "kernel", "lib", "scripts",
 	);
 
 	foreach my $check (@tree_check) {
-- 
2.16.4

