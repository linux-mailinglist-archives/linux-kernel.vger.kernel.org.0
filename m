Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D15103BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfKTNhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfKTNh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:29 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B3B224EB;
        Wed, 20 Nov 2019 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257049;
        bh=dtoGThLsXdVxMEgNznYU8jvjZIDvrTTVk7uqrklGUg4=;
        h=From:To:Cc:Subject:Date:From;
        b=BTmADTdwzoE8aG1Z/gCWS1t7XXI+XxrRey/2RfaezzG7FMM5JmGzEYNDHa8iX/PGF
         rYvGoJ0qkgxICx4eb5esmk/GSUKNRSaxswXsrLxbkGKjamRQ7onyJpVNmpy83ciqJe
         gbe+4PPQuJbJwK7fCdTpdI0WQqH7Ojq3mWXSIANY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH] h8300: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:25 +0800
Message-Id: <20191120133725.12233-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/h8300/Kconfig     | 4 ++--
 arch/h8300/Kconfig.cpu | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 14bb45644c0c..7a33141fd0b7 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config H8300
-        def_bool y
+	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
@@ -38,7 +38,7 @@ config NO_IOPORT_MAP
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config HZ
 	int
diff --git a/arch/h8300/Kconfig.cpu b/arch/h8300/Kconfig.cpu
index b5e14d513e62..59be62d0716b 100644
--- a/arch/h8300/Kconfig.cpu
+++ b/arch/h8300/Kconfig.cpu
@@ -90,11 +90,11 @@ config H8S_SIM
 endchoice
 
 config H8300_BUILTIN_DTB
-        string "Builtin DTB"
+	string "Builtin DTB"
 	default ""
 
 config OFFSET
-        hex "Load offset"
+	hex "Load offset"
 	default 0
 
 endmenu
-- 
2.17.1

