Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9439F7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 03:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1BTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 21:19:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33574 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH1BTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:19:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so1197379qtb.0;
        Tue, 27 Aug 2019 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/zWx5WlB3nENmtbRbPuzIKekfVdMqCEHjiTFb/pfsU=;
        b=RCJ81QIRVA/fla9LD3Pc/NBZ2Oq98RnqZQKHs0usc0PGCDB39OiPgD5eJcpO4Hb6cB
         0FFZm7itCTMW3EXkh47Dwtut3HLD3IwYbo0RYFbIQn5iVCiqV3XUJvcX5QwBwGeou7M8
         tAsfHQ3x7BQ0spYrXLi2/ByyeP9kJtLw5U5SrP3bwvOfTEfxk1TuWtOJ3JvCWwj/wcva
         91HCAYHgzLBEc61fV/Y2F0mByX5LLSdSD76RQKUTMt8/K/1eJYfRVqzh+ooDEP833TqO
         WnUN0IJt5Tq0zXsfsbKkiZtuNMpqTrN0rwHKu9Cu+/opvUILXr4sLzsJkI/ho2ZD0WiL
         N3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/zWx5WlB3nENmtbRbPuzIKekfVdMqCEHjiTFb/pfsU=;
        b=Jt0nubWjaiS7QzabNmwFzdTN0DIKJE4VaLXvo4aQR/CVrBWVxgwaUjjRbcsGRVKF1P
         Pe/0Lzxs9vi9fKgDn1SqMGFVM1Q1BTPl1MiXQqW6BaEQzyNUFJAza0SYhPvJOS0Kvyjt
         dNBcYVpmNiNmzmtEkjI8lSk/g4mRHI03ZqQ8Oqiyf0Uzho+2KxkYnBeQSVuYOK9/DyYo
         f0MhcIZIiGnepduAv8+84QOO7Uzf3am7kyLvyZYjgcHGia+QpXjA56OvJFhavxhpxAdu
         Gy4rZG37dAcP06nrDJTMaWJBJYPe007jPBTw9DojMBrlf9aTdUr0ekuX0obIDLEbZsy0
         rSIQ==
X-Gm-Message-State: APjAAAVP74y5OFwToqFF+Z7+dBmzA8GASMM5l2dZ4t6SliGXYo7sbmuR
        cvxYyNfZ0oyfRwWxhHbmPEYHEstKBEc=
X-Google-Smtp-Source: APXvYqwQronOCwnN+3+wzhhV58Z1Lte4D5uR7qD5f9VY5jxwDqgV4O7blMTPqOuXYhoM6ZhT8RB6sw==
X-Received: by 2002:ac8:128b:: with SMTP id y11mr1839866qti.229.1566955139075;
        Tue, 27 Aug 2019 18:18:59 -0700 (PDT)
Received: from localhost.localdomain ([186.212.48.84])
        by smtp.gmail.com with ESMTPSA id c201sm499231qke.128.2019.08.27.18.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 18:18:58 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RESEND PATCH 2/4] kernel-parameters.txt: Remove elevator argument
Date:   Tue, 27 Aug 2019 22:19:28 -0300
Message-Id: <20190828011930.29791-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument was not being used since the legacy IO path was removed,
when blk-mq was enabled by default. So removed it from the kernel
parameters documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1c433daef6b..7d2738c7d49b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1199,12 +1199,6 @@
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
 
-	elevator=	[IOSCHED]
-			Format: { "mq-deadline" | "kyber" | "bfq" }
-			See Documentation/block/deadline-iosched.txt,
-			Documentation/block/kyber-iosched.txt and
-			Documentation/block/bfq-iosched.txt for details.
-
 	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
 			image elf header and optionally the size. Generally
-- 
2.22.0

