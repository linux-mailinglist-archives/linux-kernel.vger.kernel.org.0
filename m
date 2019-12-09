Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DA117958
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfLIWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:30:33 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:43658 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLIWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:30:33 -0500
Received: by mail-pj1-f74.google.com with SMTP id b23so8689416pjz.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bQkMIXCQ6JhHHUfx0puV3Z6acwFjFfU42F7sTftKhD4=;
        b=N8rz3xkqm7uAha+HtqB5j32nTJonEkwcr0XJOzEadMjCIWHfCiKEvNoh98J/2Lq+gR
         Qi17CEKhCgxFtsRUXWRHclvtpbbcrY4TxbZJDRMcjWraSjLzsoSP7DrsHqGz/TudjqIj
         UP1GwdMnaHjBkXi/VGiETx5OOEb1iFHm4BlYMLlRjYvU3viRWC7pDR3Dj54tKtUqG9ZX
         h2PU1JYaxkUse4+qwLV/Ud0ihdxHkdmpiv/DQx/qoy62/RX3V+cHNtKfKTy/vRYv3qWj
         bmhvuupaMh0Jq5B3R8vXCZJATE9KwbXY7ImF4QzuY3/uXSY9TJOnloJ9Byefe1yNMUaX
         mftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bQkMIXCQ6JhHHUfx0puV3Z6acwFjFfU42F7sTftKhD4=;
        b=iXk0ArLCs2egbSm7BrvzcUDRmNoJZpq6pdJ6WgPOKt7kNrOuMRXWYqiZwne21E8x4r
         1K/9/xRieA7X6GGvO7KWopK8ubpznIA9/XBeIegXJamOomGex5mSEq3iQAhL84ujUjfV
         xcpsVSafegNM1Unlo+bZAG+lH7MTDTXTmb0EsLRVyOd5ybAz5uWJjA6FFDYfd2HXZCSm
         7QP6lrLN3+ugpLYumBJPakDFG664HsrUSkPOLP8N/vgyph/XLgcFtGVpmQep0RO30de4
         ezbGjb5NLSaoZ+VkDdjOboizLQVypziz8EEQoC84szI3Sut9Trn5Snl8DxIOugdcmMPO
         +Htg==
X-Gm-Message-State: APjAAAWxwek2yIATrw3T46APYNV8ipjlou0vzFZ8rMjQl+nKGcEddp3A
        lxTCl8pRVfY+4JBnE43U7pGSYdJGyVuNJE/OtSA=
X-Google-Smtp-Source: APXvYqy9Ns8aRyuf51iARYH3cT5wQMtg+MI6dsH5JvrDtiw0Yzf8pOxzCGtsSpTnLbgw5D3otU+GAZuaxkp1CTrW1rg=
X-Received: by 2002:a63:7d6:: with SMTP id 205mr21602122pgh.131.1575930631975;
 Mon, 09 Dec 2019 14:30:31 -0800 (PST)
Date:   Mon,  9 Dec 2019 14:29:55 -0800
In-Reply-To: <20191209222956.239798-1-ndesaulniers@google.com>
Message-Id: <20191209222956.239798-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191209222956.239798-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 1/2] hexagon: define ioremap_uc
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bcain@codeaurora.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>, lee.jones@linaro.org,
        andriy.shevchenko@linux.intel.com, ztuowen@gmail.com,
        mika.westerberg@linux.intel.com, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        allison@lohutok.net, will@kernel.org, rfontana@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, boqun.feng@gmail.com,
        mingo@redhat.com, akpm@linux-foundation.org, geert@linux-m68k.org,
        linux-hexagon@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to
commit 38e45d81d14e ("sparc64: implement ioremap_uc")
define ioremap_uc for hexagon to avoid errors from
-Wimplicit-function-definition.

Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
Link: https://github.com/ClangBuiltLinux/linux/issues/797
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/hexagon/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 539e3efcf39c..b0dbc3473172 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -173,6 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 
 void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
 #define ioremap_nocache ioremap
+#define ioremap_uc(X, Y) ioremap((X), (Y))
 
 
 #define __raw_writel writel
-- 
2.24.0.393.g34dc348eaf-goog

