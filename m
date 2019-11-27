Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA9710B764
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 21:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfK0UY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 15:24:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34225 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfK0UY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:24:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so5669305oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 12:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6aJoWQihiHVsCp0vDw6arfz/X9qrDB9cPyNOPVpy++g=;
        b=e0yR8S6wppcdxtKykSwBVUpDqtuNjzu7PRfhIfPhMbyD4L8PMyH9PzOxXzL6HEi3zQ
         cr5WkfGizyNFT0iRh+zjrt8TQtpCmomtqwx5yTnpJ5ys8kA8YL7h/DI8Gx3sg7Kmtap4
         Sro1P5teiZTOB1t3LGqQ/pA57YhNA8D7esmVKFdtLUMhNkZMoqwIDCdwuDj9bD5OL/e6
         A1eamTPJvD9aV/xFbUfPh7M71zeNntOR5w2WVJ6PDh4D5dFWJOjNeDlED5zXxfCrgHB9
         w8Pe6Y8DkJwZOvO3U12hhkWd6kKWUOrlo+j+wHMkx0Mi+UrsJZKqIS1Hx0MQooAun6Yd
         UcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6aJoWQihiHVsCp0vDw6arfz/X9qrDB9cPyNOPVpy++g=;
        b=GrozpnfdLsr64HVM8SU2aePb+5oxbUKhRdW7kEwZIoczs2afgI149FBPQzMp+Lv5ch
         OSrpPspcyqzXuBy8SOThzbJgAP3NLpsxT56TcsvLdyaAC+5wf5md2xFcbp9wLulyKuLA
         b5mvKKof3E7QSRSzJlApCMWKM5Qoj1cpVRLNSUSmkbzMEKa8wwdtPzCglNADHxrql3yr
         n0IU0s1n+Rxz+WPMqxRbtDGX59+IX1E+pZqS+jD0tiVIoFerBN2EtlnYVqqiCyYmqkHw
         aBhhy3GKVZBRDm6eU3X7eEMMWqwyHAFBHB+5sCuCvVxQWM75BhVapsXpCD3kJGAj0kcS
         LHhw==
X-Gm-Message-State: APjAAAV2GbWYwprHUQJAoqVveYELN2HYck6W1AVu4Y1YdoZma8lGBY7n
        lf4fs4fWI6xZRU0ASvgkd1Q=
X-Google-Smtp-Source: APXvYqwFNbupMxWxjjf4cdBJnjHXvS549YcDHbT9ozNaK9vtjMjLLeU9kCQkEfQKhVnd4vfgBYVmWQ==
X-Received: by 2002:aca:4e91:: with SMTP id c139mr5885205oib.142.1574886296910;
        Wed, 27 Nov 2019 12:24:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm5186709oth.48.2019.11.27.12.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 12:24:56 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH] driver core: Fix test_async_driver_probe if NUMA is disabled
Date:   Wed, 27 Nov 2019 12:24:53 -0800
Message-Id: <20191127202453.28087-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
to cover serialization and NUMA affinity"), running the test with NUMA
disabled results in warning messages similar to the following.

test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0

If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
returns 0. Both are widely used, so it appears risky to change return
values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
to fix the problem.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/base/test/test_async_driver_probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index f4b1d8e54daf..3bb7beb127a9 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
 	 * performing an async init on that node.
 	 */
 	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
-		if (dev_to_node(dev) != numa_node_id()) {
+		if (IS_ENABLED(CONFIG_NUMA) &&
+		    dev_to_node(dev) != numa_node_id()) {
 			dev_warn(dev, "NUMA node mismatch %d != %d\n",
 				 dev_to_node(dev), numa_node_id());
 			atomic_inc(&warnings);
-- 
2.17.1

