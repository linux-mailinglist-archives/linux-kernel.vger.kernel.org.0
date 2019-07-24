Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C267342C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfGXQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:48:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40445 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfGXQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:48:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so22183729pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRKAY+MZWKaqd0CuoSyZlDBPmUfGcGm8988bda4hVss=;
        b=uaGBcyfDCm3TTg2hgJyfh2501WHhM6A8JDweTlaQFVUGuJ6Ekd9vkgtWwjLp2xuYbs
         w31WEox/uK++rZpnzcVXYQC3Z58XUOEv1IySt81cZPSUZMQcF3MXA+8A4fs7oub651dj
         FplFBDvJ3JJ/RWNd/FCP9VaI9K9cAUJFyXu/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRKAY+MZWKaqd0CuoSyZlDBPmUfGcGm8988bda4hVss=;
        b=YUi4DX7mY0R4vcAnFUJ6t6GstQ0pvmYlY/4nfVnFRBk3F5Z6hRh1/OcbViQdzycGtP
         5RMbhMzdUVnFAZA4U7ZIHCreB19XWhLUKneM0zaXGkRraIyNpc7fAAKULLOvPKIf2QaL
         FiWS86cRt5L5tIA6afQWopEIr0IALtKcN2k6NHLzWjOuLP6Z8SpRKfLWkFFmp1KJfme/
         y8PGHvUm/lzAyq2N0DrxfEBOx4mdsIK50oHQH9eQ1K5UkUy2UYSafT5z6w5yIZE6RcwF
         HJN2Th+96h2ajg1G7r+QO2JgpYKsDlLorJ5+n1Bl1AJFYbROaiN18rn6E1r8nNemxTDO
         HqmA==
X-Gm-Message-State: APjAAAXhozIipbbYsAuIKv2w8669B7sldkRqob8uv8bBqqXQOgb2xsq7
        s/9xMSW25lnQWHGxv4FvcnL+ZjsQ
X-Google-Smtp-Source: APXvYqxmKuaKat7f823FoVvgzFEjTDwsr672WnIYsS6sAhsU7sn7o+WU6yHFNUJVOZCVzd6xfNA0mA==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr87959674plp.241.1563986902928;
        Wed, 24 Jul 2019 09:48:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v7sm4148876pff.87.2019.07.24.09.48.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:48:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] pidfd: Add warning if exit_state is 0 during notification
Date:   Wed, 24 Jul 2019 12:48:16 -0400
Message-Id: <20190724164816.201099-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously a condition got missed where the pidfd waiters are awakened
before the exit_state gets set. This can result in a missed notification
[1] and the polling thread waiting forever.

It is fixed now, however it would be nice to avoid this kind of issue
going unnoticed in the future. So just add a warning to catch it in the
future.

[1] https://lore.kernel.org/lkml/20190717172100.261204-1-joel@joelfernandes.org/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 91b789dd6e72..349f5a67f100 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1885,6 +1885,7 @@ static void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 
+	WARN_ON(task->exit_state == 0);
 	pid = task_pid(task);
 	wake_up_all(&pid->wait_pidfd);
 }
-- 
2.22.0.657.g960e92d24f-goog

