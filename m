Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0351AFEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfIKO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 10:26:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfIKO0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:26:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46T42b1Yf2z9s4Y;
        Thu, 12 Sep 2019 00:26:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1568211976;
        bh=FwvxfqH3g3FLezSauT+DVJLwHdBUTERn647l2G3HzSQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NVoQxm/QaOV1g2QRT4A+EhYW7N/ZEu9pyvv0JHDCi0rB+UJCITUHhdkK6NefYH2jN
         S/a45IvVdkPS5nFIMT2qkN9yqkjXGPAtBimAvKCRvkwk22SGrLDDH0G5lLaZuUEEny
         15Q+LbcjTJ0a5Ik0FixryVLxyW9m4I4o0CAQMblfBrN56VHf+UG8hcudd0cPY3UBYo
         assaiGcomf5JwfbGUO51+4ubCPRBbpKVM4wvv0HSTr7UYcCrQPxWgsMbTn0P5XGNcB
         TAtsMfzxCy7peYEl95NpvKFN29ya5p2no5KG4tnFXPuEWsiUFfEYoxfteRgpjXyBk9
         f+RHmnxXHlOzA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kurz <groug@kaod.org>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xive: Fix bogus error code returned by OPAL
In-Reply-To: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
References: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
Date:   Thu, 12 Sep 2019 00:26:19 +1000
Message-ID: <87k1aezz78.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Couple of comments ...

Greg Kurz <groug@kaod.org> writes:
> There's a bug in skiboot that causes the OPAL_XIVE_ALLOCATE_IRQ call
> to return the 32-bit value 0xffffffff when OPAL has run out of IRQs.
> Unfortunatelty, OPAL return values are signed 64-bit entities and
> errors are supposed to be negative. If that happens, the linux code
> confusingly treats 0xffffffff as a valid IRQ number and panics at some
> point.
>
> A fix was recently merged in skiboot:
>
> e97391ae2bb5 ("xive: fix return value of opal_xive_allocate_irq()")
>
> but we need a workaround anyway to support older skiboots already
> on the field.
  ^
  in
 
>
> Internally convert 0xffffffff to OPAL_RESOURCE which is the usual error
> returned upon resource exhaustion.

This should go to stable, any idea what versions it should go back to?
Probably whenever the xive code was introduced?

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  arch/powerpc/sysdev/xive/native.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 37987c815913..c35583f84f9f 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -231,6 +231,15 @@ static bool xive_native_match(struct device_node *node)
>  	return of_device_is_compatible(node, "ibm,opal-xive-vc");
>  }
>  
> +static int64_t opal_xive_allocate_irq_fixup(uint32_t chip_id)
          ^                                    ^
          Can you use s64 here and u32 here ....

Instead of calling this opal_xive_allocate_irq_fixup() and relying on
all callers to call the fixup, can we rename the opal wrapper and leave
this function's name unchanged, eg:

-OPAL_CALL(opal_xive_allocate_irq,              OPAL_XIVE_ALLOCATE_IRQ);
+OPAL_CALL(opal_xive_allocate_irq_raw,          OPAL_XIVE_ALLOCATE_IRQ);


> +{
> +	s64 irq = opal_xive_allocate_irq(chip_id);
> +
> +#define XIVE_ALLOC_NO_SPACE	0xffffffff /* No possible space */
> +	return
> +		irq == XIVE_ALLOC_NO_SPACE ? OPAL_RESOURCE : irq;
> +}

I don't really like the #define and the weird indenting and so on, can
we instead do it like:

	/*
         * Old versions of skiboot can incorrectly return 0xffffffff to
         * indicate no space, fix it up here.
         */
	return irq == 0xffffffff ? OPAL_RESOURCE : irq;

cheers
