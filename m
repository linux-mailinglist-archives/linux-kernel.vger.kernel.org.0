Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738C639B8A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfFHH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 03:28:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45451 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFHH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 03:28:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so2308946pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KSVlshasRK6kuaYQCslppXn0EIERktbEU2+65t8aULE=;
        b=ZHCVPBZoPBaQWlf8nIINFwXbAilNBdit+ZmITnKBqY3URAhzkS5ZLYD3Sg5WD1+SlM
         EHe0fZWtxnhSit8QaxsgDYsgCpywkciqBAPULG6pdgOTkZdaOr+ld1la+t9CSdKlTcB2
         B+FURsMt0keS6+gRy1S8Pb3Pv09Ol/LiTZzr119sCuy3pJueuYwYN0EaBie5Q08eX0oW
         mKbDmBcVaaVauEn16BanZ1AO12lfeba6gNRIVPIwDS4GEOoPNSHfkjAEz/cMcTOUuZrw
         SDv1m13u/pzzPkmX0iVJa9DrbDh6ELJhQyd7VuvTxtSIvRBUZWRHZ1o9M6ppdemiQlYc
         hh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KSVlshasRK6kuaYQCslppXn0EIERktbEU2+65t8aULE=;
        b=eelxY2B2Emlr7UWsUkjEfT8gASU3+A+YkhY/yF+d4nuX6BRCSEPqNdq0IvbBb6qS1E
         pfj185G00ZWbisTCfeA6xZ9ppwiiLYI0USvJZe1mQmyDHf0HXk54K/zx6Ff3AJS8vpEJ
         uuyDwyOyvgi5nH8qvKWXtf+DtaLqy6+E5qZrlKvatcX4MW4CFHlxmq6e+bdb/ZoTanHc
         Dc8sowCMc2R6aBw2hGRdnLwtCqheBPesdM1jxVwzfdXGCUgukcAmOZRUGWo66QdOp+uk
         6A014Lqz9trj4TK6q34GTiZyhgouteSaqNwncdKXRX/+yb7o05t+/Fw/6BcNTfPzk9Nc
         YJ3g==
X-Gm-Message-State: APjAAAVOL7aWBK1P5BFGfAiBrP2lP5t7VUQCLhSc9tPCNI82P+TX4/hK
        z57CR+DcZ+sPsRF8OYsb8Rc=
X-Google-Smtp-Source: APXvYqx/txq/nXjor41mhXWLGqcqTht4Z1OGnsEiB2uBILygtD1esnEile4rletDWLc40Xo/gxtTFg==
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr62586880pfd.115.1559978883957;
        Sat, 08 Jun 2019 00:28:03 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.157.107.159])
        by smtp.gmail.com with ESMTPSA id b8sm5092440pff.20.2019.06.08.00.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 00:28:03 -0700 (PDT)
From:   Hao Xu <haoxu.linuxkernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, haoxu.linuxkernel@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: kpc2000: kpc2000_i2c: add space after ,
Date:   Sat,  8 Jun 2019 15:27:47 +0800
Message-Id: <1559978867-3693-2-git-send-email-haoxu.linuxkernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
References: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add space after , for #define outb_p(d,a) writeq(d,(void *)a)

Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index de3a0c8..69e8773 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -126,7 +126,7 @@ struct i2c_device {
 #undef inb_p
 #define inb_p(a) readq((void *)a)
 #undef outb_p
-#define outb_p(d,a) writeq(d,(void *)a)
+#define outb_p(d, a) writeq(d, (void *)a)
 
 /* Make sure the SMBus host is ready to start transmitting.
  * Return 0 if it is, -EBUSY if it is not.
-- 
1.8.3.1

