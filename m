Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB0A78E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 04:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfIDCgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 22:36:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfIDCfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:35:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so12213479pfn.7;
        Tue, 03 Sep 2019 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kt0n6bzsKyTFfjulhfhV37Mi2N4194QFhOH4tXXRRAc=;
        b=YsHRUH31fnI6bd0ZA0gAPNFt0v8ZXWq7ADbdpRPeLHyqusI3ibbDAteDhCwxIVu/u6
         MohQ0/76rMSujjkA2HDpl+mLOP2N3iGee0LgKPQxm3SJ1i/k/tGJnpW+H4ScTRGuN6S1
         q65bEV2rreX4ubjnRxE6i5JQfKW9XiRPmLV9MSSg+r4o4H0WFWn5FiRh9mN6MdAgm+Io
         ulhCkCYTfeuScYCp5RfIuI6UwoLPxZ/kEwQfsmS51Qzm2pyr5xh/1QWm/78uV5GBQGcl
         PzQGN0JKFxU/sRbVFwNW/82FKrW31c/IT5up8TI3shTqLSglJLw8oloceEC7qFpfw8Vp
         b/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kt0n6bzsKyTFfjulhfhV37Mi2N4194QFhOH4tXXRRAc=;
        b=iNVCl9UbN1X0eq7x5SbN7GP0CQCyy2maJKvr/zb77XSwP7u3D06+0WtQdshGfUtXjp
         KzoDhGO5/bDAf3B2i5f5UcvhbP6MBFcYS972iotjrQ1rnP5PLr8xgLe/HRfmHTE4t5NN
         WPhu4XASILekodS4k3Vm9qlHhY49aNJC0CUJIV+/qu56/J7Rp27w0FhVEPbGuY96axL+
         erwzb37OmxX59kKq5oUlu7Wd+WND+4d9yT0I+hx7xSIuEUaJPTYwUN1B8sHXmBCBo9X3
         VnaXKmEh6KI8mQTd6Q5S7icWhy2i5Zukq1Gkb7GfRqSPt9U+dRo9g3WO+7DNvxpLT3AF
         iAOQ==
X-Gm-Message-State: APjAAAWLxcuu43WFndYIsC+ZkpIg9lCAFKtGKGiSU2dMb2vu4J8KF6I0
        oHo2YpoOTvBQABQYxZTQq8clg0utrCE=
X-Google-Smtp-Source: APXvYqwM5QlTGTCCjesiCSHjb3QdWxA+jovpNDbl8leRnGMYBMG5GxsNU72mZeWskh2rDIivFDtNQA==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr32595287pgh.136.1567564535077;
        Tue, 03 Sep 2019 19:35:35 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id i74sm7480250pfe.28.2019.09.03.19.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:35:34 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] crypto: caam - check irq_of_parse_and_map for errors
Date:   Tue,  3 Sep 2019 19:35:06 -0700
Message-Id: <20190904023515.7107-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904023515.7107-1-andrew.smirnov@gmail.com>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Irq_of_parse_and_map will return zero in case of error, so add a error
check for that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/jr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 7947d61a25cf..2732f3a0725a 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -537,6 +537,10 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	/* Identify the interrupt */
 	jrpriv->irq = irq_of_parse_and_map(nprop, 0);
+	if (!jrpriv->irq) {
+		dev_err(jrdev, "irq_of_parse_and_map failed\n");
+		return -EINVAL;
+	}
 
 	/* Now do the platform independent part */
 	error = caam_jr_init(jrdev); /* now turn on hardware */
-- 
2.21.0

