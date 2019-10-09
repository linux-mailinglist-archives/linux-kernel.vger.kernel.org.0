Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2AD19E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfJIUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 16:42:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33734 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbfJIUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:42:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so2690163lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=sam0/KZSTXmUo2WdsnqCOUMLoQL0oTggZsrHu5xImVNB4DQszXP4VtC6SBAq/YaCj6
         oZ6V+aleXgxEQmYw17nYVsNTLotnMYHMksl+zIUhW7TUugybC0sScWu16ACFEgW5U9BW
         bTsDyycFa5HCBVNQ0giJ0kfWtl1HZaXU8oiQDCSEMB6AgOb1dV8Xe5A5es+7vUne7ONT
         3RMXkAbwjp4xqCDZdeuo5KlRB7t5rARVOS7kuZsRRb9z+bWzkHKkRrTmAX+GjNH3JYJQ
         y74rRnMCpbmdDtq0gOFuyPg1ZHyMwXzwpOOsQUK/gT2ou23MHlRIiL9fnkgBq1xxhYjL
         KQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=Kk6n/9SZq50UIbaMmyw9AZoD0E61cQ8uwlzuOY29KUhqemkDW/ty/RV1zQI3HHUrXe
         Qb4eN+JQTF3NnrLjKi9c2Du2douKtyWul9M8inWub0OLH44oX3hEOweVi3cHAByLvdxQ
         U1y++0PBzc6KKpNVsGkFe9tAGm5uQqN+K4Ppeuz0G2u4+vbmtONUzhrZCvTam/TvGQLh
         mXp3JTBCjdugiTzkuc6CztUii1gq+X797YBAR1Ez/J8THq1RpvMlbg3yYh833r+ixPss
         kET4buSDm0X9o94J9b/okOAWVDB+5x0sc48rlx/RWgOwy6v32kGYnPZn1174NWw78Dxw
         GlEg==
X-Gm-Message-State: APjAAAVbsWBEmkEx3c73TaAbtuLeSAKCxU6GYLnoxwfbzdvN+hGtx5Fq
        CCe4p8jvIKMpCIAQEWSr8H6QEw==
X-Google-Smtp-Source: APXvYqyiGSARqeIXVEVI1rDeKHEAUCzETEToOqGqB5l4cdarrKDlAOgnSm/pu8APW5hjoQ/RqSsBHA==
X-Received: by 2002:ac2:4904:: with SMTP id n4mr3170649lfi.179.1570653717613;
        Wed, 09 Oct 2019 13:41:57 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:57 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 13/15] samples/bpf: provide C/LDFLAGS to libbpf
Date:   Wed,  9 Oct 2019 23:41:32 +0300
Message-Id: <20191009204134.26960-14-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build lib using C/LD flags of target arch, provide them
to libbpf make.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a6c33496e8ca..6b161326ac67 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -248,7 +248,8 @@ clean:
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
+	$(MAKE) -C $(dir $@) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
-- 
2.17.1

