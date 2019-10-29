Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05E0E8CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfJ2Q3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 12:29:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390443AbfJ2Q3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:29:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id f19so9914936pgn.13;
        Tue, 29 Oct 2019 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vqg2XO53IvjvWgpc7maLNfLfFhOvPs8FRtuz3pdvCVg=;
        b=DERPfAsousKxqjbrr4S0syrTD4bEJpLEcj/4KPbk7Vj6JL14ard9U1nqESZKSeD8C8
         vmraCC02uVoOd7YYVtQJFAaqe5ZfgbUhrMbKbjcO/NXqOctLEMMrwNE115O54dq+n61j
         ScLgs4H2JoLm27tk62ZgR0Opfni67+wiLK/UcgOhRQu9GmjBcBgF3hctpWeooeayrPku
         Wf/Q3ewL3FG3AfkFCBmT3YMd0Ha+14YgNeS5M8mtVN9z2aWqR6Yr81sIHUyBRQmKf0hK
         VILIg4xFOLtYfWeOft/JbFkjlmfJr7rhTz29KYrKObbRXPYYqAJBfrWyrhlrFFXK6e8m
         mFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqg2XO53IvjvWgpc7maLNfLfFhOvPs8FRtuz3pdvCVg=;
        b=D1qEi/rzp8b8jO0icf+1fli0MhurRlBMp4R3hMlXOe7LSE7tmZuz0Sr3jEKaa21QK/
         7eINX3+ZbaqLiX+EW8oO4HzIpNJXzruuFGdVpkWoIgWcVx6fL+WaPB2SuWdyV5EtTySJ
         1rL1Fwrzke1da+g27VfFZbMFG8/17WW9apSM3ial9VmEvNdy+5pilEvtsAuqiPzNFeMK
         gZKY9U+5S0MEirF9mxTPD8u0/6aiplSq6Dy5APtyeYB9/LHd1BY7n4jVPuGpgdoQU6F7
         ctupz7iIZaXqTTrvbd5HcX3ir7hefF4akxd1V84o6J18686sRRgr4J2cPK/4sxJCNYbP
         0P3Q==
X-Gm-Message-State: APjAAAVMzYR9rjwh5vMOCZS/0qLxUaHVmzpAjh5bovZ9ZwS6hu9PKHgs
        0qWBuVkHU8RKFEVUlQ9a9d36bxXT
X-Google-Smtp-Source: APXvYqx0d7zbeVn2QQiUDFBYa6ephjiwPGTAz86ixSpuJp8MbcAIdR7pGce2gd3W5YEfU+OzcaYGjw==
X-Received: by 2002:a62:3441:: with SMTP id b62mr27154063pfa.12.1572366589916;
        Tue, 29 Oct 2019 09:29:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id q184sm15438830pfc.111.2019.10.29.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:29:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] crypto: caam - set hwrng quality level
Date:   Tue, 29 Oct 2019 09:29:16 -0700
Message-Id: <20191029162916.26579-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162916.26579-1-andrew.smirnov@gmail.com>
References: <20191029162916.26579-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set high quality to let the HWRNG framework automatically use it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/caamrng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 6dde8ae3cd9b..23a573ea6cdb 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -299,6 +299,7 @@ static struct hwrng caam_rng = {
 	.name		= "rng-caam",
 	.cleanup	= caam_cleanup,
 	.read		= caam_read,
+	.quality	= 999,
 };
 
 void caam_rng_exit(void)
-- 
2.21.0

