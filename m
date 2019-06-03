Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8A33B44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFCW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:29:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43274 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFCW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so927534lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knrbzBuDehhtfPEvKniXQQfSPEDHGGizKqNa8Zubbfg=;
        b=EjM5lDCiMw6pXgAainRP5g/6sW/3yKfXeYL1CNZoC0BQuAktWkxX3dyb5aZUPQJUev
         UZlr4MdGCD597hOvjCTD3/jxp+mVmm7WTZZDDv24f1W9CVjKOREZWCsIoKhsKMCpYQSF
         gBxK/bgtj2QQXNZ6srHy9cnbWtRp5R4vbH50vu0azBEUKMn/jY22QdAbEDkSmBqgVG8u
         s1CxX8yhFvkpc7HQNjgBIlmnk5nIt3Lmqt3e5exmEaNpxtXR90K1Sxh13i8IVl0OIc8y
         M3Y6/Zodpsr7Pm+YDAFPxsS49ID+HB96VCuBj0hp9RCuvRWJnnO2IyIz5/mw9vkM9GgX
         5bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knrbzBuDehhtfPEvKniXQQfSPEDHGGizKqNa8Zubbfg=;
        b=J0oV4oQFh88r0iUbNn8LI0u+8AkWswsGINcFY2ri+84B8HZXldVB2XVoZNrhY6R3RO
         dbkqYgKI6iDrfRlNafeyTf/kao6VdhNt7kmDXSR1H2F6/g1CzmbeqKFBFe4Bi0fC3ybC
         AGvGF/yhW61DKqaznRsUsAIVbQhDcMsh5XrvXhalFV802niXpptRtDOz7556s9fA3q7T
         XNVKXzPZTNiCyFikzFlmNj6UtGqokonEUv5565/bU/l9dDSYwqgHS5GT80F991osXZCP
         yyAcu+cM8+XoQReb2PkRUvWduRk4wJzercUq+sWSCI6aiw1bOxam66I77najEuHKXLZX
         c+zQ==
X-Gm-Message-State: APjAAAWI4yy3gvB80se1Jnu/idcq+hvzPloF64Y9jDu2z5shdvD+8g94
        u1UeA8QbMCgmdqs646FK5lUGbQ==
X-Google-Smtp-Source: APXvYqxmRVrpJxfb8ZX6pzol8sIO/jZaTkrcussFYhqIEtc8sF9OLnnbp4UPgEp616MGLfhDvHZ5vQ==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr10276923lfk.125.1559600962748;
        Mon, 03 Jun 2019 15:29:22 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:22 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: kpc2000: remove unnecessary oom message in core.c
Date:   Tue,  4 Jun 2019 00:29:12 +0200
Message-Id: <20190603222916.20698-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Possible unnecessary 'out of memory'
message".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index dc6940e6c320..a70665a202c3 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -319,11 +319,8 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	 * Step 1: Allocate a struct for the pcard
 	 */
 	pcard = kzalloc(sizeof(struct kp2000_device), GFP_KERNEL);
-	if (!pcard) {
-		dev_err(&pdev->dev,
-			"probe: failed to allocate private card data\n");
+	if (!pcard)
 		return -ENOMEM;
-	}
 	dev_dbg(&pdev->dev, "probe: allocated struct kp2000_device @ %p\n",
 		pcard);
 
-- 
2.20.1

