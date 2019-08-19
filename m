Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD94B92372
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfHSM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 08:29:31 -0400
Received: from foss.arm.com ([217.140.110.172]:53568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSM3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:29:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5567728;
        Mon, 19 Aug 2019 05:29:30 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B7B3F246;
        Mon, 19 Aug 2019 05:29:28 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: add *_NOTIFIER_HEAD as var definition
Date:   Mon, 19 Aug 2019 15:29:16 +0300
Message-Id: <20190819122917.11896-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add *_NOTIFIER_HEAD as variable definition to avoid code like this:

ATOMIC_NOTIFIER_HEAD(foo);
EXPORT_SYMBOL_GPL(foo);

From triggering the the following warning:
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---

Changes from v1:
- Fixed misposition of braces.
- Tested on 1k last commits from Linux tree.

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..8bc0e753a329 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3864,6 +3864,7 @@ sub process {
 				^.DEFINE_$Ident\(\Q$name\E\)|
 				^.DECLARE_$Ident\(\Q$name\E\)|
 				^.LIST_HEAD\(\Q$name\E\)|
+				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
 				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
 				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
 			    )/x) {
-- 
2.23.0

