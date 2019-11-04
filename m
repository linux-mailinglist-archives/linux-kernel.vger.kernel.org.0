Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2FEE5F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfKDRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:25:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbfKDRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:25:33 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 986C7C0D8199739DA203;
        Tue,  5 Nov 2019 01:25:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 01:25:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/5] hisi_lpc: Improve build test coverage
Date:   Tue, 5 Nov 2019 01:22:14 +0800
Message-ID: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the build test cover of the driver by
supporting building under COMPILE_TEST.

I also included "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops
are set at registration" as it was never picked up for 5.4.

Two new patches are also included since v1:
- clean issues detected by sparse
- build logic_pio.o into /lib library

Since v2 I limited test coverage for archs which don't define
{read, write}sb().

John Garry (5):
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration
  logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
  bus: hisi_lpc: Clean some types
  bus: hisi_lpc: Expand build test coverage
  logic_pio: Build into a library

 drivers/bus/Kconfig       |  5 +++--
 drivers/bus/hisi_lpc.c    |  9 ++++-----
 include/linux/logic_pio.h |  4 ++--
 lib/Makefile              |  2 +-
 lib/logic_pio.c           | 14 ++++++++------
 5 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.17.1

