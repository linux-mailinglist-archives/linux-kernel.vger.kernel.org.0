Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA76617D54A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgCHRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 13:49:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34307 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCHRto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 13:49:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id x3so8046813wmj.1;
        Sun, 08 Mar 2020 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0QkyVCipab/iVvgADLKpSyucbBPGMCb4Gb3OlXlvpMc=;
        b=bLyPXV+bJn7lRY0RoPCoSWMdmTrFH/0ZfiBKg38Xuin9CGUWm3FYZH/9++nJwq0nuq
         5Xb07dyd6dSiklvOalw5Bl6iD6VIOfKzk8jBHVoXPt/qkfFOUj7SHtO09eTQpBV591SL
         mEod4xQ8g6tlSgG+nrimT8mE37RgrcpJ0jn/abc4go9eDoYYABc6LhjhFz7oKNR+m5jh
         gsioy+rMMvdS4+sAGV8w9u7bEts5As+xLKtUz+QGPfKXKsF9YkO75mTtNCnxli1khZm9
         CDXn0sjhNZsu96lixM4+4mO7SsAtU/cWu7Y6oE565DTqPIOS5hsN+ZWu5HXgd0XTXk2y
         YoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0QkyVCipab/iVvgADLKpSyucbBPGMCb4Gb3OlXlvpMc=;
        b=sePBizNgGY7JDG+d2y+8DZLO9XB5W+7Tdc4L/01PhME/cmNLaj10ipaEFHUNvMhGzC
         pRVlXp539jvC3+gxKu0RCfp4h7+Q9ap/kZoH8ztbXVsnv/Fe10sJ3rCkUUhm0DdPxSst
         5wwDJhR9zs9r99E/kiJlrXIFvTdt9jjZlEupHdVePWlCV4LbKAVBrcFiMAXAJUTYn1Bu
         hlza6o7SCGcnyzD1PBV5a4HG2QGc2lZF/Vdssg7Wya5RD0eb4Oe/eF5hgojQW03lJaZn
         uSHrSqfRq9trSjhfw7cm6LSktf5XGOW/zzA/plo0//zB44k/+CxNOQOMK62o6j4l0LWd
         uX1Q==
X-Gm-Message-State: ANhLgQ18mwKZ1XVxlIYkXHLY0rcwKqTWbzcIpF/1ZufJg3myRj4s/4XM
        6RCnNPed3cS8p2/pZkb9i9o=
X-Google-Smtp-Source: ADFU+vsX574pgK7YdEsgAtzH3+SYNKaMf+bVij+6RYE0MsNMilVRxowwmkNhTLouhGdvM3OtJRTwIQ==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr16103701wme.127.1583689782479;
        Sun, 08 Mar 2020 10:49:42 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dce:4a00:35ca:ddfb:aba3:f544])
        by smtp.gmail.com with ESMTPSA id c5sm7386226wma.3.2020.03.08.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 10:49:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH] MAINTAINERS: add headers and doc to SCHEDULER
Date:   Sun,  8 Mar 2020 18:49:31 +0100
Message-Id: <20200308174931.9118-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various files in include/linux/sched/ are identified as part of THE REST
according to MAINTAINERS, but they are really belong to SCHEDULER.

Add include/linux/sched/, include/uapi/linux/sched/ and
Documentation/scheduler/ to the SCHEDULER entry, and order the entry with
parse-maintainers.pl.

This was identified with a small script that finds all files belonging to
THE REST according to the current MAINTAINERS file, and I investigated
upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4869bd91b6ff..3a0f8115c92c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14754,13 +14754,16 @@ R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
 R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 L:	linux-kernel@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
 S:	Maintained
-F:	kernel/sched/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
+F:	Documentation/scheduler/
+F:	include/linux/preempt.h
 F:	include/linux/sched.h
-F:	include/uapi/linux/sched.h
+F:	include/linux/sched/
 F:	include/linux/wait.h
-F:	include/linux/preempt.h
+F:	include/uapi/linux/sched.h
+F:	include/uapi/linux/sched/
+F:	kernel/sched/
 
 SCR24X CHIP CARD INTERFACE DRIVER
 M:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.17.1

