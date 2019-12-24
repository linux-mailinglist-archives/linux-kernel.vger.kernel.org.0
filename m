Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747F8129E60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 08:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 02:25:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfLXHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A040E223CA7032CD301C;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/6] mmc: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:09 +0800
Message-ID: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhengbin (6):
  mmc: core: use true,false for bool variable
  mmc: sdhci-tegra: use true,false for bool variable
  mmc: sdhci-msm: use true,false for bool variable
  mmc: omap_hsmmc: use true,false for bool variable
  mmc: davinci: use true,false for bool variable
  mmc: owl: use true,false for bool variable

 drivers/mmc/core/core.c        | 2 +-
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 drivers/mmc/host/omap_hsmmc.c  | 6 +++---
 drivers/mmc/host/owl-mmc.c     | 4 ++--
 drivers/mmc/host/sdhci-msm.c   | 4 ++--
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

--
2.7.4

