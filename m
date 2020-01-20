Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B58142667
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgATI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 03:59:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbgATI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579510749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOihZ07JJijUAk3UpxjX9RG7atOa9W0V80tsgdS9iBM=;
        b=bsUJbV6atkbZmWyIlWtH36bALFv3K1OxBWyoysLG8nEwnLE52j0Ngno6h3nOK+MweuF2eb
        n71WwSWC9+hbx/tgWX8ubOcwgav+URcM5jOiYFNukKzgwYwRhPYQattAjiMzH79IIcbMiD
        QQSaoG/NPcpr/uxgOYg94fVvXh9Gs2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-E2Sk6cHtOpGnk39x4Lf3xg-1; Mon, 20 Jan 2020 03:59:06 -0500
X-MC-Unique: E2Sk6cHtOpGnk39x4Lf3xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDAA800D48;
        Mon, 20 Jan 2020 08:59:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ADB51001DD7;
        Mon, 20 Jan 2020 08:58:54 +0000 (UTC)
Date:   Mon, 20 Jan 2020 16:58:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH V3] sched/isolation: isolate from handling managed
 interrupt
Message-ID: <20200120085849.GA21740@ming.t460p>
References: <20200118125354.15796-1-ming.lei@redhat.com>
 <87ftgb4chi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftgb4chi.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Sun, Jan 19, 2020 at 05:50:17PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> >  
> > +static bool hk_should_isolate(struct irq_data *data,
> > +		const struct cpumask *affinity, unsigned int cpu)
> 
> Please align the first argument on the second line with the first
> argument on the first line.
> 
> > +{
> > +	const struct cpumask *hk_mask;
> > +
> > +	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
> > +		return false;
> > +
> > +	if (!irqd_affinity_is_managed(data))
> > +		return false;
> 
> Pointless. That's already checked at the begin of the calling function.
> 
> > +
> > +	if (!cpumask_test_cpu(cpu, affinity))
> > +		return false;
> 
> Ditto.
> 
> > +	hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> > +	if (cpumask_subset(affinity, hk_mask))
> > +		return false;
> > +
> > +	if (cpumask_intersects(irq_data_get_effective_affinity_mask(data),
> > +				hk_mask))
> 
> I really had to think twice why this is correct. The example I gave you
> is far more intuitive. It's just missing the check below.

Your example uses isolation mask, which has to be allocated and built
from housekeeping_cpumask(HK_FLAG_MANAGED_IRQ), that is why I use the
above way so that we can avoid the allocation.

IMO, the above is intuitive too, given it can be thought as effective
affinity including hk CPUs.

Thanks,
Ming

