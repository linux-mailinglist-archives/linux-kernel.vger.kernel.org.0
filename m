Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853A12D951
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfE2JoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 05:44:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43316 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:44:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so1742420lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsyAy8xqOnydsiC3KSfkSrEFY+z1J//IAa+nI1nutTI=;
        b=vDXcEte//MSO2iH2sG4khq5ViiD28SNgFCtI5qzbkiY5tcqIpruUVlVLlvAVXcNdav
         O4VL/26sBkI/wW28Kiih8UHel/KkN7upj3INbhFvdJ/sYayYctclBVXar1Ct2BxthCme
         dGee6sy0Y5ZFF2SV8v0z25UZFStWLIYOqWTUICzz2PbNMzNM9hmVmnBnRRhAdasz1j2B
         DpdFJ/YIrMoDOIipK0sPN1t+/AwnQLCwswyVgKaPWpKrCSxqEVONBAI6vWP5CUHzYOGp
         ZwBHLuQSuPMxNFaYGDeR9SWDMf8DKbhP5KUuFqQyfIrYmsQxYfOH2l2+1WzdloC3JqW+
         1hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsyAy8xqOnydsiC3KSfkSrEFY+z1J//IAa+nI1nutTI=;
        b=TPmZDu1WSyFulj2YWen+8qe5RlG04w4eKxoeRi5xCxUaaNiEN8FHPztOgms60F8M+v
         AZXlEZp0uYHlxrrWyn6zQhTSPYBFytAGB5cBDNcozJfcnuA7i5nyjspIaJv56HiUXmdp
         P4o/dpSs7CUSkEtOWhmDhx1426e6G3fWLEx/7BCdKWTdPvi9RcJGQQ2ul7GMsNd5DLw2
         8uWlsguTZ22PQ3Va+IB6w5O3h4R1q9/4wFMg2l6PDOKxhN33s0RlxJECIXnn7Uy5PX/r
         ckYyuMmmxVMnxe95wJ1nJD/SrSe3eHNiJdsTS2ysHkKfLmak+8aeIH3k/68Zez6TXK1c
         Sa4Q==
X-Gm-Message-State: APjAAAW8m7+Cd7qqExkFnZXidbXSdEimaj4pK9qe+7SoxACYPFlEc/zI
        ii3vQdQklKdvRlOAYCvVAsaUkw==
X-Google-Smtp-Source: APXvYqzIzt4h98MbTFCbO+4J4b5ysB/kMM0PWXSMXtD/Zr6zkhMYrC88dIesOB35SgN/SkTi/ptccA==
X-Received: by 2002:a2e:5d8e:: with SMTP id v14mr67005110lje.106.1559123042285;
        Wed, 29 May 2019 02:44:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id x28sm1141761lfc.2.2019.05.29.02.44.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 02:44:01 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>, stable@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Ensure that PERST is asserted for at least 100 ms
Date:   Wed, 29 May 2019 11:43:52 +0200
Message-Id: <20190529094352.5961-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is only a 1 ms sleep after asserting PERST.

Reading the datasheets for different endpoints, some require PERST to be
asserted for 10 ms in order for the endpoint to perform a reset, others
require it to be asserted for 50 ms.

Several SoCs using this driver uses PCIe Mini Card, where we don't know
what endpoint will be plugged in.

The PCI Express Card Electromechanical Specification specifies:
"On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
the power rails achieving specified operating limits."

Add a sleep of 100 ms before deasserting PERST, in order to ensure that
we are compliant with the spec.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: stable@vger.kernel.org # 4.5+
---
Changes since v1:
Move the sleep into qcom_ep_reset_deassert()

 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0ed235d560e3..5d1713069d14 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -178,6 +178,8 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(100);
 	gpiod_set_value_cansleep(pcie->reset, 0);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
-- 
2.21.0

