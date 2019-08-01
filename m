Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A517D992
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfHAKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:43:34 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:55787 "EHLO
        10.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfHAKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:43:34 -0400
X-Greylist: delayed 3708 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 06:43:33 EDT
Received: from player778.ha.ovh.net (unknown [10.108.57.38])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7388F70E71
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 11:24:00 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 17FDD87377A1;
        Thu,  1 Aug 2019 09:23:49 +0000 (UTC)
Date:   Thu, 1 Aug 2019 11:23:48 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/xive: Use GFP_KERNEL instead of GFP_ATOMIC
 in 'xive_irq_bitmap_add()'
Message-ID: <20190801112348.2d1760f3@bahia.lan>
In-Reply-To: <85d5d247ce753befd6aa63c473f7823de6520ccd.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
        <85d5d247ce753befd6aa63c473f7823de6520ccd.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12659618553387784475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Aug 2019 10:32:31 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> There is no need to use GFP_ATOMIC here. GFP_KERNEL should be enough.
> GFP_KERNEL is also already used for another allocation just a few lines
> below.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Good catch.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  arch/powerpc/sysdev/xive/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 8ef9cf4ebb1c..b4f5eb9e0f82 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -45,7 +45,7 @@ static int xive_irq_bitmap_add(int base, int count)
>  {
>  	struct xive_irq_bitmap *xibm;
>  
> -	xibm = kzalloc(sizeof(*xibm), GFP_ATOMIC);
> +	xibm = kzalloc(sizeof(*xibm), GFP_KERNEL);
>  	if (!xibm)
>  		return -ENOMEM;
>  

