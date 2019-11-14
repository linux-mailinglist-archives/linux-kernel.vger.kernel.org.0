Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B68FBCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 01:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 19:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfKNAT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:19:27 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9142D206F2;
        Thu, 14 Nov 2019 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573690766;
        bh=tGvFGDEK2oZKkTKzOKFp8OpdDoQrzJYalEyDYSTMIVg=;
        h=From:To:Cc:Subject:Date:From;
        b=f/aDnd9PUbLsbmDBSL4DfUkvccnDESjrH7AtRU+zGXDtwB6YkS4lRSEQ/06/z3bUZ
         Mc7tUphoZznPcIBp6UkxdNQT0wULRKsmkns5EEPsYon/IbcDOhHDwk6XQocEEO3YV2
         EHcQv9hIJSJha9hletYo9KRaGoRyZ/ZtQKk+prYo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clk: ingenic: Allow drivers to be built with COMPILE_TEST
Date:   Wed, 13 Nov 2019 16:19:25 -0800
Message-Id: <20191114001925.159276-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the MIPS architecture or even a MIPS compiler to compile
test these drivers. Let's add a COMPILE_TEST possibility on the
menuconfig here so that we can build these drivers on more
configurations.

Cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/ingenic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
index fb7b39961703..b4555b465ea6 100644
--- a/drivers/clk/ingenic/Kconfig
+++ b/drivers/clk/ingenic/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Ingenic SoCs drivers"
-	depends on MIPS
+	depends on MIPS || COMPILE_TEST
 
 config INGENIC_CGU_COMMON
 	bool
-- 
Sent by a computer through tubes

