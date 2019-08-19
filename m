Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7376E948F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfHSPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:47:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47710 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfHSPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqi-0006tE-Ct; Mon, 19 Aug 2019 17:45:36 +0200
Message-Id: <20190819143801.565389536@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 02/44] alarmtimers: Avoid rtc.h include
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc.h is not needed in alarmtimers when a forward declaration of struct
rtc_device is provided. That allows to include posix-timers.h without
adding more includes to alarmtimer.h or creating circular include
dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/alarmtimer.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -5,7 +5,8 @@
 #include <linux/time.h>
 #include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
-#include <linux/rtc.h>
+
+struct rtc_device;
 
 enum alarmtimer_type {
 	ALARM_REALTIME,


