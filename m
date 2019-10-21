Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF3DF25F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfJUQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:05:03 -0400
Received: from linux-8ccs.suse.cz (ip5f5ade6e.dynamic.kabel-deutschland.de [95.90.222.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA5D1214AE;
        Mon, 21 Oct 2019 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571673902;
        bh=gV8c3T01F0BTyDBAf4oVsD8CetT4S5sEcniUAfvvffE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPP5Mraq1qg4uu6Fnr//Q9K+pTAUuBHVWp8FyhcwDmuFls+fVEdTfQA0qDdHVF/9y
         /Y4S1MJeuhkA5ZW0i640O1JyEHY3B+NrnbFmCyvXtF5r6QDzK1YABH5bBWzK9kQpOZ
         kaqbgZOe/v4H4+mbMgUIbPbIQVTgxXX4bzZCqJcM=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] scripts/nsdeps: use alternative sed delimiter
Date:   Mon, 21 Oct 2019 18:04:19 +0200
Message-Id: <20191021160419.28270-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021145137.31672-1-jeyu@kernel.org>
References: <20191021145137.31672-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing an out of tree build with O=, the nsdeps script constructs
the absolute pathname of the module source file so that it can insert
MODULE_IMPORT_NS statements in the right place. However, ${srctree}
contains an unescaped path to the source tree, which, when used in a sed
substitution, makes sed complain:

++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
sed: -e expression #1, char 12: unknown option to `s'

The sed substitution command 's' ends prematurely with the forward
slashes in the pathname, and sed errors out when it encounters the 'h',
which is an invalid sed substitution option. To avoid escaping forward
slashes in ${srctree}, we can use '|' as an alternative delimiter for
sed to avoid this error.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

This is an alternative to my first patch here:

  http://lore.kernel.org/r/20191021145137.31672-1-jeyu@kernel.org

Matthias suggested using an alternative sed delimiter instead to avoid the
ugly/unreadable ${srctree//\//\\\/} substitution.

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 3754dac13b31..63da30a33422 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -33,7 +33,7 @@ generate_deps() {
 	if [ ! -f "$ns_deps_file" ]; then return; fi
 	local mod_source_files=`cat $mod_file | sed -n 1p                      \
 					      | sed -e 's/\.o/\.c/g'           \
-					      | sed "s/[^ ]* */${srctree}\/&/g"`
+					      | sed "s|[^ ]* *|${srctree}\/&|g"`
 	for ns in `cat $ns_deps_file`; do
 		echo "Adding namespace $ns to module $mod_name (if needed)."
 		generate_deps_for_ns $ns $mod_source_files
-- 
2.16.4

