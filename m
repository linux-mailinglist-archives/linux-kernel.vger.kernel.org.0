Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8C702AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGVOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 10:52:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:52:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M6m5o-1hmpZg2zkM-008LEh; Mon, 22 Jul 2019 16:52:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org, Sekhar Nori <nsekhar@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] ARM: davinci: fix sleep.S build error on ARMv4
Date:   Mon, 22 Jul 2019 16:51:50 +0200
Message-Id: <20190722145211.1154785-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iAtehMXXYnCWFJ5DNLwBwFTLws99i7fqpxPmtyH/yvfW6H8Ctwi
 Fi0td61Baqu91ONIbhZ60qL+AFXtUkL6w2fLXTYYdGUgr+KMERUmtOldY4oImOCN2gtBYUT
 VDZVT1cOtCr558emYVAisbXf3xuo2stca3tdRs4O93g2DXxsMxUwrBIktSa/7Wz1Apyj1un
 POdBB5yEFLkQJWrFmCzww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ib0Mi+4+ezs=:EsbpZag6xZFGxTQ4oiBoDR
 slk0vaCKD/n0SbnmPoRD1wTO8croA0WgKEYcN322V1kbu8eEqqnInDPjzuhy/VEoHkB6hvuYr
 yHzH2isYcdpIxIEJv4sb3yobdl47QB4wozEpob8Glf+KxRwy62df82t3t+c98Gi577RuskI6N
 VwRlraxQkFPWl3qkMBVQotGMVFT14/8BZUJVedKoqnWafWQ8/wjaPWk6Zmg7mK6eXayXQ9g4S
 gAYZKwULnMzqMEZVO0Ys+iaWaN0rGRmTHknuWy8TEK4VH8KSEQph7utWXwj67pJzesFFYjTKy
 ix8l4M9yjZlTperBVIbO5yAX9Hmvw0bVCYTo+glx6Qo937jys06/Wsh1IGbeIZaqNzR9qMV31
 gKNxLe9BRS8rvpm2pcmiPRtdi2C1R6I0nH/L9LxOJ+/ujgUXaHTXcQMjqr2U802CUoarSwabF
 +WUPS8XoMT0bsG0hgtB7AVjed4b3QW5GYQY6CpEXDQEpkckwVpIBQiCw3y907uBkP3/2lD4H8
 GM/h1Go8BZWshzky3ydC2BXq89GEMPSzS/SUM7xNL66UL00xVnL3ZbwsqUL2rEi875sgaiWcT
 0p7DSh8Nn4fC4XaCR5DFf6XUeVKPeGQn5njpQvYQgLXDB0wgUZTn9cL1yCZ3gpvVQhnvcHeTg
 MnCOSgnzpt+4rt73V1ylSFTjHSU/HbvqKwlqqQwhgBW+NtUqIEj4u7i10phtWdRKBzMaIEfIa
 lNSDYK5+g4pNM+7gFadRP+vot3w3vfOX4aTymQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a multiplatform kernel that includes armv4 support,
the default target CPU does not support the blx instruction,
which leads to a build failure:

arch/arm/mach-davinci/sleep.S: Assembler messages:
arch/arm/mach-davinci/sleep.S:56: Error: selected processor does not support `blx ip' in ARM mode

Add a .arch statement in the sources to make this file build.

Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I forgot to pick this up for arm-soc, sending again so it
ends up in the inbox
---
 arch/arm/mach-davinci/sleep.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index 05d03f09ff54..71262dcdbca3 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -24,6 +24,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.arch	armv5te
 /*
  * Move DaVinci into deep sleep state
  *
-- 
2.20.0

