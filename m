Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4042DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfFLRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 13:53:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbfFLRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZ87rVtdmY1eGd95PUVDy3tMWfEEw5cY4NhGsls2pmY=; b=cCsuTfHBvSOEBZ4JLPLlnhMKWa
        9kQ16ujX5siIoNWjVqfmILJ2oEm7eQ2WZy260SY4NT30Vy1NI15GXgHta5unalAOMiFoUkU7xaiUk
        4H+TrGW53udv+kR4ogsDSRW2iiA8fLFVrmahhv07hNNdp3lQ8nllhrti97KGXVjQriej4VIYADdtr
        5PwdOmQhnnlgkCXOoOiWzMmHZ/LqJW/TZCoynBBcMOzyY2hSEYrFgALrxF+GMFs2iMamcRnCtoxPB
        CtQtt7NZ+jkPmbgauR70JqtJHy/xhm2Av6n7oIt8QA46aBf/8nZ1QmZqR9gWCp7phGXbcQf58Uoa0
        nIjRqoRw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002DU-1u; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001g0-3M; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 06/28] docs: cgroup-v1/blkio-controller.rst: add a note about CFQ scheduler
Date:   Wed, 12 Jun 2019 14:52:42 -0300
Message-Id: <1744c7301a89dc69601fea6955c08404e6a1d39b.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFQ scheduler was removed on this changeset:

  commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
  Author: Jens Axboe <axboe@kernel.dk>
  Date:   Fri Oct 12 10:14:46 2018 -0600

    block: remove legacy IO schedulers

    Retain the deadline documentation, as that carries over to mq-deadline
    as well.

    Tested-by: Ming Lei <ming.lei@redhat.com>
    Reviewed-by: Omar Sandoval <osandov@fb.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

However, the cgroups-v1 documentation still mentions it and points
to a removed file that used to belong to such scheduler.

Add a note about that, as someone needs to fix the document pointing
to another scheduler, if cgroups-v1 blockio is not dependent of
CFQ scheduler.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/cgroup-v1/blkio-controller.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/cgroup-v1/blkio-controller.rst b/Documentation/cgroup-v1/blkio-controller.rst
index 2c1b907afc14..2836c2c31e63 100644
--- a/Documentation/cgroup-v1/blkio-controller.rst
+++ b/Documentation/cgroup-v1/blkio-controller.rst
@@ -17,6 +17,13 @@ one is throttling policy which can be used to specify upper IO rate limits
 on devices. This policy is implemented in generic block layer and can be
 used on leaf nodes as well as higher level logical devices like device mapper.
 
+.. note::
+
+   While this document mentions the CFQ scheduler, it got removed at
+   Kernel 4.20, as there are other schedulers that are more efficient.
+
+   Someone needs to update this file in order to reflect such change.
+
 HOWTO
 =====
 Proportional Weight division of bandwidth
-- 
2.21.0

