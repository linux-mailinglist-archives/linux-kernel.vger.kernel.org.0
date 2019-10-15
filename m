Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68AD7FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389560AbfJOTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:19:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389425AbfJOTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:53 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLD-00067i-I9; Tue, 15 Oct 2019 21:18:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:16 +0200
Message-Id: <20191015191821.11479-30-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the Kconfig dependency to CONFIG_PREEMPTION.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +LCD_HP700]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/video/backlight/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kcon=
fig
index 40676be2e46aa..d09396393724b 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -99,7 +99,7 @@ config LCD_TOSA
=20
 config LCD_HP700
 	tristate "HP Jornada 700 series LCD Driver"
-	depends on SA1100_JORNADA720_SSP && !PREEMPT
+	depends on SA1100_JORNADA720_SSP && !PREEMPTION
 	default y
 	help
 	  If you have an HP Jornada 700 series handheld (710/720/728)
@@ -228,7 +228,7 @@ config BACKLIGHT_HP680
=20
 config BACKLIGHT_HP700
 	tristate "HP Jornada 700 series Backlight Driver"
-	depends on SA1100_JORNADA720_SSP && !PREEMPT
+	depends on SA1100_JORNADA720_SSP && !PREEMPTION
 	default y
 	help
 	  If you have an HP Jornada 700 series,
--=20
2.23.0

