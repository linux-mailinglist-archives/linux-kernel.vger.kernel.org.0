Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529BE2F777
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfE3GdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 02:33:05 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:33611 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727196AbfE3GdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:33:04 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x4U6QvwC058344;
        Thu, 30 May 2019 14:26:57 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 30 May 2019
 14:32:31 +0800
Date:   Thu, 30 May 2019 14:32:32 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>
Subject: Re: [PATCH] riscv: Fix udelay in RV32.
Message-ID: <20190530063232.GA17102@andestech.com>
References: <381ee6950c84b868ca6a3c676eb981a1980889a3.1559035050.git.nickhu@andestech.com>
 <20190530055258.GA7170@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190530055258.GA7170@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x4U6QvwC058344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:52:58PM +0800, Christoph Hellwig wrote:
> On Tue, May 28, 2019 at 05:26:49PM +0800, Nick Hu wrote:
> > In RV32, udelay would delay the wrong cycle.
> > When it shifts right "UDELAY_SHITFT" bits, it
> > either delays 0 cycle or 1 cycle. It only works
> > correctly in RV64. Because the 'ucycles' always
> > needs to be 64 bits variable.
> 
> Please use up all your ~72 chars per line in the commit log.
>

OK, Thanks! 

> > diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> > index dce8ae24c6d3..da847f49fb74 100644
> > --- a/arch/riscv/lib/delay.c
> > +++ b/arch/riscv/lib/delay.c
> > @@ -88,7 +88,7 @@ EXPORT_SYMBOL(__delay);
> >  
> >  void udelay(unsigned long usecs)
> >  {
> > -	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
> > +	unsigned long long ucycles = (unsigned long long)usecs * lpj_fine * UDELAY_MULT;
> 
> And this creates a way too long line.  Pleaase use u64 instead of
> unsigned long long to clarify the intention while also fixing the long
> lines.
>

Sure, I will fix it and send another patch. Thanks.

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
