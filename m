Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D087D1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 01:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfGaXfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 19:35:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39860 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbfGaXfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:35:43 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsy8B-0003W3-Ki; Wed, 31 Jul 2019 17:35:43 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsy89-0001Gr-IZ; Wed, 31 Jul 2019 17:35:37 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 31 Jul 2019 17:35:30 -0600
Message-Id: <20190731233534.4841-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, chaitanya.kulkarni@wdc.com, maxg@mellanox.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v3 0/4] Varios NVMe Fixes
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

These patches are just a resend of a bunch I've sent that
haven't been picked up yet. I don't want them to get forgotten.

Thanks,

Logan

--

Logan Gunthorpe (4):
  nvmet: Fix use-after-free bug when a port is removed
  nvmet-loop: Flush nvme_delete_wq when removing the port
  nvmet-file: fix nvmet_file_flush() always returning an error
  nvme-core: Fix extra device_put() call on error path

 drivers/nvme/host/core.c       |  2 +-
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 +++++++++++++++
 drivers/nvme/target/loop.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  3 +++
 5 files changed, 28 insertions(+), 1 deletion(-)

--
2.20.1
