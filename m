Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473EC157DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgBJO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:56:47 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:52388 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBJO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:56:47 -0500
Received: by mail-wr1-f74.google.com with SMTP id a12so5104507wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AzV6vPSa86ml6UzbSmsHU+/6rSkAmcJ+1ZtL4VXaug0=;
        b=UshsyR45Cqv70fELz9IbfMGkstPl7FptkZ5If5fpgDKm4Yz1yPoj8+VOatOfcSUOtD
         TO4HLIljgtBYIx8Oq8goc5pb9LsM8WgITaKP6hnKTz8f17xAMcGQAmttjtexwPZLZccA
         aNFBQ2wp35t+t/majln3Jeqbjx2yEvjhed+raDJvUSkQL/OptD228JxiPF/OlXER1VEL
         ahEUYLYzouAePA19fOv/fKacS2krA1vcmGxlrXUD/QvM65rFm4KBAsG4PItkqhsrF0jr
         T4xG6R4ozHXBNinfxrphSnbA0GorM/317cWnTCDJzcr+CteMDkjNNc+Jnbfevo5EU+/U
         4V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AzV6vPSa86ml6UzbSmsHU+/6rSkAmcJ+1ZtL4VXaug0=;
        b=kZYy55g4SlbhqIJffnnz+InwaGXD0t/pwpSWHfDm9AUCQLjKSwyFnmyYTc0mAnXguB
         oz6Z4/u53U6hfE6Wazee5IPd04AY0qnhXsq6DPninc/8/Ykhwq4VGgkcN3U8fECjMSoy
         uF6BQG/khpbs/C3KKHTRtIlOkS76s5hRkYccTdm8nNzeVIqhsbNSLFKx410cKe7R/eDO
         PYlS5uj5X9EgnAYKfZnVINhXfCVkFO1YoWtk8vZSsJBvqkmYXBZMXOPAhkRMXJyzODws
         Ff5njmvNZNXgdsDaPN8k9/jZX5k21HZJ2fs1uJcblzeXpEHu9txzrdFBRXZmwvX7HVl/
         ErXw==
X-Gm-Message-State: APjAAAW654RUgO77MMvmFABLfacQA0nYEoiZjRmVWOrVakplrjuDBjwF
        tuti8uqEpSCEQL3iLgNGCydYSmbHEw==
X-Google-Smtp-Source: APXvYqyUHzXsrv6rBCVacFnD9222m5vkt+ebpOecDw81J+fWhys5DSme8Q0Mp0iQTJGCH8tBpDWS7BDbRQ==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr2378246wrw.265.1581346605196;
 Mon, 10 Feb 2020 06:56:45 -0800 (PST)
Date:   Mon, 10 Feb 2020 15:56:39 +0100
Message-Id: <20200210145639.169712-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kcsan: Fix misreporting if concurrent races on same address
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are more than 3 threads racing on the same address, it can
happen that 'other_info' is populated not by the thread that consumed
the calling thread's watchpoint but by one of the others.

To avoid deadlock, we have to consume 'other_info' regardless. In case
we observe that we only have information about readers, we discard the
'other_info' and skip the report.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/report.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 3bc590e6be7e3..e046dd26a2459 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -422,6 +422,26 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 			return false;
 		}
 
+		access_type |= other_info.access_type;
+		if ((access_type & KCSAN_ACCESS_WRITE) == 0) {
+			/*
+			 * This is not the other_info from the thread that
+			 * consumed our watchpoint.
+			 *
+			 * There are concurrent races between more than 3
+			 * threads on the same address. The thread that set up
+			 * the watchpoint here was a read, as well as the one
+			 * that is currently in other_info.
+			 *
+			 * It's fine if we simply omit this report, since the
+			 * chances of one of the other reports including the
+			 * same info is high, as well as the chances that we
+			 * simply re-report the race again.
+			 */
+			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
+			return false;
+		}
+
 		/*
 		 * Matching & usable access in other_info: keep other_info_lock
 		 * locked, as this thread consumes it to print the full report;
-- 
2.25.0.341.g760bfbb309-goog

