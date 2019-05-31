Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3539F3154E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEaTYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 15:24:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44408 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfEaTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id x3so1249784pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=09OzKsWEH6pa0xbQSX5bdUX7ramAnBw1m5XpBBMtl8s=;
        b=JGvnbxSQAPPTJJvs7FYKN7+BYz7tmH4Mfbf9rQHcuHBlmDCuhCnbR+J0xw3HkJflva
         tJwp0yC1FtVNH0cUbFj7HzTW13vKph1qHcM98E+Fhu1E2DZz8dZJnDODT8XaGN9y2Lap
         isSWXzNfF/KrU2k+Uk+VRn+lmUiqvpeg3wtnfFHhmgTQoQbwduVWWUh7E0t3wfvm3KCN
         zKoDMUN6z4v+mRAGIX4z8SNpd55jcKoo2eNg9CAq6PVBzPmobB/ElBFP5PMQGcDAMV3+
         zv/Bhf70x1KMlKnPjQ+onFVp0rwriUFT1ath02VSiAkQuBMOE86hWw+CoFSDlZzRwYun
         qcSw==
X-Gm-Message-State: APjAAAU3Dkif3+ZxjGmGwdTbKJO3eGbXPqNwxQkO4c195+i5mp/iWcc+
        fB7wfV90UwawsfYOaQi9AqsynA==
X-Google-Smtp-Source: APXvYqxvwP9LM12Xj44vBpACJtjdlNkpDxKvsKPHlpq7EZ6IL5RMgGPU0jVOgflGjcQSa2MLBHPa4g==
X-Received: by 2002:a17:90a:204a:: with SMTP id n68mr11635594pjc.31.1559330632786;
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e6sm2346642pfi.42.2019.05.31.12.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Subject: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
Date:   Fri, 31 May 2019 12:12:02 -0700
Message-Id: <20190531191204.4044-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/uapi/asm-generic/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..f0f4cad4c416 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -833,8 +833,11 @@ __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
+#define __NR_fchmodat4 428
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
+
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

