Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B755FB38D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfIPKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 06:54:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33730 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbfIPKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so3853568lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4FRJ5Ph8qMbMU6/W3VLuGrqprbT0bDHz0d1WvLmMb4M=;
        b=g/BAdg0UimHeaUICEhjEtr4KxeDpY3VrRM+S2Z5GVOPRjc288L3c92wXp0NENhu5ZG
         SVF1bEXuZoCRXflIqRO8ftu3gBiqprEwR3nlJWXBVvgk1qHQyjzdjDXnKz08VQh2gsLa
         0C5RaVzyQ/Lq2tJP6QdWJx7RY7WyTyjvsjXnHIcA2zyhsx8zB0FVzByiOO+TZ0Jg74TR
         9Yf697+zDIr/nGnizNYyFhZloRMFYJlZYkYVnFK2KODhnMLe7dvoUhvgx3MpOosxicSF
         cOoNOupkXaFXHIWPDAdLb71YsQEqxdw5ZL/A3ipVUT/acTMFAY7YPn2FvXecNkxjF8Xa
         KngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4FRJ5Ph8qMbMU6/W3VLuGrqprbT0bDHz0d1WvLmMb4M=;
        b=afPaoZl1YzCZRiVs1oFXtgimy3c+NskQe7wvTvOP+TJjzRvOqTgFbzuGBaker0X2wu
         fMIA/8tFQWm7kg1FQgPwRBKSTTwdSko94gKVbWqwuKmvD0yekd1IeDXQAH7eR6pr7lLg
         Anagh5MPgtAx68zPYYRvG78iqhXD45sbL4wlIEf92o9j+TAgQeOeKygG2KGlaS34XOLC
         qyiPZvWGekhrWG3Zu1m00UNUg6EkyTmzfNMD9gl1o0CpVqOl4H30YMVltduVDoRkSWdV
         zGIB+nBUVX0abtuKUX/mFGPAG4BDMfaXnSwObHTVbmfpsrESqwJYsc9odKutiOEONgpH
         y/TA==
X-Gm-Message-State: APjAAAUhPTXWD7wYwdRYInXT1FdLgNXZ44/UoLajYUwobWSJF+myxBe9
        zUV1cUO/puft6M+4J3gikE7X9A==
X-Google-Smtp-Source: APXvYqxMVl+Re8IbPRj8nExAl9rt/a6wXvbqrWxum/fSucJNAbGUW3bKzTceRGfaIintAYnHkoXUTw==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr12491200lfm.120.1568631285526;
        Mon, 16 Sep 2019 03:54:45 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:44 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 04/14] samples: bpf: use own EXTRA_CFLAGS for clang commands
Date:   Mon, 16 Sep 2019 13:54:23 +0300
Message-Id: <20190916105433.11404-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in next patches. Correct it here for simplicity.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b59e77e2250e..8ecc5d0c2d5b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -218,10 +218,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 else
 ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -280,8 +280,8 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # useless for BPF samples.
 $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
-	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
-		-I$(srctree)/tools/testing/selftests/bpf/ \
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(CLANG_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.17.1

