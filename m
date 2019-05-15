Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3891FB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfEOTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 15:48:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33618 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:48:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so1204216qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XzA8KKXnG7IsFptuBpManSyTGyPz388NMXv8Lq1udo=;
        b=s797fWJ/DdsMHGq4pSRsq5Rput/j7dkA5xUtAujE2etsMVFGd/6opxaEBCWuJh89oN
         GUc4wCgcFY6zIpTquCQWbFgrOoaO7ek0mI9SQCVA9rlHWiispmloO2N9vMx2b1QYnjl7
         cnChGz4lU9xkc63DmV/ughSNcmzQqJ9kwJol7/M1oyihXz/kfZmCHiAZOXE+KbQNyES/
         BfAF+MIvuD9WaeDmnGVcq+/tQTSVEx2x3KpL8fXO9fIoNVft2KUDSttyVTB0ikRH7AUv
         XdX61CQzpIo5XF15cx1Yeq2zo2n8IGl/sG0B20lvu5FMP2C90T2MXu4YWiPqYiVu8/B5
         oJYQ==
X-Gm-Message-State: APjAAAUBjkp5C7DvLrbkmfq2zACyM2LrgD14g+Oy/WOPcwm+oY0dmPuw
        032yLlUx90HNAyV8v3oa3JRFdQ==
X-Google-Smtp-Source: APXvYqw+OcaWJBOGF7NwWvMvQF3ur2OZsWCF9fQK3IcjgqNnKRnAdaqprpAmOs7XYKyf8hLi6JhjHA==
X-Received: by 2002:a0c:819d:: with SMTP id 29mr33540697qvd.123.1557949709246;
        Wed, 15 May 2019 12:48:29 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9800:dae6::e443])
        by smtp.gmail.com with ESMTPSA id s17sm1903957qke.60.2019.05.15.12.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:48:28 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: vdso: Explicitly add build-id option
Date:   Wed, 15 May 2019 12:48:24 -0700
Message-Id: <20190515194824.5641-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to
link VDSO") switched to using LD explicitly. The --build-id option
needs to be passed explicitly, similar to x86. Add this option.

Fixes: 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 744b9dbaba03..ca209103cd06 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -13,6 +13,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
+		$(call ld-option, --build-id) \
 		$(call ld-option, --hash-style=sysv) -n -T
 
 # Disable gcov profiling for VDSO code
-- 
2.21.0

