Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7496EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 03:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfHUBk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 21:40:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUBk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WGj/9OAL1jzlLnTNddhgvmKMwcKY29JLAWbd90pUdaE=; b=Moh6rSQuKryOBTXVhVZEEklK8
        r8JDo2Hi4NGHWAtUPHl86P1L/h7kQSZ2jd9AY2ZKsela9GsUPfBq/hX+wBdzngrRpyma63AsdDyy9
        ltTkDyDma0wwUSkfYkNVfUCcgsLIULHC/4PllpSyWf8xb49645S96hPTrGZ1+VpXE2+sdCFSK7Dek
        d9ZyTgpICbCIJsTmrGMN5bop9r1456ygRYKWzbBUNeXbDAobLUVf+yqjM46fvtTCCBL4M7B/DlBtT
        8Vk1ynoyIbtNiZztHPIp1tk/Ntxs87hlHeYfg4uEDNLI2ZaQ58nI9pWz4pkmXOyzP6ka+3SxlI1fw
        VoliHrBDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0FcK-0008O7-Ph; Wed, 21 Aug 2019 01:40:52 +0000
Date:   Tue, 20 Aug 2019 18:40:52 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190821014052.GA25550@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <mvmh86cl1o3.fsf@linux-m68k.org>
 <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
 <20190820092207.GA26271@infradead.org>
 <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
 <20190821012921.GA30187@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821012921.GA30187@andestech.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:29:22AM +0800, Alan Kao wrote:
> IMHO, this approach should be avoided because CLINT is compatible to but
>  not mandatory in the privileged spec.  In other words, it is possible that
> a Linux-capable RISC-V platform does not contain a CLINT component but
> rely on some other mechanism to deal with SW/timer interrupts.

Hi Alan,

at this point the above is just a prototype showing the performance
improvement if we can inject IPIs and timer interrups directly from
S-mode and delivered directly to S-mode.  It is based on a copy of
the clint IPI block currently used by SiFive, qemu, Ariane and Kendryte.

If the experiment works out (which I think it does), I'd like to
define interfaces for the unix platform spec to make something like
this available.  My current plan for that is to have one DT node
each for the IPI registers, timer cmp and time val register each
as MMIO regions.  This would fit the current clint block but also
allow other register layouts.  Is that something you'd be fine with?
If not do you have another proposal?  (note that eventually the
dicussion should move to the unix platform spec list, but now that
I have you here we can at least brain storm a bit).
