Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5083C14606
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEFIVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 04:21:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43954 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfEFIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:21:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so6082311pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybIiqJfLE2MLl7jPAgW081LP7KxnoAkO9g1BwAPI45g=;
        b=gwjNoxfLwHayA9JN5g8ixh+8cKbp0rktR3KK21XARyP0FhC4lQk3IfgrIu2eKkt9dW
         WMZl3ag3v54M796Wx4O1s++TZv6LP0Pi+OyA6dWHaXFxZPmaRzzgak877bcq2nlekW5U
         S/ghQF+YsegjG7veWhKSJ6LZoWuph2EvQ6v6e/wfO5ldM//kj4b+KdX7N10vWXNzL6o1
         s5FOvL9T6z+s87+ukoE/QQKfoQDQKia+7plojPHEpF42/lc5aQdvBEDkoJutX7NvgSHX
         6EhwFpFnBgywHEa3cDcZus4EVzUIzacjVYdWV0ALGZrAbE2ZwqnWzMp8/LdXTbYt4eyK
         UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybIiqJfLE2MLl7jPAgW081LP7KxnoAkO9g1BwAPI45g=;
        b=qan5BiSq2Xfjjw34QbTaXy2n87fVyz5DmhgbW/7kBSBlMJTjwliPoGApHbNblhqRPO
         0hbYz9oT/afh3WPuMG9Z0o9/ILhGz4Oo4G4LZv84/Vqw9YmmjQjpMbLhHcoBI1d8pZsp
         hNcDMG2qObmCzqONVNbtwkAThVv3twdr/pJgNyp8hj2mLbFaN91wQVHQq/ozibnpq8c1
         BPTeCQVqV3ljSGcYPSJfblLLa6vh/Cb+y761CA9KXL/0hx4rg22phl3bQveo5aH+EJK4
         7o4ExW844BmZd/Ku9QCkSnAQzYc2GYHfk/Lg33Uq3s1P/xRvQHqgNY3mbJV5xHmHXNWi
         4tgQ==
X-Gm-Message-State: APjAAAUEQ71P7JZyt/k+4Z3O3RCzUYC15oIOgLU2ZXLi4WkythJ7/BK+
        gvGaHpYOJnv1b6HJJoJNy60=
X-Google-Smtp-Source: APXvYqyvu+MOMiV1sU+zR5eFRr6SHsO8XgP4PVqB7bfmeG1e5N25r2hVjeNTJiXr6ItijCekzYYjtQ==
X-Received: by 2002:a65:60ca:: with SMTP id r10mr30530869pgv.64.1557130863547;
        Mon, 06 May 2019 01:21:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:21:01 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 23/23] locking/lockdep: Remove !dir in lock irq usage check
Date:   Mon,  6 May 2019 16:19:39 +0800
Message-Id: <20190506081939.74287-24-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mark_lock_irq(), the following checks are performed:

   ----------------------------------
  |   ->      | unsafe | read unsafe |
  |----------------------------------|
  | safe      |  F  B  |    F* B*    |
  |----------------------------------|
  | read safe |  F? B* |      -      |
   ----------------------------------

Where:
F: check_usage_forwards
B: check_usage_backwards
*: check enabled by STRICT_READ_CHECKS
?: check enabled by the !dir condition

From checking point of view, the special F? case does not make sense,
whereas it perhaps is made for peroformance concern. As later patch will
address this issue, remove this exception, which makes the checks
consistent later.

With STRICT_READ_CHECKS = 1 which is default, there is no functional
change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 24e3bca..7275d6c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3234,7 +3234,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || !dir || STRICT_READ_CHECKS) &&
+	if ((!read || STRICT_READ_CHECKS) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
-- 
1.8.3.1

