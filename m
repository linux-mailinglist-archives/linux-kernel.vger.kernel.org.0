Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F71945B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCZRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:42:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56994 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:42:01 -0400
Received: by mail-pf1-f202.google.com with SMTP id s8so5697928pfd.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fVV9jm+DaDXENKvZmf5YNYYS/j8HMXJnii4J97iSW7Q=;
        b=jjLX+CEw2JaIyPdbWaOTKcwNmYDaLzTBkZW5fgA/FeDEdmVrmcR1Rvww5FmJm82DJL
         312xznj4hpWXdbzvtfrO8AlUwf+EljQi1YQ9ixqEyRSzAp4HtDG1wNQT0aYdXG1F4KFC
         TF7MCo9Qkp/Rfr9ZFa+JoaUU9oJx98uA1Er7UWOddNzd+xWb0ofqyF+kpY5A3drMQh6F
         7W3AZoZmjZFrjCUtiWSCYGDDJvCqQOL8TTs8rk8KfS2Jgy+dEPAR0blerEVih6C+trrK
         fbe9bqY5ktVgAayPArnvmZCtNgG5x+W+hN8BPnNzwQRy83Zflg744j/E5KKYGJR6E8pv
         x4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fVV9jm+DaDXENKvZmf5YNYYS/j8HMXJnii4J97iSW7Q=;
        b=U0o0zs8OR6VHT+D6XcWOZPSvFdaFTkV3pI8WepvpJXTMtdoMtNvwwwrlvKZnBHpnUl
         QER+iKsJEZPRk0pB6iGlE6+6DGf53FUTWWPgzfb+0hiGOllZsWZPHJTCi7QuezRReIlv
         YK+j4VhIJNcaQmhpKc5VUPuf0JGMqbjCF7GmS+W9/u1a5OR+CfHeQu8/EGwiJ7em9HMO
         pD59E+BnKTaPNv9wxgc3mm0+yVhkpqSvSZSYxaTuyuaVFybRYQHtJhz9StK/4dyUJAYi
         tiSQrvvTpwqPBbojzW82LfFfgRmISsvP0SmijGLnWBw4mu//de6ONlz+Y2sy7FnKKDHZ
         yH4g==
X-Gm-Message-State: ANhLgQ0d8NK3u8SXtOvy24YS1kgL8Ce/cwlhxB9ApBfD38WmjloYCg7f
        paMzTzaz4jNVgfLpOA6OuFpZMNwfxhrGL2A=
X-Google-Smtp-Source: ADFU+vvOxIgx+P4LZJQseVmq63NA4tSjm0lUd8nVjtuLo7pV6b22Zv7oSTi6DrfZ+KLKpAREJo80e85iBrOWK7A=
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr1153165pjt.131.1585244520441;
 Thu, 26 Mar 2020 10:42:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:41:54 -0700
Message-Id: <20200326174154.32723-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] Revert "clocksource: Avoid creating dead devices"
From:   Saravana Kannan <saravanak@google.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4f41fe386a94639cd9a1831298d4f85db5662f1e.

The commit cause stability issues in platforms where one device tree
node is handled by more than one driver. So, let's revert it for now and
try again later.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/clocksource/timer-probe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index a10f28d750a9..ee9574da53c0 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -27,10 +27,8 @@ void __init timer_probe(void)
 
 		init_func_ret = match->data;
 
-		of_node_set_flag(np, OF_POPULATED);
 		ret = init_func_ret(np);
 		if (ret) {
-			of_node_clear_flag(np, OF_POPULATED);
 			if (ret != -EPROBE_DEFER)
 				pr_err("Failed to initialize '%pOF': %d\n", np,
 				       ret);
-- 
2.25.1.696.g5e7596f4ac-goog

