Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2F85B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfHHHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 03:04:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52386 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:04:37 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvcTS-0001eO-On; Thu, 08 Aug 2019 09:04:34 +0200
Date:   Thu, 8 Aug 2019 09:04:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] genirq/affinity: report extra vectors on uneven nodes
In-Reply-To: <20190807201051.32662-1-jonathan.derrick@intel.com>
Message-ID: <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Jon Derrick wrote:

Cc+: Ming, Christoph.

Left context for reference.

> The current irq spreading algorithm spreads vectors amongst cpus evenly
> per node. If a node has more cpus than another node, the extra vectors
> being spread may not be reported back to the caller.
> 
> This is most apparent with the NVMe driver and nr_cpus < vectors, where
> the underreporting results in the caller's WARN being triggered:
> 
> irq_build_affinity_masks()
> ...
> 	if (nr_present < numvecs)
> 		WARN_ON(nr_present + nr_others < numvecs);
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  kernel/irq/affinity.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4352b08ae48d..9beafb8c7e92 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  	}
>  
>  	for_each_node_mask(n, nodemsk) {
> -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> +		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
> +			vecs_per_node;
>  
>  		/* Spread the vectors per node */
>  		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> @@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  
>  		/* Account for rounding errors */
>  		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
> +		total_vecs_to_assign = vecs_to_assign + extra_vecs;
>  
> -		for (v = 0; curvec < last_affv && v < vecs_to_assign;
> +		for (v = 0; curvec < last_affv && v < total_vecs_to_assign;
>  		     curvec++, v++) {
>  			cpus_per_vec = ncpus / vecs_to_assign;
>  
>  			/* Account for extra vectors to compensate rounding errors */
>  			if (extra_vecs) {
>  				cpus_per_vec++;
> +				v++;
>  				--extra_vecs;
>  			}
>  			irq_spread_init_one(&masks[curvec].mask, nmsk,
> -- 
> 2.20.1
> 
> 
