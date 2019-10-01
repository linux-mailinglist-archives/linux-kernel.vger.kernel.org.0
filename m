Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F40C39FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbfJAQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:07:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfJAQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:07:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63D0EA5A589137093EB3;
        Wed,  2 Oct 2019 00:07:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 2 Oct 2019 00:07:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <bhelgaas@google.com>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] hisi_lpc: Improve build test coverage
Date:   Wed, 2 Oct 2019 00:04:24 +0800
Message-ID: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the build test cover of the driver by
supporting building under COMPILE_TEST.

I also included "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops
are set at registration" as it was never picked up for 5.4.

John Garry (3):
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration
  logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
  bus: hisi_lpc: Expand build test coverage

 drivers/bus/Kconfig       |  4 ++--
 include/linux/logic_pio.h |  4 ++--
 lib/logic_pio.c           | 14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.17.1

