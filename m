Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC117D486
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCHPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 11:53:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCHPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:53:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id w12so2963363pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5IVpkp+fyASro0E/9D83qXZo66KVoFohVNxfCekD1g=;
        b=D0CbxtqWFEDzUvuVzCtLmKBd3z4BY5IxuTmcAB81Cxub4VTxOMgiRgc/MNKE/xkQyb
         W7jhAB46LnnVDDUhAKN0wH8ZS+ESCUR4+RzyETnDHpHwnIA+sSPFQFqz4qHvh5eQMnCa
         FQI+g6O95nfQsLnz4pCDChSdLjotmBqYROhX9bp3Sq39SPvuWrhSOPiWIuhfx+9yv4OB
         mfO9QcKRNJhSa+riMcDObo/bAaN3GDT+7vhM+K97Ord0SPFgdmdjEGTVYMIxbdUwyIjV
         MDCZPGp4Z5WrSc0fL7QveflKNkkaQriWgHuSTYjrLD9O8ksp+F3g77wsN+N9RqFchk4z
         gLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5IVpkp+fyASro0E/9D83qXZo66KVoFohVNxfCekD1g=;
        b=CfI/L6wHnnORhSIiXRLxM3OjW/oC4wXXPVfTxvYWqZBftOuD+vBt56EKJ0s4BBXse3
         pqwqYhn7e+ncCjEEEzbgYuyvqhALFTQoSDbNzUjliKJf1SiXCpzI0EdQgwSVk8l9mKGN
         eXSf4DU2GLECvvHbBLav6FyFl46ba8R/ND5oVhENw88ZtBKRu3/a+XvG9lDFSwygzHB+
         m9L9FuEDjHusFmeJINLglST1s3zlTTmFzALD3rdIEA8Fv8Ip1kvL8qzB3rTlG1tlxl5a
         Q8MP5ykf0mR4cXLBX77Pi6kOx2FdUB9nJs8iYYaXpymgBzZA4GvXSnxkXHAl+3Uij3zQ
         oKGw==
X-Gm-Message-State: ANhLgQ0eGrxRVB3VJvIEcHzkpUpxMXmmBegmFf60mEDkJ7CbTeYeZ1rH
        mcvK+gSTn9K8DDipj9G/Sc8=
X-Google-Smtp-Source: ADFU+vsU1/L6T5B9WflOtlOlbFdYDGaAiZhTbvUqpIMov96u75fCDz7NoaUVPqjtzNgp9T3pkCrGqg==
X-Received: by 2002:a17:90a:d80c:: with SMTP id a12mr8221590pjv.13.1583682808932;
        Sun, 08 Mar 2020 08:53:28 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id y9sm15729461pjj.17.2020.03.08.08.53.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 08 Mar 2020 08:53:28 -0700 (PDT)
From:   qiwuchen55@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] sched/fair: fix build warning about undefined test_idle_cores()
Date:   Sun,  8 Mar 2020 23:53:12 +0800
Message-Id: <1583682792-30844-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

The build with arm64's defconfig:
CONFIG_SCHED_MC=y
# CONFIG_SCHED_SMT is not set

Trigger the following warning due to test_idle_cores()'s definition
missing:
kernel/sched/fair.c:1524:20: warning: ‘test_idle_cores’ declared ‘static’
	but never defined [-Wunused-function]

Move the CONFIG_SCHED_SMT ifdeffery around test_idle_cores()'s declaration
to fix it.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84594f8..d11d965 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1520,8 +1520,10 @@ static inline bool is_core_idle(int cpu)
 	return true;
 }
 
+#ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
 static inline bool test_idle_cores(int cpu, bool def);
+#endif
 
 struct task_numa_env {
 	struct task_struct *p;
-- 
1.9.1

