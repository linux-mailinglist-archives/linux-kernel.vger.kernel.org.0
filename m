Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2882A8F102
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfHOQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:38:58 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39332 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbfHOQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:56 -0400
Received: by mail-wm1-f53.google.com with SMTP id i63so1770431wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb5bd9sGlkaevgxTq4hdZdG/RlKcCqkshVMsKpe48NU=;
        b=bEzZr3nrZ3yYWSNWOT6qVDZSskJ1uCu3LSvVBk8x8q+Jkg7LVGjUmjl2vyjETwXOuK
         QK12AZq9ASagngzviK+bT8vEUrzwz7KAFkO6m83LUG3kmZnzj23dk/Mv7XxlmThMXhfF
         rp5VFKyrM+hlv0BbufR7rVqBx7G1EGubpwAgo17q0fzcqJvGx2/zwItFceCc8fwprJKW
         NCd1H4y0kht/v+zQ03Sas6Byzld1PMB/AMzlKlwpPzHi6MMKM4xgKwU6JfXc1LUtXF7k
         045sPWLXLnH3wwi+OlfZKbOH8CC4JJa9EmOf6xKJ3Dqu3eZJzUfCak2LTZUdvs5u5aRQ
         7Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb5bd9sGlkaevgxTq4hdZdG/RlKcCqkshVMsKpe48NU=;
        b=O23Xz4ZBprf8zq5pvjMd7X3tbbVXAAdJeaDJQbl04Xc2ZNTJXPZOrPA4X9xKvbwvLm
         Bv0kgF1yaS/kxD3cHzb4pEE/H/iUgJ315kAouG9pAkfpz7NWhBJTexPCFSsOJsGriLNQ
         0vLGD6c0A+2Klz2Zg7wKFXn4qBPvyerCvrIPatNvLLozoybwUchSC5Zb4gAaPrulot3h
         ZzE4yWMvNfiz1l0wTBzDF3e1Mryk1sCRQQjO1K6IHoIEdCua0LVh3QBKttObZM0VvA8x
         mY3u/+JRzMpEvAnW1V8y7kQY+EwmXLyC2pwrMNQpz9NN5NNySY+8k2/moa9L3sAkIKBK
         VpMA==
X-Gm-Message-State: APjAAAWLL9UESx8vbggjQrVRbgVMJcydWe3y0St9AH5tLoSq2Lbv3JwH
        XreJRSHkMJpH4K2D7TUO5PJlq9gUg68=
X-Google-Smtp-Source: APXvYqw7Y8w8DbFuUJbcyIGZoYFj/PCv50VZkfJo+qj0W/t9rp3sqcdt7jUil2BUEBEcEp6Nd/jQdg==
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr3380279wmt.147.1565887134413;
        Thu, 15 Aug 2019 09:38:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 11/36] timerfd: Make timerfd_settime() time namespace aware
Date:   Thu, 15 Aug 2019 17:38:11 +0100
Message-Id: <20190815163836.2927-12-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

timerfd_settime() accepts an absolute value of the experation time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 48305ba41e3c..f9da5752a79e 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
-- 
2.22.0

