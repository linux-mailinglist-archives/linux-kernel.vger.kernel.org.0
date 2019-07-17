Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3626B752
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfGQHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 03:20:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40150 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:20:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so23527054wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 00:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q7vSPFdz5CEYOwSreUnRICAWUDFGoG4IPZiYDw1Erec=;
        b=Y+aqX6tUoDDxZF6w9qtKEv8gsdhjvbZgUJE0fFr+OzNNjsjzE/YxYSP1HJhA+Z1P9J
         JrRsTGLI60VaJEiKccVAt7d/lNpv7zlwSqKYzSLM6UZzX7i2Fa9tO5Ttw3SzCbJBqCkQ
         Yz72o2Q2ptQAtTLipRTKG9xu5KOLItDnS/BFAWbvzq9AkHODfjTO11Uprdg5qb0fq29b
         t9fpKlUivdjAYeEBlIjwdxmYF2H3nnGR/EfORATxCrdjsH8814mlRBiSzK4+sMMOzkvZ
         3Q3oLgD6woaFcG7GgLP+hpBX2UUd6qGsDRgUuv3eu1Sx7oVn67KzEbKDhF7iCh9/oEGM
         YtoA==
X-Gm-Message-State: APjAAAXw0m4gsgFTWlPo9BJqTOND73c+8y69zGEpLGOk6YI/E0sd+hw5
        kOIdrP9FDciUciCHVK5J9BWa9Q==
X-Google-Smtp-Source: APXvYqxZ/oRc6LQuDTtdo3kTgTyUlud+FKAPr527BLTa+duWXgkOfSA/Eap/fmt1dPjCEDwWBe0OHA==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr41545907wru.141.1563348038987;
        Wed, 17 Jul 2019 00:20:38 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id n12sm23490884wmc.24.2019.07.17.00.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 00:20:38 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     rostedt@goodmis.org, tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] net/xfrm/xfrm_ipcomp: Use {get,put}_cpu_light
Date:   Wed, 17 Jul 2019 09:20:19 +0200
Message-Id: <20190717072019.13681-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following BUG has been reported while running ipsec tests.

 BUG: scheduling while atomic: irq/78-eno3-rx-/12023/0x00000002
 Modules linked in: ipcomp xfrm_ipcomp ...
 Preemption disabled at:
 [<ffffffffc0b29730>] ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
 CPU: 1 PID: 12023 Comm: irq/78-eno3-rx- Kdump: loaded Not tainted [...] #1
 Hardware name: [...]
 Call Trace:
  dump_stack+0x5c/0x80
  ? ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
  __schedule_bug.cold.81+0x44/0x51
  __schedule+0x5bf/0x6a0
  schedule+0x39/0xd0
  rt_spin_lock_slowlock_locked+0x10e/0x2b0
  rt_spin_lock_slowlock+0x50/0x80
  get_page_from_freelist+0x609/0x1560
  ? zlib_updatewindow+0x5a/0xd0
  __alloc_pages_nodemask+0xd9/0x280
  ipcomp_input+0x299/0x9a0 [xfrm_ipcomp]
  xfrm_input+0x5e3/0x960
  xfrm4_ipcomp_rcv+0x34/0x50
  ip_local_deliver_finish+0x22d/0x250
  ip_local_deliver+0x6d/0x110
  ? ip_rcv_finish+0xac/0x480
  ip_rcv+0x28e/0x3f9
  ? packet_rcv+0x43/0x4c0
  __netif_receive_skb_core+0xb7c/0xd10
  ? inet_gro_receive+0x8e/0x2f0
  netif_receive_skb_internal+0x4a/0x160
  napi_gro_receive+0xee/0x110
  tg3_rx+0x2a8/0x810 [tg3]
  tg3_poll_work+0x3b3/0x830 [tg3]
  tg3_poll_msix+0x3b/0x170 [tg3]
  net_rx_action+0x1ff/0x470
  ? __switch_to_asm+0x41/0x70
  do_current_softirqs+0x223/0x3e0
  ? irq_thread_check_affinity+0x20/0x20
  __local_bh_enable+0x51/0x60
  irq_forced_thread_fn+0x5e/0x80
  ? irq_finalize_oneshot.part.45+0xf0/0xf0
  irq_thread+0x13d/0x1a0
  ? wake_threads_waitq+0x30/0x30
  kthread+0x112/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x35/0x40

The problem resides in the fact that get_cpu() called from ipcomp_input()
disables preemption, and that triggers the scheduling while atomic BUG further
down the callpath chain of get_page_from_freelist(), i.e.,

  ipcomp_input
    ipcomp_decompress
      <-- get_cpu()
      alloc_page(GFP_ATOMIC)
        alloc_pages(GFP_ATOMIC, 0)
          alloc_pages_current
            __alloc_pages_nodemask
              get_page_from_freelist
                (try_this_zone:) rmqueue
                  rmqueue_pcplist
                    __rmqueue_pcplist
                      rmqueue_bulk
                        <-- spin_lock(&zone->lock) - BUG

Fix this by using {get,put}_cpu_light() in ipcomp_decompress().

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

This has been found on a 4.19.x-rt kernel, but 5.x-rt(s) are affected as
well.

Best,

Juri
---
 net/xfrm/xfrm_ipcomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a00ec715aa46..39d9e663384f 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -45,7 +45,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	const int plen = skb->len;
 	int dlen = IPCOMP_SCRATCH_SIZE;
 	const u8 *start = skb->data;
-	const int cpu = get_cpu();
+	const int cpu = get_cpu_light();
 	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);
 	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
 	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
@@ -103,7 +103,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	err = 0;
 
 out:
-	put_cpu();
+	put_cpu_light();
 	return err;
 }
 
-- 
2.17.2

