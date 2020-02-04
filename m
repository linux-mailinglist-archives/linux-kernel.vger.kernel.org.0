Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A2151BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBDOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:04:31 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:42237 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBDOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:04:30 -0500
Received: by mail-wm1-f73.google.com with SMTP id d4so1214808wmd.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M5QDlwOFPFeBvx3bqm6hRs2LqKGsL5jmQQoVlW04gqY=;
        b=gXxL5y/8ZfoayNMAanpmqonkztj0S52rqHHImIicJ4MhhNjd31v/0u+t+Y2lCEwB3t
         Zrd/23x/Xjx0+g+Dgd/aAFkA6ASHh249rtjiWvc/dsRzgY10FHepBVnCn+gT+vYW9Rsg
         wLX+HTdvdRWkKslS9QdFL1cRoYBC/l92f/srw+Q3uOctBJR/VPLTOldRXYmqtPknk6Pu
         /LeRYhvKTYXFqHj0HutDNSGV5aNaGuJxADC5tiTiYiOCAfzfyRPllYx/pv74O+bPep+a
         KayVQeuq6SWYLqoi6TvPXuSRJhgcgJYFX4Ryoqovfx8yTP6KOUePBc1YGzcd7ftFhPEc
         C3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M5QDlwOFPFeBvx3bqm6hRs2LqKGsL5jmQQoVlW04gqY=;
        b=mR0DaN9oZhAnB2eRSIVNna6kmm9udCBhaaa0rQfqtsiapSQhUS2DUTj9LU5Xg9FMdo
         kU7i5tRN7HZrQVO8GKlJGzXwH47ehaKrEBQpUUa0odoFtsXldVbLt/MbYcaUNh2MT1Rk
         f2oNhm1dHDTZwOqbdHQp/A82IeQW5hcCA/Wz68qdB4aQPdvncmLK+l1hQ6PePbt/Bb+N
         zYLFnxNjUJn45V0HQJYnleI3u6Gg3tmyNA0hC5oOzJVSkm8IP7HLhipTW40g/xjuU/ND
         idZemZbVXyfr5iCRQfatWlJS/uP+z4F4ZT9rIrQ4aqhJ0oGK1kpHJoMJZea9peiNHWaq
         PprQ==
X-Gm-Message-State: APjAAAWD43DZ/vSCmxb09lZUlAPM/gc1bn4w4hKKxReMbjNmrxTOv38L
        /tCvHguViUexMmwqmACUslBpRPhTEw==
X-Google-Smtp-Source: APXvYqxKXMV8rmeLGLDkEfmXBf+98I1ti+BY60d88Xy7gAfqeTiHL6Th4QBvxdjjVZBKP99VcfUCl4F1Pg==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr16149162wrp.112.1580825068609;
 Tue, 04 Feb 2020 06:04:28 -0800 (PST)
Date:   Tue,  4 Feb 2020 15:03:53 +0100
In-Reply-To: <20200204140353.177797-1-elver@google.com>
Message-Id: <20200204140353.177797-3-elver@google.com>
Mime-Version: 1.0
References: <20200204140353.177797-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 3/3] kcsan: Cleanup of main KCSAN Kconfig option
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

This patch cleans up the rules of the 'KCSAN' Kconfig option by:
  1. implicitly selecting 'STACKTRACE' instead of depending on it;
  2. depending on DEBUG_KERNEL, to avoid accidentally turning KCSAN on if
     the kernel is not meant to be a debug kernel;
  3. updating the short and long summaries.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 35fab63111d75..0af6301061c03 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,12 +4,15 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: watchpoint-based dynamic data race detector"
-	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
+	bool "KCSAN: dynamic data race detector"
+	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	select STACKTRACE
 	help
-	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
-	  uses a watchpoint-based sampling approach to detect races. See
-	  <file:Documentation/dev-tools/kcsan.rst> for more details.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic data race
+	  detector, which relies on compile-time instrumentation, and uses a
+	  watchpoint-based sampling approach to detect data races.
+
+	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
 if KCSAN
 
-- 
2.25.0.341.g760bfbb309-goog

