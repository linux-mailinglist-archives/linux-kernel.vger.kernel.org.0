Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBB174492
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 03:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB2Cwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 21:52:37 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:40481 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2Cwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 21:52:36 -0500
Received: from localhost (c-71-238-64-75.hsd1.or.comcast.net [71.238.64.75])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3EC1F200007;
        Sat, 29 Feb 2020 02:52:30 +0000 (UTC)
Date:   Fri, 28 Feb 2020 18:52:28 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Check for readiness more quickly, to speed up boot time
Message-ID: <20200229025228.GA203607@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After initialization, nvme_wait_ready checks for readiness every 100ms,
even though the drive may be ready far sooner than that. This delays
system boot by hundreds of milliseconds. Reduce the delay, checking for
readiness every millisecond instead.

Boot-time tests on an AWS c5.12xlarge:

Before:
[    0.546936] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
...
[    0.764178] nvme nvme0: 2/0/0 default/read/poll queues
[    0.768424]  nvme0n1: p1
[    0.774132] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.774146] VFS: Mounted root (ext4 filesystem) on device 259:1.
...
[    0.788141] Run /sbin/init as init process

After:
[    0.537088] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
...
[    0.543457] nvme nvme0: 2/0/0 default/read/poll queues
[    0.548473]  nvme0n1: p1
[    0.554339] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.554344] VFS: Mounted root (ext4 filesystem) on device 259:1.
...
[    0.567931] Run /sbin/init as init process

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..04174a40b9b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 		if ((csts & NVME_CSTS_RDY) == bit)
 			break;
 
-		msleep(100);
+		usleep_range(1000, 2000);
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-- 
2.25.1

