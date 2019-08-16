Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE68F8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHPC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 22:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfHPC3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:29:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBBDA30917EF;
        Fri, 16 Aug 2019 02:29:02 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52A3B7DA3E;
        Fri, 16 Aug 2019 02:28:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH V5 0/2] genriq/affinity: Make vectors allocation fair
Date:   Fri, 16 Aug 2019 10:28:47 +0800
Message-Id: <20190816022849.14075-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 02:29:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 2nd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

Please consider it for V5.4.

V5:
	- remove patch 1 of V4, which is wrong
	- handle vector wrapping because the 'start vector' may begin
	  anywhere, especially for the 2nd stage spread
	- add more comment on the vector allocation algorithm
	- cleanup code a bit
	- run more tests to verify the change, which always get the
	expected result. Covers lots of num_queues, numa topo, CPU
	unpresent setting.

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

Ming Lei (2):
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio

 kernel/irq/affinity.c | 215 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 194 insertions(+), 21 deletions(-)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>

-- 
2.20.1

