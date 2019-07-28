Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5076C78259
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 01:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfG1X1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 19:27:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35622 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1X1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:27:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so59805734wrm.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDFX7cmqBbGxd3S+PHtfPokRI/hCi8zxl2i1XDeVF5A=;
        b=fkelgX8XdoxtvqYoZfAkpP78GBVlTDxpHl/XJ4o/w5fjEfhJM7LPQ9Q2N9KZk15hTD
         485XTcpoecD5tBuVSZvXhyehJYJnkSaO7ANtU7G7wsaORab0IWOoB3hIQjp+snQUvbcO
         PQEqICXCUtPsHCe5SSbNV433skUM+MbIX28tDLNLVJIyhpFk14nQFe/VGiOoj7l9jJ9o
         rxZwYM5XAZH/UAsgEypdE4CJyOkiglv3G+6nryECF5d5xfh2D6O1wAHr1nSLKDOeEL6J
         WxQZaq7NkHGFE/4LpsZXmbbfCaYC+aFyPkiDC2I6eHvw3EqVQqNVr6zjeSIZ+6UDuX5W
         7jwQ==
X-Gm-Message-State: APjAAAVUUeKXBMXnVVe4ZqIih+IF6TjRJrna1jW70riqrLvTQeU6VQRA
        K0qClRTSoZ2qVSuif9PVA+eHaKj2k98=
X-Google-Smtp-Source: APXvYqwbGg1c6DE/fHerM+Cvhn2kZX5UU+f9UqfzQyc2lvseyUAQVt6FWzZleWaiLpZ13cuB2B3vOg==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr113674213wrs.44.1564356434100;
        Sun, 28 Jul 2019 16:27:14 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id t6sm65373267wmb.29.2019.07.28.16.27.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:27:13 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hw_breakpoint: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 01:27:06 +0200
Message-Id: <20190728232706.7396-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warning:

  CC      arch/arm64/kernel/hw_breakpoint.o
arch/arm64/kernel/hw_breakpoint.c: In function ‘hw_breakpoint_arch_parse’:
arch/arm64/kernel/hw_breakpoint.c:540:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
       ^
arch/arm64/kernel/hw_breakpoint.c:542:3: note: here
   case 2:
   ^~~~
arch/arm64/kernel/hw_breakpoint.c:544:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
       ^
arch/arm64/kernel/hw_breakpoint.c:546:3: note: here
   default:
   ^~~~~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index dceb84520948..7d846985b133 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -539,10 +539,12 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 			/* Allow single byte watchpoint. */
 			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 				break;
+			/* fallthrough */
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
 			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
+			/* fallthrough */
 		default:
 			return -EINVAL;
 		}
-- 
2.21.0

