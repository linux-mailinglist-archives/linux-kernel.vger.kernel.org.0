Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8E5C0AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfGAPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 11:52:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37308 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfGAPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:52:22 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so29939821iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljuESl5eqxUihWHOzj/6lzShmRXZDNI/SwprEvqSgi8=;
        b=LzwbbBQ0gRBhhYkuMgF89Uv+5nF6LufoX3jkv984WIcb2X1nlh16MtlHvMTKeM0Q3B
         bKd8T+OkCYWmO4sMkmlmKhlR44ET30TC/mzO87QqrXvo4YFhp7oLYYiJ4vHHocSm1bUM
         mqRhrv9RxXrpP3O4vmYmy14X3dyIhGnlVq8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljuESl5eqxUihWHOzj/6lzShmRXZDNI/SwprEvqSgi8=;
        b=RHfXfjGHamdHOzmSp8sz9DX7bTmXbGpaSAza15JiNz1h70AFaD9Etfx4cOVbDzX+0K
         zKcb7ifhIDZbPKQ648JOgwGbtQfhulVUH3w+HcU4i76PUimBAQVU/kNx/NOU8Q0DgM4f
         8yGDEnHWUKXjfpoD8Z3CZcD4iyV8ijvwjVZ3QL5V8DfRT+KwLNJZ3oBy2VETgbaXqoBL
         yPr6bYRLZOs4DIYMCYkjiAPDAiDYvzjDySuG6N+oLSdDfwooZbGTXJewFr3UfjLZe5If
         U2TIwt4EohM4g/fTaDZWG3uLeKSZw0y3e/EH49II+0MSTKx86MwzblxK1HTcNIyYDLLp
         kURA==
X-Gm-Message-State: APjAAAVmQZcKFtdZvrprexkfuE/5IWfUpiCI+4948F9fDI4CnX+fN65C
        WUWfaANnlUKlvtkYjJk9oXeLdi8aC6A=
X-Google-Smtp-Source: APXvYqyfFblBR0Kj1Belq6sAPmcykm9CPNFTjeydqt9mnH/MtE9y5chC1j/e8ZgbzbBiRDGYiyRaUQ==
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr28517852iou.69.1561996341165;
        Mon, 01 Jul 2019 08:52:21 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id c23sm10332157iod.11.2019.07.01.08.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:52:20 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Johannes Hirte <johannes.hirte@datenkhaos.de>,
        Klaus Kusche <klaus.kusche@computerix.info>,
        samitolvanen@google.com, Guenter Roeck <groeck@google.com>
Subject: [PATCH] Revert "x86/build: Move _etext to actual end of .text"
Date:   Mon,  1 Jul 2019 09:52:08 -0600
Message-Id: <20190701155208.211815-1-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 392bef709659abea614abfe53cf228e7a59876a4.

Per the discussion here:

https://lkml.org/lkml/2019/6/20/830

the above referenced commit breaks kernel compilation with old GCC
toolchains as well as current versions of the Gold linker.  Revert it so
we don't regress and lose the ability to compile the kernel with these
tools.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 arch/x86/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..4d1517022a14 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,10 +141,10 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-	} :text = 0x9090
 
-	/* End of text section */
-	_etext = .;
+		/* End of text section */
+		_etext = .;
+	} :text = 0x9090
 
 	NOTES :text :note
 
-- 
2.20.1
