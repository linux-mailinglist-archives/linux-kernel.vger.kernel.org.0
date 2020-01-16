Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3048F13D75F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgAPKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:01:35 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:57398 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730652AbgAPKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:01:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06713096|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.236711-0.0800231-0.683266;DS=CONTINUE|ham_system_inform|0.0724902-0.00115022-0.92636;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07426;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gd3Kgdg_1579168866;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gd3Kgdg_1579168866)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 16 Jan 2020 18:01:12 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 00/11] pstore: support crash log to block and mtd device
Date:   Thu, 16 Jan 2020 18:00:20 +0800
Message-Id: <1579168831-16399-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why should we need to log to block (mtd) device?
1. Most embedded intelligent equipment have no persistent ram, which
   increases costs. We perfer to cheaper solutions, like block devices.
2. Do not any equipment have battery, which means that it lost all data
   on general ram if power failure. Pstore has little to do for these
   equipments.

Why should we adapt pstore/blk to MTD device instead of mtdoops?
1. repetitive jobs between pstore and mtdoops
   Both of pstore and mtdoops do the same jobs that store panic/oops log.
2. do what a driver should do
   To me, a driver should provide methods instead of policies. What MTD
   should do is to provide read/write/erase operations, geting rid of codes
   about chunk management, kmsg dumper and configuration.
3. enhanced feature
   Not only store log, but also show it as files.
   Not only log, but also trigger time and trigger count.
   Not only panic/oops log, but also log recorder for pmsg, console and
   ftrace in the future.

Before upstream submission, pstore/blk is tested on arch ARM and x84_64,
block device and mtd device, built as modules and in kernel. Here are the
details:

	https://github.com/gmpy/articles/blob/master/pstore/Test-Pstore-Block.md

WeiXiong Liao (11):
  pstore/blk: new support logger for block devices
  blkoops: add blkoops, a warpper for pstore/blk
  pstore/blk: support pmsg recorder
  pstore/blk: blkoops: support console recorder
  pstore/blk: blkoops: support ftrace recorder
  Documentation: pstore/blk: blkoops: create document for pstore_blk
  pstore/blk: skip broken zone for mtd device
  blkoops: respect for device to pick recorders
  pstore/blk: blkoops: support special removing jobs for dmesg.
  blkoops: add interface for dirver to get information of blkoops
  mtd: new support oops logger based on pstore/blk

 Documentation/admin-guide/pstore-block.rst |  297 ++++++
 MAINTAINERS                                |    3 +-
 drivers/mtd/Kconfig                        |   10 +
 drivers/mtd/Makefile                       |    1 +
 drivers/mtd/mtdpstore.c                    |  531 +++++++++++
 fs/pstore/Kconfig                          |  109 +++
 fs/pstore/Makefile                         |    5 +
 fs/pstore/blkoops.c                        |  490 ++++++++++
 fs/pstore/blkzone.c                        | 1341 ++++++++++++++++++++++++++++
 include/linux/blkoops.h                    |   94 ++
 include/linux/pstore_blk.h                 |   91 ++
 11 files changed, 2971 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/pstore-block.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blkoops.c
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/blkoops.h
 create mode 100644 include/linux/pstore_blk.h

-- 
1.9.1

