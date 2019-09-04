Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC4A94F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfIDVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 17:23:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfIDVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so181618ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uyna4IYOJol121SLmRwAZvx/NaOoPDVjYK6GTYbGUpc=;
        b=HEvKyf6hs2+1i0SgpYXPM43WRe6XRXXEvFQ0JmJsaAzI+5Kzq7PFffuX1Jzl6+iI+6
         ZOS2jHoERLTa7KDEHqUkRHkic/Ja7Ek8udlefSiSVCiZJiE73g8B+EpMrCGc2t5YWh2/
         SGTuU7MjjoW3hBkpywZ1if3F4MaZDV3thVqrdaS7K7dnboqNTOKkoxEZTmAPH5EfMJuD
         6ylzq81lX5Z/QbVObOZN8N60eGDSFjTidvDL4wbEm3aYKxAhfyU4EGV87B+QV1iOn1Mx
         0YQawwISYg8nsmINmbUc4RpqXkqqAl9xBmACJepPDHfZFjxAPRxR7riT3rJe9uEQiNTd
         Ad2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uyna4IYOJol121SLmRwAZvx/NaOoPDVjYK6GTYbGUpc=;
        b=SpiASpcIUIG9qCmeiUnxpE7WqoF8/gsHKslf98vhI9ZNKZy3UDL+TAMxNN2N1T0Pfq
         bCXJ7DXLf893I0YAgNeGnso2IIf06dl17bf/0ZH233Uq0DmG3bzzh7IX1M01mR6uLw8L
         jzs0xbm9cuQuzPt0TlEDvtEWuY3sGPfyCD44cY7tO8sRlEGoeZAT67P31IOr1gpB72Y/
         R5yu1fduvNH9uu2+0e5//t/arW0Vc1DlYIn4H+S4WCjN7rSAxlxvmuapamvM92bfV0aI
         CQL4F0RbzZzBh2zkfSl0li1k3QnYe/+PX3uyWU+bBKRIM6kKUnF/t5JtH5vjaSnWMb0Z
         eeJA==
X-Gm-Message-State: APjAAAUMDqVYXApmDB9wqzRYNpLSgG/98vEHV0ZE3o5F7tCPzgMndiFd
        CVCrsAkBQaSFKDvhIrSVpM/6tg==
X-Google-Smtp-Source: APXvYqzkLtLa+ISHzj9gXd6kgVF2aOZOhBrHlWU0/2syQniAi1eBTH35MnVXSNzvWO5yaoeS4EY65w==
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr3270338ljh.100.1567632182383;
        Wed, 04 Sep 2019 14:23:02 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:01 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 1/8] samples: bpf: Makefile: use --target from cross-compile
Date:   Thu,  5 Sep 2019 00:22:05 +0300
Message-Id: <20190904212212.13052-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1d9be26b4edd..61b7394b811e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -196,6 +196,8 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
+else
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
-- 
2.17.1

