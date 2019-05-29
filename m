Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54FD2DDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfE2NMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:12:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40915 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfE2NMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:12:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so1606076pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aWoIYcgxDupSGtN0AnAKiiYwQa97e1g6WE42QwvCM0=;
        b=LJ55xB9eU8BGL+SzpCNDOjSwgkyqnlLfr0sD8Ar1E1DlrwJbHnBEjmaxJcloSeBguX
         rqTwVYovi64cV45HbMYdlSE1z3ilqCrWQ5ZJ8Y8pqdtPHqL9hDKsQwzucw7d3RDaeZ4y
         4cAiQ61+prb/BYYUYrMaHHsJzZ+V8vxq5SRMY1wr7RzmNRnc+SgbS5q80xAsTVnn1XZP
         mT1QAYgyDammYmmpSDqHj2BxUeToJQm2QuCRjCNXrqp7qDSh0qDcCpjVUwb7mGBFZYFx
         iLlmB9br7wU4cgIdH+DzupfAzZa12PdogkHp/4+VNyz470WbaHWafEXKGM7Co67x/dkp
         ySBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aWoIYcgxDupSGtN0AnAKiiYwQa97e1g6WE42QwvCM0=;
        b=l1jwGSDGNQsjK4sjrdkp2NR2uEt/frxT9K/SbCbRJgoD1ABqMd7E/DSCdMXKcweE3I
         VOOO0rRVx8X8ono+SbbBiZgc08i8/ieqNNdBbeqHvtDFCgB7uKCwhQ24B8kqzaF8XvsF
         dT+G0QY8rPCDBMofLyt/dopmUDXYGRwH+CPhhoDKLBil4FMXvviEUQNXIGMIXSMoExYS
         PIuaYTSY/0DH3pE8P1InphkedLcz9Dgvmo6j6padjdz2f/dtDgRwGn7f7KW806ZcrDCn
         IelpGnxYL6gmkVgba4xkz0haBYdToPfOrA3Z75bZ7AxALBQI5ihgjl8153RTpmvkB2ns
         VmcA==
X-Gm-Message-State: APjAAAXV/Pe2SCX30yb+ZariXPop6hm0Ja1knvcm9eR6PPHGV2RJBjKY
        OTttNueMQ/i2sakH+KqFbCM=
X-Google-Smtp-Source: APXvYqzJHRrczMIc52hvYh1l+W+LUzYEuTuROsJXEpl1M7zRkak4KWjbVbYAZWR8O+FJv6rGIDQ/5g==
X-Received: by 2002:a62:4e0c:: with SMTP id c12mr23624554pfb.17.1559135529196;
        Wed, 29 May 2019 06:12:09 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id f10sm15915670pgo.14.2019.05.29.06.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:12:08 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, bnvandana@gmail.com,
        madhumithabiw@gmail.com, matt.sickler@daktronics.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: kpc2000: Change to use DIV_ROUND_UP
Date:   Wed, 29 May 2019 18:41:53 +0530
Message-Id: <20190529131153.6260-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro DIV_ROUND_UP instead of an equivalent sequence of operations.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 254fee593399..7b17362461b8 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -28,10 +28,7 @@ unsigned int  count_pages(unsigned long iov_base, size_t iov_len)
 static inline
 unsigned int  count_parts_for_sge(struct scatterlist *sg)
 {
-	unsigned int sg_length = sg_dma_len(sg);
-
-	sg_length += (0x80000-1);
-	return (sg_length / 0x80000);
+	return DIV_ROUND_UP(sg_dma_len(sg), 0x80000);
 }
 
 /**********  Transfer Helpers  **********/
-- 
2.19.1

