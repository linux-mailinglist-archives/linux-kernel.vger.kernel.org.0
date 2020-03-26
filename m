Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE05919393C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 08:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCZHIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 03:08:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCZHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:08:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so6375983wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=afg8dNB66EeO23R6bSZJHyegs9ORKcUpXptgDs7UTws=;
        b=NkGvO6uYSAMxMcb9P0RAg0D3yHckMsjCJgy81OSyDdL8EF5sHoZxsihiKBUJYqIQO0
         FkmG1UfasybW7KR8tmBkKkkF3pTqzVP3/mgrEq2721W34udH76Kg/t0NKLtbP6vyBlpc
         0zMeDxmnwXlItGBygP6bdmXi34qI8MUNpDSm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=afg8dNB66EeO23R6bSZJHyegs9ORKcUpXptgDs7UTws=;
        b=KOoOfT51p5Sz950A82XVpio+tw5cSwxMvruPjKZlWKS15UJrPutzlKFE9SGtl7YFbO
         vWNxNI3gsfw8V5nyeBwoIV42IyFoOr8DajUH/8H6DHhyEG36Pxb7oGBlcxl/SSt+22jO
         SnOieiaIEQBASNWSwLlpdGg74nuHWQAbQ8wZnquTnMoI3kLsvAblio/acuzfjAHNrPdY
         7JbV32vFuRDdxUc5r2ncxCkXWCWboM9IxNHlu1hPVXrYZt/DlxIfrURC1XQ1iDwGNEKG
         pNFFi/xTWjQ7px4uX+S+TcUNlagRhgpFLFehK/v25CsGbrzovbT2xg64hfG+Oj7ZGF3+
         zMOQ==
X-Gm-Message-State: ANhLgQ16g7IadToOALVteaXV6Rn8tBOZfARKWuh8mHm8dnvqFSUF2RlA
        pnoCt0fgyNtoF+6AvEYDhE9WUg==
X-Google-Smtp-Source: ADFU+vs4AXz8FI0fPBQ54wsPqGouqEqXUvwleEGkLy2ntX9wK7IYngl27SxZG3aUl2DSzFShBbL0tA==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr7161551wrm.138.1585206483395;
        Thu, 26 Mar 2020 00:08:03 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:08:02 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: [PATCH 1/3] PCI: iproc: fix out of bound array access
Date:   Thu, 26 Mar 2020 12:37:25 +0530
Message-Id: <1585206447-1363-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Gooty <bharat.gooty@broadcom.com>

Declare the full size array for all revisions of PAX register sets
to avoid potentially out of bound access of the register array
when they are being initialized in the 'iproc_pcie_rev_init'
function.

Fixes: 06324ede76cdf ("PCI: iproc: Improve core register population")
Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 0a468c7..6972ca4 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -307,7 +307,7 @@ enum iproc_pcie_reg {
 };
 
 /* iProc PCIe PAXB BCMA registers */
-static const u16 iproc_pcie_reg_paxb_bcma[] = {
+static const u16 iproc_pcie_reg_paxb_bcma[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -318,7 +318,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
 };
 
 /* iProc PCIe PAXB registers */
-static const u16 iproc_pcie_reg_paxb[] = {
+static const u16 iproc_pcie_reg_paxb[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -334,7 +334,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
 };
 
 /* iProc PCIe PAXB v2 registers */
-static const u16 iproc_pcie_reg_paxb_v2[] = {
+static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -363,7 +363,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 };
 
 /* iProc PCIe PAXC v1 registers */
-static const u16 iproc_pcie_reg_paxc[] = {
+static const u16 iproc_pcie_reg_paxc[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
@@ -372,7 +372,7 @@ static const u16 iproc_pcie_reg_paxc[] = {
 };
 
 /* iProc PCIe PAXC v2 registers */
-static const u16 iproc_pcie_reg_paxc_v2[] = {
+static const u16 iproc_pcie_reg_paxc_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
 	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
 	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
-- 
2.7.4

