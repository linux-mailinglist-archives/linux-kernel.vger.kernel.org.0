Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71811D0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 16:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfLLPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 10:17:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45860 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfLLPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:17:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so708686plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=Oy/hnAfKot6VhCvK2GN/HZUavI/Bja8s76lKRFwKNBv0WIvnCj5sLr9ZUFoKKK76Dq
         AkA3a0Gw6AOkyVQzcYvoeV5MXxrSNx2unPqwyUoCbUMuiZl/g4FMJhMs0cyeCQ3Vydo+
         KwGV35RCEfpO49yPJJQpSRyKsjHcIIme8tAQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=Sa54sM0lahN2UEO9AEoThRVNBeHr3qJTVv8c5d7emtIcZxnXE0pitNcZO2oXI9Atga
         5CWRhBDlzN0zhpw+DxuPHuz7tfypH2iqVdy63BMH2nfESEqJK4ULZnd9j5D6odwnQyes
         egCIJ+NFcH8YCU0ih1lye8POohcU/m2vBbMD13fdYvuT6MRDWX0I/F97N25CRkxE1Ms0
         43e/riUd5FsLtX/0O+xeWarsCI+7xSwsHaWn2pdl8N7hwwyuHd8B3oD7IamEl03mISNN
         7Fepx1U11Kq1jxHrLWOXCNaAgio8ND6w5HVN7DZOVJLaELM6iVwGxTrvNYA0kzNBkG0R
         QzSg==
X-Gm-Message-State: APjAAAU4eJcRapf0bh0fuvUwbUSSDifHOJRdAjUr0oV6ItcVoiCIUPyU
        aNXolAeiH2SeXEnuIYjP+ZQYCoF1RAw=
X-Google-Smtp-Source: APXvYqzz48JuwP9N8SZ0OoCbH6UPHPyZNtr3T/0k0wqNH5ZMJMS9Q3ukSiv5ZYA0ARsYtgHZT5+GZQ==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr10744727pjn.113.1576163830706;
        Thu, 12 Dec 2019 07:17:10 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b116-2689-a4a9-76f8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b116:2689:a4a9:76f8])
        by smtp.gmail.com with ESMTPSA id j125sm7954574pfg.160.2019.12.12.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:17:09 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 2/3] kasan: Document support on 32-bit powerpc
Date:   Fri, 13 Dec 2019 02:16:55 +1100
Message-Id: <20191212151656.26151-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212151656.26151-1-dja@axtens.net>
References: <20191212151656.26151-1-dja@axtens.net>
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

