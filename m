Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC17CC71C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 03:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfJEBQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 21:16:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEBQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 21:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=76PvWG28Wf5VWGGq/eiwJm/zoctdt2tMBJW16pZ6SJc=; b=TV6E3RyA/PqAV8ahjRwF6ETx9
        6sk0zSIkxCy4Z3dxHFslxT3InYPSUf4cGpcRTAkajsnvOdUtLrnjgXsS5/xH92dtbMcHN5fBrz88F
        sAm+/YpYsbOpMy86xSe4sL9SoRQudK0ENoQg4lI7rCwR0Fj3p8fhV3ZFlQUOeoHDsGPg2aYe1+Ho/
        vAgMN4GJ36AMyFNm1My9bqkO0nPblSBrZYaSpkOpneegQHnyUnFGuI76xnWDnTQbpIR8MMyA+dRiA
        nkxIVB7hMYSxXaRVs5dYYmdETxn6O4/xF6Pa1lljqxFDTNPBa0N5DismyJ1nD8HFP2vPnWZKd/0sh
        ABmCfqSig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGYfq-0001PH-7v; Sat, 05 Oct 2019 01:15:54 +0000
Date:   Fri, 4 Oct 2019 18:15:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Message-ID: <20191005011554.GQ32665@bombadil.infradead.org>
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
 <20191004161120.GI32665@bombadil.infradead.org>
 <20191004234845.GB15415@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004234845.GB15415@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 07:48:45AM +0800, Wei Yang wrote:
> On Fri, Oct 04, 2019 at 09:11:20AM -0700, Matthew Wilcox wrote:
> >On Sat, Oct 05, 2019 at 12:06:32AM +0800, Wei Yang wrote:
> >> After this change, kernel build test reduces 20% anon_vma allocation.
> >
> >But does it have any effect on elapsed time or peak memory consumption?
> 
> Do the same kernel build test and record time:
> 
> 
> Origin
> 
> real	2m50.467s
> user	17m52.002s
> sys	1m51.953s    
> 
> real	2m48.662s
> user	17m55.464s
> sys	1m50.553s    
> 
> real	2m51.143s
> user	17m59.687s
> sys	1m53.600s    
> 
> 
> Patched
> 
> real	2m43.733s
> user	17m25.705s
> sys	1m41.791s    
> 
> real	2m47.146s
> user	17m47.451s
> sys	1m43.474s    
> 
> real	2m45.763s
> user	17m38.230s
> sys	1m42.102s    
> 
> 
> For time in sys, it reduced 8.5%.

That's compelling!
