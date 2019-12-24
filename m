Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD42C129FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 04:30:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfLXJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:30:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0E2EC0F506D33BC49C;
        Tue, 24 Dec 2019 17:30:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 17:30:45 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/4] tty: use true,false for bool variable
Date:   Tue, 24 Dec 2019 17:38:01 +0800
Message-ID: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhengbin (4):
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

