Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9FA994B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 06:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfIEERs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 00:17:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60448 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEERs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:17:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jDF-0005mD-Ee; Thu, 05 Sep 2019 14:17:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:17:35 +1000
Date:   Thu, 5 Sep 2019 14:17:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] padata: make flushing work with async users
Message-ID: <20190905041734.GA25330@gondor.apana.org.au>
References: <20190828221425.22701-1-daniel.m.jordan@oracle.com>
 <20190828221425.22701-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828221425.22701-2-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:14:21PM -0400, Daniel Jordan wrote:
>
> @@ -453,24 +456,15 @@ static void padata_free_pd(struct parallel_data *pd)
>  /* Flush all objects out of the padata queues. */
>  static void padata_flush_queues(struct parallel_data *pd)
>  {
> -	int cpu;
> -	struct padata_parallel_queue *pqueue;
> -	struct padata_serial_queue *squeue;
> -
> -	for_each_cpu(cpu, pd->cpumask.pcpu) {
> -		pqueue = per_cpu_ptr(pd->pqueue, cpu);
> -		flush_work(&pqueue->work);
> -	}
> -
> -	if (atomic_read(&pd->reorder_objects))
> -		padata_reorder(pd);
> +	if (!(pd->pinst->flags & PADATA_INIT))
> +		return;
>  
> -	for_each_cpu(cpu, pd->cpumask.cbcpu) {
> -		squeue = per_cpu_ptr(pd->squeue, cpu);
> -		flush_work(&squeue->work);
> -	}
> +	if (atomic_dec_return(&pd->refcnt) == 0)
> +		complete(&pd->flushing_done);
>  
> -	BUG_ON(atomic_read(&pd->refcnt) != 0);
> +	wait_for_completion(&pd->flushing_done);
> +	reinit_completion(&pd->flushing_done);
> +	atomic_set(&pd->refcnt, 1);
>  }

I don't think waiting is an option.  In a pathological case the
hardware may not return at all.  We cannot and should not hold off
CPU hotplug for an arbitrary amount of time when the event we are
waiting for isn't even occuring on that CPU.

I don't think flushing is needed at all.  All we need to do is
maintain consistency before and after the CPU hotplug event.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
