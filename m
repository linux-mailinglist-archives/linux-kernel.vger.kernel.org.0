Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4029C135384
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgAIHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:08:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37910 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:08:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so2182606plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=pDcMswX2WqLuZ2zwtGNOX8ZMSnngOYELKXS2rxZtVn2Hc7xWg66Hj5z15rqh53IES9
         o+F/RvS9jzIeAGvcVkvywdpJF6qGZZY3AO4H6XlhPLZt4Lb11wRasFUfONJEfbCg/DRL
         B9pVhEjhJZcdZlwBqFEQch+Xg35ywvGnsJSZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=cjiR9paymBmisodYWgWdGgxoHzHJlfJKwI1c+/4DsQLnUDKTkwdTj3AtX9RAdL1yZi
         oYpavNgdylwPHeLv2hqrCSPLB5mWW6ybzo++xKs+bOqsviXTeCTVD+uRsIMZP1obR58G
         DpwCnUH0E/EOPfXGDOoJE1VHxhSKv77m0mELxsYqi64LlDecRF8Ge3CGvU28jnBbb35z
         aMdSzCqXev+9TAueaP2wbLd9pL/0GzRvyvxkHevhXUXv8GLSn32j8Mgbqu8yWuM2/2Gu
         yjHtAnGTfSoioxDplmwsOvvrfWUY/3CG2HuDvDq9xOwO+Cs8E5g9LufPVkUOVQ8QXIdF
         Lxsg==
X-Gm-Message-State: APjAAAUvq5A7ZdcXmVSRoZeLQlnaOpKiDb4VjQWdbq/aDRjWnM9VaCeO
        t3q4HBtBEoxcCP+vSW0ZU8JmaaiJ6ys=
X-Google-Smtp-Source: APXvYqywxIqFoOPGMvB9RVsdlu3xJm9YODiUa7+jEutjKdj6cX8j6hc+1jzmzD4D81WIsNdHfBK2iw==
X-Received: by 2002:a17:902:788d:: with SMTP id q13mr9716939pll.210.1578553705849;
        Wed, 08 Jan 2020 23:08:25 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5cb3-ebc3-7dc6-a17b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5cb3:ebc3:7dc6:a17b])
        by smtp.gmail.com with ESMTPSA id 3sm6228356pfi.13.2020.01.08.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 23:08:25 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 2/4] kasan: Document support on 32-bit powerpc
Date:   Thu,  9 Jan 2020 18:08:09 +1100
Message-Id: <20200109070811.31169-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109070811.31169-1-dja@axtens.net>
References: <20200109070811.31169-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  3 ++-
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e4d66e7c50de..4af2b5d2c9b4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+architectures. It is also supported on 32-bit powerpc kernels. Tag-based KASAN
+is supported only on arm64.
 
 Usage
 -----
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..a85ce2ff8244
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is not currently supported, but modules
+are.
-- 
2.20.1

