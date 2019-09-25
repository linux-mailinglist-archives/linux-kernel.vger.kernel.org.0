Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B091FBDFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436790AbfIYOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 10:16:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50721 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436608AbfIYOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:11 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD85R-0000Dd-JA; Wed, 25 Sep 2019 15:16:09 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD85Q-00065l-TW; Wed, 25 Sep 2019 15:16:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/4] arm: arch_timer: include <asm/arch_timer.h>
Date:   Wed, 25 Sep 2019 15:16:04 +0100
Message-Id: <20190925141604.23364-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
References: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_timer_arch_init is defined in <asm/arch_timer.h> so include
that to fix the following sparse error:

arch/arm/kernel/arch_timer.c:31:12: warning: symbol 'arch_timer_arch_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/arch_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c125582de2e7..b5e217907686 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 
 #include <asm/delay.h>
+#include <asm/arch_timer.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-- 
2.23.0

