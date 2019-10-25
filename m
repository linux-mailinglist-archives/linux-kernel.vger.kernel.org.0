Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2651E4B57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438972AbfJYMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:42:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43927 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504543AbfJYMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id v24so1618931lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
        b=E1hiJE/N8uyirc34yldY8uoOKyp6Aafi6pTD1KNMz37l7ZxFuQTs1ly4mphyCyeoLm
         BIfJpTGn7JnPGMw2F/xN60qCJErNEMevmCpDy0g8zwOdSCaqJCYYVHT4CQPIamvwj2L3
         MdqAsCo4b5XqddEjICpt0BEm/DeSmy611x/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
        b=GDC3YURFPJyu3vdLmoST8G6wlkzuYwBX/QWd5Zp1sDKF33/CmetdigvFSYWfLuU+gv
         cMa9FQVOVDVId/Pa3p8YSWKzI/fIJulXythIsE33f/SksOL3eurLs7hczGBW5qpTLAuq
         Fv8eafgnl4kmG2Pg0F2biQH1Co9kouk6ORi99hwyMdLQba6XmnxTtg61bvdFOUZvWijb
         7T83bWuh4MfrQPGQV58OfNNXqt4bfvW6u6gl8R9zhRzPOlVmvg9gFMSg4u3wpY6AOv0Y
         ZPdHSDdUKyAJZxm0cgB0MVoTacSglPJyYzEQvaAI+5b66ZjuX7I00uFs5PLi9/djwkT0
         CgxA==
X-Gm-Message-State: APjAAAVDTto7Cp5s8YhyuKskR0ZY8PRHqQV1zuyASfkfz8t67X9jpVkn
        ZXkjzncY7Yb3+IBQvwjFrYOZCA==
X-Google-Smtp-Source: APXvYqzWdgjzit8ixR4YnUZ9xLOIPsZHRAlHxEezNI3JzgRLGEBgrKtCg1284a/7LWYjFvAyXUS6gA==
X-Received: by 2002:ac2:4c15:: with SMTP id t21mr2581867lfq.7.1572007290172;
        Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 21/23] serial: ucc_uart.c: explicitly include asm/cpm.h
Date:   Fri, 25 Oct 2019 14:40:56 +0200
Message-Id: <20191025124058.22580-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from asm/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..e2c998badf81 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,6 +33,7 @@
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
+#include <asm/cpm.h>
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
-- 
2.23.0

