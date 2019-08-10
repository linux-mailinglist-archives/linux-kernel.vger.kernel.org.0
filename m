Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D688D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHJUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 16:08:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfHJUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:08:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwXek-0007tM-1c; Sat, 10 Aug 2019 22:08:02 +0200
Date:   Sat, 10 Aug 2019 20:01:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.3-rc4
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
Message-ID: <156546731194.17538.17579538052592105669.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  491beed3b102: genirq/affinity: Create affinity mask for single vector

A small fix for the affinity spreading code. It failed to handle situations
where a single vector was requested either due to only one CPU being
available or vector exhaustion causing only a single interrupt to be
granted. The fix is to simply remove the requirement in the affinity
spreading code for more than one interrupt being available.

Thanks,

	tglx

------------------>
Ming Lei (1):
      genirq/affinity: Create affinity mask for single vector


 kernel/irq/affinity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4352b08ae48d..6fef48033f96 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 * Determine the number of vectors which need interrupt affinities
 	 * assigned. If the pre/post request exhausts the available vectors
 	 * then nothing to do here except for invoking the calc_sets()
-	 * callback so the device driver can adjust to the situation. If there
-	 * is only a single vector, then managing the queue is pointless as
-	 * well.
+	 * callback so the device driver can adjust to the situation.
 	 */
-	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
+	if (nvecs > affd->pre_vectors + affd->post_vectors)
 		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	else
 		affvecs = 0;

