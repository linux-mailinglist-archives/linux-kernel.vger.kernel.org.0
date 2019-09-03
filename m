Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB1A7189
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfICRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:18:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54310 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfICRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:18:18 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1i5CRc-0006nB-Lt; Tue, 03 Sep 2019 17:18:17 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] alarmtimer: use EOPNOTSUPP instead of ENOTSUPP
Date:   Tue,  3 Sep 2019 14:18:02 -0300
Message-Id: <20190903171802.28314-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENOTSUPP is not supposed to be returned to userspace. This was found on an
OpenPower machine, where the RTC does not support set_alarm.

On that system, before the patch, a clock_nanosleep(CLOCK_REALTIME_ALARM, ...)
would result in "524 Unknown error 524", while after the patch, we get
"95 Operation not supported".

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Fixes: 1c6b39ad3f01 (alarmtimers: Return -ENOTSUPP if no RTC device is present)
---
 kernel/time/alarmtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..b7d75a9e8ccf 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -672,7 +672,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 	enum  alarmtimer_type type;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
@@ -790,7 +790,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	int ret = 0;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (flags & ~TIMER_ABSTIME)
 		return -EINVAL;
-- 
2.20.1

