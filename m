Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3328BB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfHMOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:30:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfHMOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KSaal6YlN7wPFno+cbdIpqACxfsSyDYqcjwHpJgXWLQ=; b=qLqSPm9h565BOHuhfNAhNZ3T6
        8IbwVyae2EnRhi7GEy8egxUKyDgVc8w1jOX6WqZ46CNH+Vjl8iRVm4hMON6gAnvCVgfezsmNE0ZHG
        p6LgsnWqlZQf+i533xf6fVWyifJmAYGsODHrN7FSgn3KpDzdu4BhWAd9F/Kvrte/59YiBOHq5FGIC
        hdfn1tuPP1fTro5E5XzXIw+XdrD2vxJjhmchCHDYn2lmKJm4ORX0FRGeToXq7AvX/qd+zc4kLZamB
        IAZ+EVO0J7iPW3BfCneMF+jPaUbB/buUStYWhqbdFjsBfb/jSMQsk+WAY9v1Mz8u6rDW9dbn9rETU
        zFXHShNJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxXoh-0003B5-FW; Tue, 13 Aug 2019 14:30:27 +0000
Date:   Tue, 13 Aug 2019 07:30:27 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Message-ID: <20190813143027.GA31668@infradead.org>
References: <20190810014309.20838-1-atish.patra@wdc.com>
 <20190812145631.GC26897@infradead.org>
 <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:15:15AM +0000, Atish Patra wrote:
> I thought if it recieves an empty cpumask, then it should at least do a
> local flush is the expected behavior. Are you saying that we should
> just skip all and return ? 

How could we ever receive an empty cpu mask?  I think it could only
be empty without the current cpu.  At least that is my reading of
the callers and a few other implementations.

> > 	if (!cpumask || cpumask_test_cpu(cpu, cpumask) {
> > 		if ((start == 0 && size == -1) || size > PAGE_SIZE)
> > 			local_flush_tlb_all();
> > 		else if (size == PAGE_SIZE)
> > 			local_flush_tlb_page(start);
> > 		cpumask_clear_cpu(cpuid, cpumask);
> 
> This will modify the original cpumask which is not correct. clear part
> has to be done on hmask to avoid a copy.

Indeed.  But looking at the x86 tlbflush implementation it seems like we
could use cpumask_any_but() to avoid having to modify the passed in
cpumask.
