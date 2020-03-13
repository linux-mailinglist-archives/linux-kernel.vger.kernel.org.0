Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315161845BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCMLPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:15:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60957 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbgCMLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:15:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584098148; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=yJY+6dCHitU8f2/WN4ruK25OBJeP1BZ47G3o5vW+Sag=; b=eOdXM4/NTUJo//7/a+hW112/HuAb/i0yCV26yriKoPL8geseHCHvnpGowWVUJ8R9ktCWj4cc
 N4F9j4c1xa1wakkofBV6Tk4g4LSozXRonBj3dVpvJxklvXJCXcVKgITkPG4OZT7FE+r+BvqE
 az2Hs3HRa4eYvY2O3nCOVexo6Rw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b6b55.7f246bf73340-smtp-out-n02;
 Fri, 13 Mar 2020 11:15:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFB61C433D2; Fri, 13 Mar 2020 11:15:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30D11C433BA;
        Fri, 13 Mar 2020 11:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30D11C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V2 0/2] Convert QSPI binding to YAML and add interconnect doc
Date:   Fri, 13 Mar 2020 16:45:19 +0530
Message-Id: <1584098121-18075-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akash Asthana (2):
  dt-bindings: spi: Convert QSPI bindings to YAML
  dt-bindings: spi: Add interconnect binding for QSPI

 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ---------
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           | 88 ++++++++++++++++++++++
 2 files changed, 88 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
