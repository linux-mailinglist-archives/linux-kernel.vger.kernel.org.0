Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 639CD9DAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 02:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH0AvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 20:51:21 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51997 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfH0AvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:51:21 -0400
Received: by mail-qt1-f202.google.com with SMTP id h15so19224425qtq.18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g3ZhUSq1j3Lxx16fgpQE0iUGf8D5v9KeIf9gHJhK6As=;
        b=K3dIPuCiYmDT7JdD+OPTROgfZh0kK3kMT6mC5+cKNbRDfqtkvEhkP34dMYBBa8U3hL
         /jH7c3fgAQ+4/NEOzE5+r+YZXJ7I9VMjBCpJQta9e79ZOuCYgtIR21YVFeFGg9YHL0Pq
         QENxhBVyD95yUspmnBymEpzq3go8lBmvPFPPlXQ6dFARXilg4fYE8goa3mQCR/0GuqAu
         5t+5CxMDauJdfwiEsIwJatFUdl4D4tO+JyimUClvUcVa8Z5zui4TyzcZFXndLfn+CXWG
         ijSeCHIjscAwVUbkhIx5joCSEH+5LIDGHxm+6PdWL2BK+boUv2MfzW3sYWylGQs96BG0
         5gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g3ZhUSq1j3Lxx16fgpQE0iUGf8D5v9KeIf9gHJhK6As=;
        b=QTvp9YhDWvusR0/QzNQyVrcccmCAGi8UuSbnljPGp8eyEDdidk2gMrZ+kMH/5fWyLu
         suP4+OjSbQ02gSRZhVqXZ9Q7Z0zC5cLhxnTGfitvDwEBA9nsTYMeXQzwaxpaa9SJ+J98
         W4S+JnEDHYP2py41/v6EFcm+A2vk9PDRL7q9JFHWdvfba+b832gXU9HcmPVYxGy9BsH+
         elkkRYij9LZwL8LQhVX3xbKR/v9vvvWGcrYjmfRTKc1TjwzqU1Z2n/RX55tKJdZMIWxC
         fEaWolXs1jq8RKJIEErEtZBYyjTeV9CWDdx01VlahAw4tCtelOD5MsUSc33w/Z4JsGUP
         KrNQ==
X-Gm-Message-State: APjAAAXuZLwkKYElIcjCUSO0ay1ZV0N4DXvxU6c6yMzoUesZUpJmHAEY
        bKPunfnTQlX4MUfsCduCoHq5vedsOqfK
X-Google-Smtp-Source: APXvYqy9SYnn6y7EsNLzuH0BmPkFq3ePbS/CXXEmWkCR2y7v33Lxff9102PBNbeD9keTFlsrQDiP4C0Wq0ey
X-Received: by 2002:a05:620a:126c:: with SMTP id b12mr19883438qkl.177.1566867079971;
 Mon, 26 Aug 2019 17:51:19 -0700 (PDT)
Date:   Mon, 26 Aug 2019 17:51:13 -0700
In-Reply-To: <20190821231513.36454-2-rajatja@google.com>
Message-Id: <20190827005114.229726-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190821231513.36454-2-rajatja@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
From:   Rajat Jain <rajatja@google.com>
To:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elements in the aer_uncorrectable_error_string[] refer to
the bit names in Uncorrectable Error status Register in the PCIe spec
(Sec 7.8.4.2 in PCIe 4.0)

Add the last error bit in the strings array that was missing.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: same as v1

 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..68060a290291 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -36,7 +36,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	unsigned int status;
@@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"BlockedTLP",			/* Bit Position 23	*/
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
+	"PoisonTLPBlocked",		/* Bit Position 26	*/
 };
 
 static const char *aer_agent_string[] = {
-- 
2.23.0.187.g17f5b7556c-goog

