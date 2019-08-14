Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11258CEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHNIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 04:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfHNIle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 608DE46671;
        Wed, 14 Aug 2019 08:41:34 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8EB19C68;
        Wed, 14 Aug 2019 08:41:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH V4 0/3] genriq/affinity: Make vectors allocation fair
Date:   Wed, 14 Aug 2019 16:40:41 +0800
Message-Id: <20190814084044.21699-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 14 Aug 2019 08:41:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 1st  patch enhances one warning check.

The 2nd patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 3rd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

Please review & comment!

V4:
	- provide proof why number of allocated vectors for each node is <= CPU
	  count of this node

V3:
	- re-order the patchset
	- add helper of irq_spread_vectors_on_node()
	- handle vector spread correctly in case that numvecs is > ncpus
	- return -ENOMEM to API's caller

V2:
	- add patch3
	- start to allocate vectors from node with minimized CPU number,
	  then every node is guaranteed to be allocated at least one vector.
	- avoid cross node spread


Ming Lei (3):
  genirq/affinity: Enhance warning check
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio

 kernel/irq/affinity.c | 243 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 209 insertions(+), 34 deletions(-)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>
-- 
2.20.1

