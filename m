Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649D38B46E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfHMJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 05:45:13 -0400
Received: from mail.windriver.com ([147.11.1.11]:49725 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfHMJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:45:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7D9iqi2019320
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 13 Aug 2019 02:44:53 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 13 Aug 2019 02:44:51 -0700
From:   <zhe.he@windriver.com>
To:     <keescook@chromium.org>, <re.emese@gmail.com>,
        <kernel-hardening@lists.openwall.com>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH] gcc-plugins: Enable error message print
Date:   Tue, 13 Aug 2019 17:44:49 +0800
Message-ID: <1565689489-309136-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Instead of sliently emptying CONFIG_PLUGIN_HOSTCC which is the dependency
of a series of configurations, the following error message would be easier
for users to find something is wrong and what is happening.

scripts/gcc-plugins/gcc-common.h:5:22: fatal error: bversion.h:
No such file or directory
compilation terminated.

Now that we have already got the error message switch, let's turn it on.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 scripts/gcc-plugins/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index d33de0b..fe28cb9 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -3,7 +3,7 @@ preferred-plugin-hostcc := $(if-success,[ $(gcc-version) -ge 40800 ],$(HOSTCXX),
 
 config PLUGIN_HOSTCC
 	string
-	default "$(shell,$(srctree)/scripts/gcc-plugin.sh "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
+	default "$(shell,$(srctree)/scripts/gcc-plugin.sh --show-error "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
 	help
 	  Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
 	  $(HOSTCC), or a null string if GCC plugin is unsupported.
-- 
2.7.4

