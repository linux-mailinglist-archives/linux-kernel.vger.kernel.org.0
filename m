Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CBF96A69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:25:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37499 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbfHTUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:24:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so3854925pgp.4;
        Tue, 20 Aug 2019 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkecJex3KsSic/Qy+1RssDASBZDazMTOQb79fcVzmGs=;
        b=FIyKFSdk7qUTXkHbGlwLUztwVgFcwW31bVjjsblf2gW+yoCwDVkBU9wZ/5cnklME9d
         F6B7a8OUrvRnr9zOpNxinE9eFckBXtLAnk2u5H51YOg2tZBe7PmoNEpEuelZPdwutXxG
         7OOwgZsWMzkkeclMxBcDMY430ZtpJOl5LL+qliyBKY22Ch09eZUqaFkBr1vhnW+rVvzX
         fp9gkFwjTIUjwqWBvPIoz45DDWZ9ZMNAWvpZLSQ4lEMlFUeGHOMIBsGQnM+a9EqBoNQ2
         APzfEfRoBwO9GNwC79jkUuyhspWh5c53fTRKfUL/oSzaL4AXOifRD6jDJAtLhAeInCIb
         dGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkecJex3KsSic/Qy+1RssDASBZDazMTOQb79fcVzmGs=;
        b=sCNTMQWeU2aZdCOJI12RaPg44aNKlqzJyyDxjOoXTJhoquL2FV1RYRO3fbBxEO8XVM
         80HHSPlfODXrp7xJiey7O8KET7ttWuWDE3KhDb49g9oxv2GReqEqvBG/fEaOJR4di+ZL
         FLy2jnPQTSETRm6IeX774Z7tM6fOCLyA6ZJaVrQTjtzxzjoyO2zGjRQHyi8oONJtxAVh
         okdGMPyOCNbrlpA9J5P65GlNszLAMEi6OwtbS/Uj3ur+cs11XiJkm3R5+uIJZP5cbAyd
         sPn1DJml1g0PV/9E98ba2rBS0vP9SJvobdELgn/Ss90s3bgf9dKRtpw83pBYyj4Usfw2
         /pmw==
X-Gm-Message-State: APjAAAUUxnh+mWAMh/awOirZ5N4iMJ2GH8NFerjPzAUjOy4dGnrJ762s
        39ppXgL9rPic/HpQ5JFbw0SHhiMh/lc=
X-Google-Smtp-Source: APXvYqz/ScGXXgxfEg+x1r2hsIGpLKBY4u1tcq3OYr/X+lZGRB7g63CXow/92LVCPvlQwHRSbMwnRg==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr1733381pje.96.1566332669015;
        Tue, 20 Aug 2019 13:24:29 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k3sm36149846pfg.23.2019.08.20.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:24:28 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/16] crypto: caam - share definition for MAX_SDLEN
Date:   Tue, 20 Aug 2019 13:23:54 -0700
Message-Id: <20190820202402.24951-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820202402.24951-1-andrew.smirnov@gmail.com>
References: <20190820202402.24951-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both qi.h and cammalg_qi2.h seem to define identical versions of
MAX_SDLEN. Move it to desc_constr.h to avoid duplication.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/caamalg_qi2.h | 27 ---------------------------
 drivers/crypto/caam/desc_constr.h | 27 +++++++++++++++++++++++++++
 drivers/crypto/caam/qi.h          | 26 --------------------------
 3 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.h b/drivers/crypto/caam/caamalg_qi2.h
index b450e2a25c1f..706736776b47 100644
--- a/drivers/crypto/caam/caamalg_qi2.h
+++ b/drivers/crypto/caam/caamalg_qi2.h
@@ -92,33 +92,6 @@ struct dpaa2_caam_priv_per_cpu {
 	struct dpaa2_io *dpio;
 };
 
