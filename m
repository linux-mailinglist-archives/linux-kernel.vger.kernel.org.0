Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62CE941F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 01:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfJ3Agc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 20:36:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfJ3Agb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:36:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 472qJX3hTfz9sPc;
        Wed, 30 Oct 2019 11:36:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572395789;
        bh=cULIR7FKewGoqcCdVz8c9GWUqTWBzH9vqip6TO04VUc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZrnBz8u9UtK35OIBdIYRAEKio8qsnCeoIwPBgPl54K4vLbIV96JpIRijFpj2d6VB/
         3yh38Zr83pyrrBKy1ob5pSFhYxjuOlDR0wxkT8j7sl+eURIwkfQTLhKOPMbjRLCHNq
         MPU6tRZ65hAlAqqvCFI2RrdLVQrG78Wr2+aweqLgfwKHT2b4iNG1L0VLagLCRgHq71
         9Qowav3rgtSLYQrVlsSwHP5FNWVuKn5384n4lcPyxoq23HnVPJULVs58QCVxd2xxKS
         D2BpI2IuAS9K0kM2/GMwh2a5yxiVaLELSZ6BKELGQ4NYJ1J1dErqYrlReUBS6dnZ/y
         akJSpbqkFajEA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH 4/7] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
In-Reply-To: <a11aaeaa-7075-4ad0-aa26-d8d7eafa72f5@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk> <20191018125234.21825-5-linux@rasmusvillemoes.dk> <20191018160852.GA13036@infradead.org> <a11aaeaa-7075-4ad0-aa26-d8d7eafa72f5@rasmusvillemoes.dk>
Date:   Wed, 30 Oct 2019 11:36:27 +1100
Message-ID: <87wocnf4s4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:
> On 18/10/2019 18.08, Christoph Hellwig wrote:
>> On Fri, Oct 18, 2019 at 02:52:31PM +0200, Rasmus Villemoes wrote:
>>>  	/* wait for the QE_CR_FLG to clear */
>>> -	ret = spin_event_timeout((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
>>> -				 100, 0);
>>> -	/* On timeout (e.g. failure), the expression will be false (ret == 0),
>>> -	   otherwise it will be true (ret == 1). */
>>> +	ret = readx_poll_timeout_atomic(ioread32be, &qe_immr->cp.cecr, val, (val & QE_CR_FLG) == 0,
>> 
>> This creates an overly long line.
>
> Yeah, readx_poll_timeout_atomic is a mouthful, and then one also has to
> put in the name of the accessor... I'll wrap it when I respin the
> series, thanks.
>
>> Btw, given how few users of spin_event_timeout we have it might be good
>> idea to just kill it entirely.
>
> Maybe. That's for the ppc folks to comment on; the iopoll.h helpers are
> not completely equivalent (because obviously they don't read tbl
> directly).

AFAICS it was added by and only ever used by Freescale folks, most of
whom have now moved on to other things.

I'd be happy to see it replaced with something generic.

I created an issue in our github to remind us to do that cleanup. Though
in practice that probably just means we'll never get around to it:

  https://github.com/linuxppc/issues/issues/280

> Maybe the generic versions should be taught
> spin_begin/spin_end/spin_cpu_relax so at least that part would be
> drop-in replacement.

That would be nice. Though TBH the intersection of platforms that use
spin_event_timeout() and also define a non-empty spin_begin() etc. is
close to if not zero.

cheers
