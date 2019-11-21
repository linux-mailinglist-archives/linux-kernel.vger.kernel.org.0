Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D6105B76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKUU7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 15:59:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34779 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKUU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:59:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so2255664pgb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x//g3D21vWGwG/RhBLblP0rKHJ6VZUOUfN3oNVWDiSE=;
        b=AdABsZCcbIQ8aoHaSiA/rvUkvcPJmtq4tu39UN20wmpAbVG1MDIUT4p8K79QZPUSmb
         EyXvohds5Av26WQgVdpWrigT2nbudNocuWQby64DdQcXKmlOo2TiIH8V5Wi9zLQoVcUu
         YFQBYdeiBvgsd1RyYQNGMPgQrO+KDtP8sj4TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x//g3D21vWGwG/RhBLblP0rKHJ6VZUOUfN3oNVWDiSE=;
        b=M8OKDGDv039NGKj9JCLhFlijG7yMq4m5SvbfB+MPmA2t6PVnqZg05XQdVfH4mzeeN4
         QISGWqAyfi+j6xqUVkV1ekwYKdkIP6UJqc6++QEEUlgHl6ru7UP1L7bnIsVC/zT7wt/G
         SFBaUY49iAVpoYL0bbMjiJeQfgiuG/yKiu3iTrC5j/VY7L1s6ysMt2OLWG54W9lKiyFU
         SOQaVnsHz/wfCB18xIhWJpodE0/tPKwY//v0o9ofhir4RMYa0CHKsEDch8jMjMbhFjZl
         UT3yFxd8zHd47MqIo5kSGqWwByPqfFSFQnh47MrsQdSnaNqIZuoiW0HT1wJovB3f+JRU
         HsJg==
X-Gm-Message-State: APjAAAXhkf5FVJJYcAj7CPOwKPpa/R2VvN4j59QeWozNuBB9tYkg9TlV
        3l9D7/W1q+qoNSB+pH32RjObAiUquTc=
X-Google-Smtp-Source: APXvYqyoGGbWlOrUmiQ8o0JX0y47aJlot9boTCEE+7VAPjX6m1wMJ7G5jEbqeG6IKlEbmnvQM9EVNw==
X-Received: by 2002:a63:c013:: with SMTP id h19mr11906094pgg.447.1574369972528;
        Thu, 21 Nov 2019 12:59:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e7sm4564530pfe.173.2019.11.21.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:59:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] docs, parallelism: Fix failure path and add comment
Date:   Thu, 21 Nov 2019 12:59:27 -0800
Message-Id: <20191121205929.40371-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121205929.40371-1-keescook@chromium.org>
References: <20191121205929.40371-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus noted that the failure path didn't correctly exit. Fix this and
add another comment about GNU Make's job server environment variable
names over time.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/jobserver-count | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/jobserver-count b/scripts/jobserver-count
index 0b482d6884d2..6e15b38df3d0 100755
--- a/scripts/jobserver-count
+++ b/scripts/jobserver-count
@@ -24,6 +24,8 @@ try:
 	flags = os.environ['MAKEFLAGS']
 
 	# Look for "--jobserver=R,W"
+	# Note that GNU Make has used --jobserver-fds and --jobserver-auth
+	# so this handles all of them.
 	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
 
 	# Parse out R,W file descriptor numbers and set them nonblocking.
@@ -53,6 +55,7 @@ os.write(writer, jobs)
 # If the jobserver was (impossibly) full or communication failed, use default.
 if len(jobs) < 1:
 	print(default)
+	sys.exit(0)
 
 # Report available slots (with a bump for our caller's reserveration).
 print(len(jobs) + 1)
-- 
2.17.1

