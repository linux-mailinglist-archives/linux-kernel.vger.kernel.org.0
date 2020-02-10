Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DFC1579FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 14:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgBJNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 08:19:33 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50428 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgBJNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:19:30 -0500
Received: by mail-pg1-f201.google.com with SMTP id q4so5394395pgr.17
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 05:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fp6MtkUYwRFvvO6uysN//Mlb4ErU1o3j/TgE2RsZDqc=;
        b=SCqH2t8UW6xatENC08Bks3adEsYcqzl2ydiPjVd95yGYrm1qIPiqIPbJGbPVxOF6N2
         cXPbr0IBQt6dB17hHDgfd7lRJkGVI8DYoUS5n63DYtkgFOIwvdhZ4zPcFPoI0T3hy5Ru
         6h8p3HBYl6detqUKT0QbLofddrSssB4yFaWoDFUGUSGu97IlPbNCrhSuGmYn4FHcG1Hu
         puJqSk26531IpGVb/Z3XJbtj1Anubf+qN498+feR4jcBVrOGxmmypaTnM+V8YSvdXS+8
         SHA1BEgWGjY6fO803XdXZJebU+i8hOLqSyWNeDAD1CXw0/l1mii1pe9nnC4ZqkDQ7Czy
         dtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fp6MtkUYwRFvvO6uysN//Mlb4ErU1o3j/TgE2RsZDqc=;
        b=po8NAZ8yBvrGYibyt9KVc64+cpZmIJtKAgD2PzX1rP6u2NVo6nOfpGDzMvgIZvbXJh
         1i7LGsfwfWeiytDPQaxNNdUgB+U25W5Y4yqSNKKKPzm8EBfKcRkZqkVOtacxv3eloOoK
         UbVffVkQ/nPWxnVm7EIGHREdk7KsSwp4vMUpE4mt6EbYF4eqPPxPpc/SOsAeZakliE5D
         5GpRRAZxBe6rmy1OazuUTdLoApxjzYFTY1ekp0zAWi8keDjvxWi6QRTbpatPBi8AtE8x
         I7awFKtrhKe6SeQpl5ka25DOrQZjBUIH6L+TdkvZKNrRKbYQygbNZG9MBz/p/iR+eHdD
         da1w==
X-Gm-Message-State: APjAAAVOA6LNjzKUujyqHGtDDTilxKHoBkIKki1FtV0qkJnAqvRyDHj8
        Vii40Rix9qdZ7J0duQa1uJ4dNMZYTnjjbRymGas=
X-Google-Smtp-Source: APXvYqweHMPn9EpO/hdGK4qeZV47ZWtBbfoAGJfRDlgtpjNgGjfNxpzn3TtErZABuInYR5PUZtGfkXcKDV0cYKcp4Kw=
X-Received: by 2002:a63:ed01:: with SMTP id d1mr1488010pgi.95.1581340769935;
 Mon, 10 Feb 2020 05:19:29 -0800 (PST)
Date:   Mon, 10 Feb 2020 05:19:25 -0800
Message-Id: <20200210131925.145463-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kbuild: remove duplicate dependencies from .mod files
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_TRIM_UNUSED_SYMS, if a module has enough dependencies to
exceed the default xargs command line size limit, the output is split
into multiple lines, which can result in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and easier
to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a1730d42e5f3..a083bcec19d3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -257,7 +257,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif

base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.0.341.g760bfbb309-goog

