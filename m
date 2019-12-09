Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086E81176F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 21:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLIUEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 15:04:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36343 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:04:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so7556990oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4lX5eJKbIc8x2MqyvzE/E7t4HYCVGzR2AGVHkKedOc=;
        b=T0jaTOd4QOUF9v8/lIlTVwazu3Na2r+8WN142yDlNT+6n8c3PqZxOng4fFKlN2P+84
         ZttX4gw2o7Za8Lz4bMA7hzYgwSXo9+jMfdrcJDehP6lpxCFDmgJcHrDPtWlZQWXPY3ml
         2l7ptN62CXwL3QdQdULCzVT3JLarlSuO4/9d+fTq8HTmdEpsIl5aMbl3vHf8ia1xukVB
         GOR0eaSUNNCUMkBkFxiH8CAUJxTGD349b0Rk6tZvSHx7cHy3+vQh8FkenptCZSCGqVx/
         44BKFc8EhZUHMWtKK0KoqnfyWzxnBdGdR6wcqBBnuaNkx6iijnvpJU7D/e7A3YnTcscJ
         9a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4lX5eJKbIc8x2MqyvzE/E7t4HYCVGzR2AGVHkKedOc=;
        b=qFuUz6dy0qQK7NWzylFojdolyReOY0rXOWrq+WhImb6zJ26wpUgT4s0YREqM6Gq9bj
         Qu5LG9Th1Phw66rZ03ZS0OigK1l1I+rE0zYhYQH+goEZ+e3lEgy9dWZljFvojXGVIaYO
         edcTV9BC4PUbutWBBf9KO8paSWQrutVWOJy+ZWvBpOFGssy9cHa/NOA9A+ZafhpTP902
         GQ9ux9LpA6KGVt9LtUORtiSjpqsf8buXfyRIycW3bCt7i9g8r9hdKbK2+r4Ri3IwZgVS
         QJmc0Mogqv9f3vwvCusjRv8llA8MVLnduJiPx7kktMk04LdL0nyaIEO6iYqr4Ti/pwX1
         +NtQ==
X-Gm-Message-State: APjAAAV5Ab0wMxMjp7zB8NkVBGu9kB3Wy/c8bv80kLwZ9EKn4Sa3wqfT
        KbfBblCI7+kpiYl4gaIsr7U=
X-Google-Smtp-Source: APXvYqx6+vG6ZE2HfIGLpTilMccVGcopEJCfeuryXwYf63nVtZJORgHY/e0zzsInhfrH/vN9dkbssA==
X-Received: by 2002:a05:6808:1c6:: with SMTP id x6mr789282oic.49.1575921844942;
        Mon, 09 Dec 2019 12:04:04 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m19sm326478otn.47.2019.12.09.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:04:04 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] powerpc/44x: Adjust indentation in ibm4xx_denali_fixup_memsize
Date:   Mon,  9 Dec 2019 13:03:38 -0700
Message-Id: <20191209200338.12546-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../arch/powerpc/boot/4xx.c:231:3: warning: misleading indentation;
statement is not part of the previous 'else' [-Wmisleading-indentation]
        val = SDRAM0_READ(DDR0_42);
        ^
../arch/powerpc/boot/4xx.c:227:2: note: previous statement is here
        else
        ^

This is because there is a space at the beginning of this line; remove
it so that the indentation is consistent according to the Linux kernel
coding style and clang no longer warns.

Fixes: d23f5099297c ("[POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library")
Link: https://github.com/ClangBuiltLinux/linux/issues/780
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/boot/4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index 1699e9531552..00c4d843a023 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -228,7 +228,7 @@ void ibm4xx_denali_fixup_memsize(void)
 		dpath = 8; /* 64 bits */
 
 	/* get address pins (rows) */
- 	val = SDRAM0_READ(DDR0_42);
+	val = SDRAM0_READ(DDR0_42);
 
 	row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);
 	if (row > max_row)
-- 
2.24.0

