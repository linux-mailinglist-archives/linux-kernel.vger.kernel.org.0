Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8D8BABA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfHMNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 09:49:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfHMNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:49:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFFC344;
        Tue, 13 Aug 2019 06:49:10 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB36B3F694;
        Tue, 13 Aug 2019 06:49:09 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:49:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mm: kmemleak: Use the memory pool for early
 allocations
Message-ID: <20190813134907.GJ62772@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-4-catalin.marinas@arm.com>
 <1565699754.8572.8.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565699754.8572.8.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:35:54AM -0400, Qian Cai wrote:
> On Mon, 2019-08-12 at 17:06 +0100, Catalin Marinas wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 4d39540011e2..39df06ffd9f4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -592,17 +592,18 @@ config DEBUG_KMEMLEAK
> >  	  In order to access the kmemleak file, debugfs needs to be
> >  	  mounted (usually at /sys/kernel/debug).
> >  
> > -config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> > -	int "Maximum kmemleak early log entries"
> > +config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> > +	int "Kmemleak memory pool size"
> >  	depends on DEBUG_KMEMLEAK
> >  	range 200 40000
> >  	default 16000
> 
> Hmm, this seems way too small. My previous round of testing with
> kmemleak.mempool=524288 works quite well on all architectures.

We can change the upper bound here to 1M but I'd keep the default sane.
Not everyone is running tests under OOM.

-- 
Catalin
