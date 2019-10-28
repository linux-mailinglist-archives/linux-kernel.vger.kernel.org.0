Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27B7E759B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfJ1PzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:55:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfJ1PzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:55:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AACD6B2A0;
        Mon, 28 Oct 2019 15:55:18 +0000 (UTC)
Date:   Mon, 28 Oct 2019 08:53:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     eric@anholt.net, wahrenst@gmx.net
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028155354.s3bgq2wazwlh32km@linux-p48b>
References: <20191027221530.12080-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191027221530.12080-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc devel@driverdev.osuosl.org

On Sun, 27 Oct 2019, Bueso wrote:

>There seems no need to be using a semaphore, or a sleeping lock
>in the first place: critical region is extremely short, does not
>call into any blocking calls and furthermore lock and unlocking
>operations occur in the same context.
>
>Get rid of another semaphore user by replacing it with a spinlock.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
>This is in an effort to further reduce semaphore users in the kernel.
>
> .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>index 8dc730cfe7a6..710d21654128 100644
>--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>@@ -63,7 +63,7 @@ static char *g_free_fragments;
> static struct semaphore g_free_fragments_sema;
> static struct device *g_dev;
>
>-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
>+static DEFINE_SPINLOCK(g_free_fragments_lock);
>
> static irqreturn_t
> vchiq_doorbell_irq(int irq, void *dev_id);
>@@ -528,11 +528,11 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>
> 		WARN_ON(g_free_fragments == NULL);
>
>-		down(&g_free_fragments_mutex);
>+		spin_lock(&g_free_fragments_lock);
> 		fragments = g_free_fragments;
> 		WARN_ON(fragments == NULL);
> 		g_free_fragments = *(char **) g_free_fragments;
>-		up(&g_free_fragments_mutex);
>+		spin_unlock(&g_free_fragments_lock);
> 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
> 			(fragments - g_fragments_base) / g_fragments_size;
> 	}
>@@ -591,10 +591,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
> 			kunmap(pages[num_pages - 1]);
> 		}
>
>-		down(&g_free_fragments_mutex);
>+		spin_lock(&g_free_fragments_lock);
> 		*(char **)fragments = g_free_fragments;
> 		g_free_fragments = fragments;
>-		up(&g_free_fragments_mutex);
>+		spin_unlock(&g_free_fragments_lock);
> 		up(&g_free_fragments_sema);
> 	}
>
>-- 
>2.16.4
>
