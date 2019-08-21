Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2072987B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfHUXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:15:18 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40810 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfHUXPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:15:18 -0400
Received: by mail-pf1-f202.google.com with SMTP id e18so2648733pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aTcFmLdXUI/2mHIHBSaJPQwAMPCPvepbAHOZt/6Mmos=;
        b=AI/Rp2MWIPpvDRbQr66vsJVH2VKLk2AiLCwhWSisDViX7+3vHz2xKX+AT/zL/SGev7
         wHZRQ0uMksr4RgAPMluxI5XycKeyMZK2ngZre6OI9KsOnBGbgYBElJaJxB7YNr+Vwlx7
         Fw89w2se8LCwfj05KujChNy4UcFZmXKdDuZVP8wQRdBHvRmoaCwi3z/WQNmDseKUHKg+
         59YieleuSvPhc1ECg3xX1Uo6pu8SXMJVUJeOoNg+1SrOVwWKWzMQAjJJ7uDS8+EQRF6T
         8h3Lhykl32/jA3vB7Q+ecCOwCS7qEgLA8/4jrTJLtq3GgxeYbce5fiIk5PNSmjhPuwik
         v+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aTcFmLdXUI/2mHIHBSaJPQwAMPCPvepbAHOZt/6Mmos=;
        b=GTnGGT7h6oLAP3QWsFHiWyWHLmRHGiOtpjiZcjHtXn8UV/Yq1s9rTxIqEymPvvJIeF
         HkA2EM4FnD6h0wLy1sA31mWPkEJ9bk7JfxxD2zBnVjQXVVmJ6PudKWgGAlwG9No/cP+S
         SVgdBskvZbu1Hw0ySaQV/U4p8O69QJMB5yvh4dc/tqIZTAGtsaPYnjp5gdR+QuZYYjv2
         P/yC93AL72JXfGm2+wP5KsipMNgL/bBdhq8wcYt3AhOtzj1CI7EBD5i+52ndfytAq7sV
         3lzzbWsy2sAj2OXSaNmX53j0m7Qk4q2aTFyaZ22+Mv/lZVL9tIOhHn3salaW50u6G8/i
         6GiA==
X-Gm-Message-State: APjAAAXKUUiTd5fvOCk+AAVMkavzdoX+RvgZUMKAmAcRWq8L8LClwi4C
        gkFd6hndulmghgDy1+IX2QKFw570/4pt
X-Google-Smtp-Source: APXvYqxQ8ni/mr2OMg+ezusc+NT2FRPeydHbTjVOrVoqbRnszmg6xyT6lDvHLFLogeGJB7kkWAQirUAxkIvX
X-Received: by 2002:a65:5b09:: with SMTP id y9mr31993707pgq.345.1566429317200;
 Wed, 21 Aug 2019 16:15:17 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:15:12 -0700
Message-Id: <20190821231513.36454-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
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
2.23.0.rc1.153.gdeed80330f-goog

