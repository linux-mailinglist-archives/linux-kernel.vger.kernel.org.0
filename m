Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E169E5514
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJYUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 16:25:39 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35304 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfJYUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:25:39 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69R-00078b-Ir; Fri, 25 Oct 2019 14:25:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69Q-00038u-Ip; Fri, 25 Oct 2019 14:25:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 25 Oct 2019 14:25:32 -0600
Message-Id: <20191025202535.12036-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,LR_URI_NUMERIC_ENDING,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 0/3] Passthru Execute Request Interface
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just an RFC meant to get some early feedback on the core
interface for executing passthru commands that will be needed
in the upcomming nvmet passth patchset.

The first patch moves the calls to nvme_passthru_[start|end]() into
a common helper such that all passthru requests will call them.

The second patch does a bit of code reorganization for the third patch.

The third patch proposes a new nvme_execute_passthru_rq_nowait() interface
for the nvmet passthru code. For commands that have no effects it is
simply equivalent to blk_execute_rq_nowait(). For commands that
has effects, it pushes the command submission to a work queue. This
requires adding a work struct to nvme_request.

The code that will use this interfcae can be seen in the WIP passthru
patch[1]. It helps clean things up considerably from the last submission
of the patch.

Thanks,

Logan

[1] https://github.com/sbates130272/linux-p2pmem/commit/a468e458795e6df6483ad8c98635536d6da31064

--

Logan Gunthorpe (3):
  nvme: Move nvme_passthru_[start|end]() calls to common code
  nvme: Create helper function to obtain command effects
  nvme: Introduce nvme_execute_passthru_rq_nowait()

 drivers/nvme/host/core.c | 228 ++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |   7 ++
 2 files changed, 147 insertions(+), 88 deletions(-)

--
2.20.1
