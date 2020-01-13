Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1C13896D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 03:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgAMCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 21:09:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732676AbgAMCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:09:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20E472C5DB99BA276497;
        Mon, 13 Jan 2020 10:09:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 10:09:00 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH RESEND 0/4] tty: use true,false for bool variable
Date:   Mon, 13 Jan 2020 10:16:13 +0800
Message-ID: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use real name 'Zheng Bin', instead of zhengbin

Zheng Bin (4):
  tty: synclink_gt: use true,false for bool variable
  tty/serial: kgdb_nmi: use true,false for bool variable
  tty/serial: atmel: use true,false for bool variable
  tty/serial: 8250_exar: use true,false for bool variable

 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 drivers/tty/serial/atmel_serial.c   | 6 +++---
 drivers/tty/serial/kgdb_nmi.c       | 4 ++--
 drivers/tty/synclink_gt.c           | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

--
2.7.4

