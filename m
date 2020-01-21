Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9A144051
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAUPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:15:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40570 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAUPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:15:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so2852613qto.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCABmZHVYBWeM3x/9LF0rRDKV5M0z2Qq/OvnHxMUOnc=;
        b=A/HGba76wHkPknW1GKgRIqNBVwG5zyTkQH7PuT7hAi6eTUL7rOTdmDBsXcPF5O/OzP
         EiPoUNheQgsKjZVBcYicFr0kAXofexSOhcX0Tu/64ZPgy8cDPYo2bZrUH7UWMAB49bMk
         OA+TLw5gfgIIxRdG92zjXeIyZcYgMmfydJfpnVDQteKU/+G2LaIbila9XEouic0zuaTZ
         RacfXMp4ahEQWpRgnwlOlnmU/sdbU7LSbz5FY2vSEOPosFf9cAks4YiT08CKQ5E/RFoO
         IDmhl/zWZFEwt05D4qiQfPaJy7rfoUGhXPcyyLgpifx/bHP8ufd4/5bVNuTxn43KSfTc
         6WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCABmZHVYBWeM3x/9LF0rRDKV5M0z2Qq/OvnHxMUOnc=;
        b=OPYaRM0IHekTxEnZ2xh1faKrFR0vFuTsp3XX9U73dnm6VRx7IZ0WpMmRf4CGTuo5ad
         GPci+9OjEIlJopl8v9DDXEWH4oZXdGu/Opx0Tz7kd8DO9fiyJNPW1uhXCUvmpP2NFJKd
         d5h83W8a/nr7jV/QYSi1ZYc5eMFWvZ3FnlBN//ti5lQiWcBSP3ktSDIfiuvjZiN7JNSp
         kwbJ9yocjYRw4uO44SSqCxA/Vg5a4cagZwPqr6HknfoWijh3Z6+AI97ls+XsuFQsrbs1
         HwKb3A+kZUhprN4ATvbpwzfFPB+PoG/BUu5MECTz+T+/Rr/wjB7Na+Ihpy3XwukPYLBb
         lidw==
X-Gm-Message-State: APjAAAU7ZB9ilVaQIDkCHBgpqIZxIOdLdya5PcY6BktBbcLB2XWDwBqr
        t1jJJLKxF2/dGm9NG0m/eepjUA==
X-Google-Smtp-Source: APXvYqyT9doGgTQsZctVtpUAYuDJghszszwC8XZh/ZQvCLlBD7OEWSe5BHS69p0ts3ILwpRinO7sUw==
X-Received: by 2002:aed:3ea7:: with SMTP id n36mr4962611qtf.258.1579619716573;
        Tue, 21 Jan 2020 07:15:16 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x11sm17523438qkf.50.2020.01.21.07.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:15:15 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        elver@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Date:   Tue, 21 Jan 2020 10:15:03 -0500
Message-Id: <20200121151503.2934-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro Elver mentioned,

"Yes. I was finally able to reproduce this data race on linux-next (my
system doesn't crash though, maybe not enough cores?). Here is a trace
with line numbers:

read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
__kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
__kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

Both accesses are due to the same "cpa_4k_install++" in
cpa_inc_4k_install. Now you can see that a data race here could be
potentially undesirable: depending on compiler optimizations or how
x86 executes a non-LOCK'd increment, you may lose increments, corrupt
the counter, etc. Since this counter only seems to be used for
printing some stats, this data race itself is unlikely to cause harm
to the system though."

This will generate a lot of noise on a debug kernel with debug_pagealloc
with KCSAN enabled which could render the system unusable. Silence it by
using the data_race() macro.

Suggested-by: Macro Elver <elver@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 20823392f4f2..a5c35e57905e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
 
 static inline void cpa_inc_4k_install(void)
 {
-	cpa_4k_install++;
+	data_race(cpa_4k_install++);
 }
 
 static inline void cpa_inc_lp_sameprot(int level)
-- 
2.21.0 (Apple Git-122.2)

