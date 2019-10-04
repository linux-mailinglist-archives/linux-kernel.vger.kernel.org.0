Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD86CB5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfJDITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 04:19:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9848 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJDITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:19:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9700a40001>; Fri, 04 Oct 2019 01:19:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 01:19:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Oct 2019 01:19:48 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 08:19:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 08:19:48 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.105]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9700a20000>; Fri, 04 Oct 2019 01:19:47 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 0/7] add Tegra194 XUSB host and pad controller support
Date:   Fri, 4 Oct 2019 16:19:34 +0800
Message-ID: <20191004081941.4831-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570177189; bh=coXi3f049m0PjHU3PpzdwtPVvzz4NE0VaXGGgGXwTo8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=kcABtJm1BVK1qYkcQXp9dPPTVKPFIUJK707vMjr97PfRNSAdWRFW0pyK5nrE6weqx
         smxZjh4VwbHLrS1iYs4es9x/0lMMk+YlfpZFMbGe5hbyZDL1sIARGarmsooE5V6Ob5
         YW/r+olDPRCSttDjz5ex/IB84zyTeiiDxrSU2pQnm4pcQ0I5HpJrBcU6/uHwhI9kck
         kAVYrQUCaEkSlSnzUKiwfJXsBD1iZFaaHVnzNKXeQmmcN9l79SeLRXLAmEgpDc3Aq6
         jUsUSIzdFJxmpFxWha2qrgdgA0kyprv22GkdN4jlixQRAUGxHTOpWRAoWDGNe6znBN
         numEbk8ugb4Og==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces support for Tegra194 XUSB host and pad
controller. Tegra194 XUSB host and pad controller are highly
similar to the controllers found on Tegra186. Therefore, it's
possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.

JC Kuo (7):
  xhci: tegra: Parameterize mailbox register addresses
  usb: host: xhci-tegra: Add Tegra194 XHCI support
  phy: tegra: xusb: Protect Tegra186 soc with config
  phy: tegra: xusb: Add Tegra194 support
  dt-bindings: phy: tegra: Add Tegra194 support
  arm64: tegra: Add XUSB and pad controller on Tegra194
  arm64: tegra: Enable XUSB host in P2972-0000 board

 .../phy/nvidia,tegra124-xusb-padctl.txt       |  16 ++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  36 ++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  62 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 139 +++++++++++++++++
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             | 144 +++++++++++++-----
 drivers/phy/tegra/xusb.c                      |   7 +
 drivers/phy/tegra/xusb.h                      |   6 +
 drivers/usb/host/xhci-tegra.c                 |  88 +++++++++--
 9 files changed, 448 insertions(+), 51 deletions(-)

-- 
2.17.1

