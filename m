Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4C36658
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFEVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 17:09:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:09:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so5864plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4SOiYMPDMgMZV+MKOdKKhmpmtWM686pXbSZfXaXr6YQ=;
        b=Mi6HXX0anhGF/fyVD0TJ+rBoU8+/2sV4/6KT+SaA6jNtJ9nkggp1lNuo0OuYCkFXOf
         UAKAU5OaYgB3G/z4dWJRiAxPtXuTAqQ823ljiGWmob2ec6SBKGrnOC00mjXuGJ3w9Bma
         5Qqp+z5ebZgLLFm+vUUbZihDioWTGxweObsUb42AoVL+YQqqR9HUYKD+t6Pa158pertg
         ysierxBI6v9s7hTE0eAAaDfUmYePAKY9t34sOdNWUs4QctWbXrb1aXzCBWG0eEtuOENn
         eWoj7rcX5OJIugbTFOwwDFUVKaZAI0nhwoRRcFn01hfhuL2MtkcOFcHcn0WVHzAgUyMM
         CnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4SOiYMPDMgMZV+MKOdKKhmpmtWM686pXbSZfXaXr6YQ=;
        b=s51rdwUtTn7kbZL96Vo0r857OZqTblnjarSACjJ8qS7elibuxGdwYrW6N+MI3eiBgp
         7Gct7fRZtX2okUKIkHphIl8s0GSzonZyuznOr68AKRzZ43t08mgvbnYm5FptzMi3ZDmH
         wMyqeFuC8dePK/HH3J+KZYVngXrwuTNOKYifN7bGX+eUzXxtp7eaQjUAgEmKGe7nPCQW
         82B4ZGm/K8hljEkqWFNqkzEhn0dSNbpTq+yxxEB7XqvsAGopSvhA+EGu1hsXNoHzLI9e
         ZT1BHlKLzccwIhSNES/8oqQqLL0MFEBPKbp3X08YspmuIft4h1QeQMmq5Ub0INSIR7ko
         RmmQ==
X-Gm-Message-State: APjAAAUIkpDn9nd8UVTs7t3d28y/Rdwa5uIpK7NCsqFpwIxgpFlZ4Yq9
        2gIGgfVFGSNz1agEALaiSRfCLg==
X-Google-Smtp-Source: APXvYqwvnaLGrRNt08GZmLk1bVNYK0cJLbYNoDQLhW3tjkGB1XdAbGb6FXGdS+HlXb7YWYAHFwIjNg==
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr7578262plx.202.1559768939617;
        Wed, 05 Jun 2019 14:08:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z68sm5093374pfb.37.2019.06.05.14.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:08:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Patrick Daly <pdaly@codeaurora.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [RFC 0/2] iommu: arm-smmu: Inherit SMR and CB config during init
Date:   Wed,  5 Jun 2019 14:08:54 -0700
Message-Id: <20190605210856.20677-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm devices typically boot with some sort of splash screen on the display,
or for some devices (i.e. recent Qualcomm laptops) an EFI framebuffer. For this
the bootloader allocates a static framebuffer, configures the display hardware
to output this on the display, sets up the SMMU for the display hardware and
jumps to the kernel.

But as the arm-smmu disables all SMRs the display hardware will no longer be
able to access the framebuffer and the result is that the device resets.

The given proposal reads back the SMR state at boot and for marks these
contexts as busy. This ensures that the display hardware will have continued
access to the framebuffer. Once a device is attached we try to match it to the
predefined stream mapping, so that e.g. the display driver will inherit the
particular SMRs/CBs.


This has the positive side effect that on some Qualcomm platforms, e.g. QCS404,
writes to the SMR registers are ignored. But as we inherit the preconfigured
mapping from the bootloader we can use the arm-smmu driver on these platforms.

Bjorn Andersson (2):
  iommu: arm-smmu: Handoff SMR registers and context banks
  iommu: arm-smmu: Don't blindly use first SMR to calculate mask

 drivers/iommu/arm-smmu-regs.h |   2 +
 drivers/iommu/arm-smmu.c      | 100 +++++++++++++++++++++++++++++++---
 2 files changed, 93 insertions(+), 9 deletions(-)

-- 
2.18.0

