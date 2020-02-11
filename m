Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A50159452
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgBKQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:05:56 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:35721 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgBKQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:05:54 -0500
Received: by mail-wr1-f74.google.com with SMTP id 50so7157901wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cb6s7Ebfu5RPXhiJNbGZ/32d/mZmA8VpCnoJgMBlnZ8=;
        b=GbCNMjfcrrfIvaWxV5FmBj9oUx3CANz2wWKYu41yx/O9myFeTCkUjNnfVQvjoeUESq
         7q7x3G1dXykGYriq1igYa60F0jg+pD5nX8qpJvvXsP4U9WsUoW7TqfLYK5F7k5wndjUK
         WPs7tlZDcss6OKNeWiqETiqdYuuD0jR8SXJJVqHLarW9xKML7c0CfUOqpby7sNMDXvAj
         uvkhHtGMt0oSOoodDSwxoQMuZvKRWo+40sKEznae0KnATD/Vl/b+TCYhEkIWTbh5hn51
         HzhoQUsYVQJO+B+nA1zWLfFTyTdwr4st7rJ2pBZzi+oozEXKulKMPrpb5amX1bnFEj1F
         ka9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cb6s7Ebfu5RPXhiJNbGZ/32d/mZmA8VpCnoJgMBlnZ8=;
        b=tdHfm+syPAd+Hvjg8dGsbm+8FDFiQATq24jH4sy7JY9kPwEQZvXXQ8DXW2spfyNOIF
         uYR1pfof1B7BPxuem97aHraIk7PPnPN/5XqMOBxXk/SauGpWfcwmQp2Hx1GNe6FtUjbE
         p7fOvtDkGIxCIdf1sdRGqwqe4qiRcIu+EL3S4BlGcBlCyP46ScZhpcvLxiRFXaiKmyMO
         DdYDq1mvgJfwODorPdHwCQAFL0ttmq6kkkqidYIW6uG1JFuDFzgrchDU5Vew59zeK9Dy
         XI5N7dopRa7b+RWP7vAvhCy4fOteujtH3m6c0I0UZoUg0A98sFXwcpxu1d+H6W6CNFNJ
         ZVuA==
X-Gm-Message-State: APjAAAVhcZN0v+9MhkjN8HPsY1r1rXBxogsrqq/LacOkp0QGMyLFB6le
        mA2pahWf6FdNqmzgxnRWT40mop2uKA==
X-Google-Smtp-Source: APXvYqzmtYclA5t+thb5Lc487PY9gJoRPabnJAo14JP3889nCxen4gs7ZBfuFTiIxjJXun8WRVDNkZKv5A==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr8969859wrh.49.1581437152757;
 Tue, 11 Feb 2020 08:05:52 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:04:20 +0100
In-Reply-To: <20200211160423.138870-1-elver@google.com>
Message-Id: <20200211160423.138870-2-elver@google.com>
Mime-Version: 1.0
References: <20200211160423.138870-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 2/5] compiler.h, seqlock.h: Remove unnecessary kcsan.h includes
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

No we longer have to include kcsan.h, since the required KCSAN interface
for both compiler.h and seqlock.h are now provided by kcsan-checks.h.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h | 2 --
 include/linux/seqlock.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c1bdf37571cb8..f504edebd5d71 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,8 +313,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
-#include <linux/kcsan.h>
-
 /**
  * data_race - mark an expression as containing intentional data races
  *
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 239701cae3764..8b97204f35a77 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,7 +37,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
-#include <linux/kcsan.h>
+#include <linux/kcsan-checks.h>
 #include <asm/processor.h>
 
 /*
-- 
2.25.0.225.g125e21ebc7-goog

