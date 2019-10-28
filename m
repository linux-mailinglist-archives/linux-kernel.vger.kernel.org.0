Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38763E74AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbfJ1POh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfJ1POh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:14:37 -0400
Received: from linux-8ccs.suse.cz (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F8B21783;
        Mon, 28 Oct 2019 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275676;
        bh=nUTEiVlB+AB4XpfbHMHrrllVK8vtgQ53OJnISc/LqWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=0/71qSPom2ZVo56OMnqnKMuu3BVfQbY7fERV6uVinVImk1go7rk+Y/wGs64h250EK
         m6L7qDmMdWN548X4C/5S5+0skHeDI+ex5TDSO/LbREb2xzN+n5uVrdN9KRYnl42mAt
         /23cNMdtwubQMwjq3ghtgl/8H6vnbggmxt4vz2eA=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 1/4] scripts/nsdeps: use $MODORDER to obtain correct modules.order path
Date:   Mon, 28 Oct 2019 16:14:24 +0100
Message-Id: <20191028151427.31612-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nsdeps script calls generate_deps() for every module in the
modules.order file. It prepends $objtree to obtain the full path of the
top-level modules.order file. This produces incorrect results when
calling nsdeps for an external module, as only the ns dependencies for
in-tree modules listed in $objtree/modules.order are generated rather
than the ns dependencies for the external module. To fix this, just use
the MODORDER variable provided by kbuild - it uses the correct path for
the relevant modules.order file (either in-tree or the one produced by
the external module build).

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

So, not being too familiar with kbuild, I am not sure if MODORDER was the
appropriate kbuild variable to use, but I could not find anything else that
gives us the modules.order path. Masahiro, please let me know if this is
appropriate usage.

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index dda6fbac016e..54d2ab8f9e5c 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -52,7 +52,7 @@ generate_deps() {
 	done
 }
 
-for f in `cat $objtree/modules.order`; do
+for f in `cat $MODORDER`; do
 	generate_deps $f
 done
 
-- 
2.16.4

