Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAA163A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEGMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 08:22:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEGMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZbBnjNWEqPXVSqogc9+rle2mPAgOUH2/1vtZwGC84eg=; b=Hru38h+JFsaQZcpOvdqPpNF4+
        yOgUENqJVSKwB5oaYS7FOzaTtmDB/62OXts0A/fYw6in1dkrgl8aL669wNG7EHrgf2X9otSlDmf4M
        iOwj2qMrU/hZ23fCImg07AdEP+mScIALdoz1EvQGpswc9+R5oLIB3fKjNYkaSkE9mBSpz6y/3KhqF
        ptMePaNLAT16ro2AZpmT3rwvQtlznOwW3qAnuZ6ov0R7jLPJKmbqQ5g1Rp6IrHmOTZeJrgtgjgW62
        Q2T42a2yIAb4BjwADPduP3EfG4sSaZ7Ud+6+snlzv+MtXcBqAIMdQZvk0D0N/G+UHBd21JA1Th7Dw
        Z6GFMj7Ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNz6y-00070X-IP; Tue, 07 May 2019 12:22:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E5562023ADB5; Tue,  7 May 2019 14:22:19 +0200 (CEST)
Date:   Tue, 7 May 2019 14:22:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 16/22] perf/x86/intel/uncore: Support multi-die/package
Message-ID: <20190507122219.GN2623@hirez.programming.kicks-ass.net>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 05:26:11PM -0400, Len Brown wrote:
> @@ -1223,7 +1225,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
>  	struct intel_uncore_box *box;
>  	int i, ret, pkg, target;
>  
> -	pkg = topology_logical_package_id(cpu);
> +	pkg = topology_logical_die_id(cpu);
>  	ret = allocate_boxes(types, pkg, cpu);
>  	if (ret)
>  		return ret;

'pkg' != 'die'

