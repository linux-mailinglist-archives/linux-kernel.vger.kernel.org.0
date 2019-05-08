Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA717178E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfEHLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 07:51:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfEHLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EtD17I6eM/gvLeULv57O+WrfYxDZ8cGTbR0hH/IWr3E=; b=I81VxBXCZOmy2fNQv+qDSoTT3
        Qjv439anWO8FhqSaK3u+KNVGSJZz6js3qPL9aDuQrSBq2sYuUumMDjBa2nWD5gfM/PTKJGYLxUmDX
        9rqVMfn5Pvhr5S+JsmPq5LBPEQho0GDJ/wd/6Ln95OCg9QNxSApUATGWeJANHOkRKblXMZUXeO3Ao
        xP0tZq8SvZzrPgRyA3Xsx2Uz+sVJsYPXf4lovEH2zqRQ+OVgGNT6NFgYM4MjoR3GSyvRDXFlGMD9r
        ibKtyyT4Vz/n31lStMYQ6Jd/1AHCK/JMvn9X1vtskn610bmBFk2HVZRwQDSeZ7t5AB41dAFx8FA0X
        tedr5tgGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOL6s-0006dR-3J; Wed, 08 May 2019 11:51:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C25752029F884; Wed,  8 May 2019 13:51:40 +0200 (CEST)
Date:   Wed, 8 May 2019 13:51:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH 3/6] perf/x86/intel/uncore: Extract codes of box
 ref/unref
Message-ID: <20190508115140.GK2606@hirez.programming.kicks-ass.net>
References: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
 <1556672028-119221-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556672028-119221-4-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:53:45PM -0700, kan.liang@linux.intel.com wrote:
> +static void uncore_box_unref(struct intel_uncore_type **types, int id)
>  {
> +	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
>  	struct intel_uncore_box *box;
> +	int i;
> +
> +	for (; *types; types++) {
> +		type = *types;
> +		pmu = type->pmus;
> +		for (i = 0; i < type->num_boxes; i++, pmu++) {
> +			box = pmu->boxes[id];
> +			if (box && atomic_dec_return(&box->refcnt) == 0)
> +				uncore_box_exit(box);
> +		}
> +	}
> +}

> +static int uncore_box_ref(struct intel_uncore_type **types,
> +			  int id, unsigned int cpu)
>  {
> +	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
>  	struct intel_uncore_box *box;
> +	int i, ret;
>  
> +	ret = allocate_boxes(types, id, cpu);
>  	if (ret)
>  		return ret;
>  
> @@ -1232,11 +1238,22 @@ static int uncore_event_cpu_online(unsigned int cpu)
>  		type = *types;
>  		pmu = type->pmus;
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
> +			box = pmu->boxes[id];
>  			if (box && atomic_inc_return(&box->refcnt) == 1)
>  				uncore_box_init(box);
>  		}
>  	}
> +	return 0;
> +}

This relies on all online/offline events to be globally serialized, and
they are. But that does make me wonder why we're using atomic_t.

Without the serialization there is an online-online race where the first
online sets the refcount to 1, lets the second online continue without
the first having completed the init().

Anyway, the code isn't wrong, just weird.
