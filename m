Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D08510C123
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfK1AuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 19:50:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfK1AuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:50:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AAFB599458BE232F3200;
        Thu, 28 Nov 2019 08:50:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 28 Nov 2019 08:49:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <pmladek@suse.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tj@kernel.org>, <arnd@arndb.de>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/4] part2: kill pr_warning from kernel
Date:   Thu, 28 Nov 2019 08:47:48 +0800
Message-ID: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the part2 of kill pr_warning, as most pr_warning conversion merged
into v5.5, let's cleanup the last two stragglers. Then, completely drop
pr_warning defination in printk.h and check in checkpatch.pl.

Part1: https://lore.kernel.org/lkml/20190920062544.180997-1-wangkefeng.wang@huawei.com

Kefeng Wang (4):
  workqueue: Use pr_warn instead of pr_warning
  staging: isdn: gigaset: Use pr_warn instead of pr_warning
  printk: Drop pr_warning definition
  checkpatch: Drop pr_warning check

 drivers/staging/isdn/gigaset/interface.c | 2 +-
 include/linux/printk.h                   | 3 +--
 kernel/workqueue.c                       | 4 ++--
 scripts/checkpatch.pl                    | 9 ---------
 4 files changed, 4 insertions(+), 14 deletions(-)

-- 
2.20.1