-/*
- * The CAAM QI hardware constructs a job descriptor which points
- * to shared descriptor (as pointed by context_a of FQ to CAAM).
- * When the job descriptor is executed by deco, the whole job
- * descriptor together with shared descriptor gets loaded in
- * deco buffer which is 64 words long (each 32-bit).
- *
- * The job descriptor constructed by QI hardware has layout:
- *
- *	HEADER		(1 word)
- *	Shdesc ptr	(1 or 2 words)
- *	SEQ_OUT_PTR	(1 word)
- *	Out ptr		(1 or 2 words)
- *	Out length	(1 word)
- *	SEQ_IN_PTR	(1 word)
- *	In ptr		(1 or 2 words)
- *	In length	(1 word)
- *
- * The shdesc ptr is used to fetch shared descriptor contents
- * into deco buffer.
- *
- * Apart from shdesc contents, the total number of words that
- * get loaded in deco buffer are '8' or '11'. The remaining words
- * in deco buffer can be used for storing shared descriptor.
- */
-#define MAX_SDLEN	((CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN) / CAAM_CMD_SZ)
-
 /* Length of a single buffer in the QI driver memory cache */
 #define CAAM_QI_MEMCACHE_SIZE	512
 
diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 536f360bf131..1fe50a4fefaa 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -18,6 +18,33 @@
 #define CAAM_DESC_BYTES_MAX (CAAM_CMD_SZ * MAX_CAAM_DESCSIZE)
 #define DESC_JOB_IO_LEN (CAAM_CMD_SZ * 5 + CAAM_PTR_SZ * 3)
 
+/*
+ * The CAAM QI hardware constructs a job descriptor which points
+ * to shared descriptor (as pointed by context_a of FQ to CAAM).
+ * When the job descriptor is executed by deco, the whole job
+ * descriptor together with shared descriptor gets loaded in
+ * deco buffer which is 64 words long (each 32-bit).
+ *
+ * The job descriptor constructed by QI hardware has layout:
+ *
+ *	HEADER		(1 word)
+ *	Shdesc ptr	(1 or 2 words)
+ *	SEQ_OUT_PTR	(1 word)
+ *	Out ptr		(1 or 2 words)
+ *	Out length	(1 word)
+ *	SEQ_IN_PTR	(1 word)
+ *	In ptr		(1 or 2 words)
+ *	In length	(1 word)
+ *
+ * The shdesc ptr is used to fetch shared descriptor contents
+ * into deco buffer.
+ *
+ * Apart from shdesc contents, the total number of words that
+ * get loaded in deco buffer are '8' or '11'. The remaining words
+ * in deco buffer can be used for storing shared descriptor.
+ */
+#define MAX_SDLEN	((CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN) / CAAM_CMD_SZ)
+
 #ifdef DEBUG
 #define PRINT_POS do { printk(KERN_DEBUG "%02d: %s\n", desc_len(desc),\
 			      &__func__[sizeof("append")]); } while (0)
diff --git a/drivers/crypto/caam/qi.h b/drivers/crypto/caam/qi.h
index f93c9c7ed430..db0549549e3b 100644
--- a/drivers/crypto/caam/qi.h
+++ b/drivers/crypto/caam/qi.h
@@ -14,32 +14,6 @@
 #include "desc.h"
 #include "desc_constr.h"
 
-/*
- * CAAM hardware constructs a job descriptor which points to a shared descriptor
- * (as pointed by context_a of to-CAAM FQ).
- * When the job descriptor is executed by DECO, the whole job descriptor
- * together with shared descriptor gets loaded in DECO buffer, which is
- * 64 words (each 32-bit) long.
- *
- * The job descriptor constructed by CAAM hardware has the following layout:
- *
- *	HEADER		(1 word)
- *	Shdesc ptr	(1 or 2 words)
- *	SEQ_OUT_PTR	(1 word)
- *	Out ptr		(1 or 2 words)
- *	Out length	(1 word)
- *	SEQ_IN_PTR	(1 word)
- *	In ptr		(1 or 2 words)
- *	In length	(1 word)
- *
- * The shdesc ptr is used to fetch shared descriptor contents into DECO buffer.
- *
- * Apart from shdesc contents, the total number of words that get loaded in DECO
- * buffer are '8' or '11'. The remaining words in DECO buffer can be used for
- * storing shared descriptor.
- */
-#define MAX_SDLEN	((CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN) / CAAM_CMD_SZ)
-
 /* Length of a single buffer in the QI driver memory cache */
 #define CAAM_QI_MEMCACHE_SIZE	768
 
-- 
2.21.0

