Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B2102E49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSVgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 16:36:54 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60288
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbfKSVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:36:54 -0500
X-IronPort-AV: E=Sophos;i="5.69,219,1571695200"; 
   d="scan'208";a="327306099"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 22:36:52 +0100
Date:   Tue, 19 Nov 2019 22:36:51 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH 2/4] coccinelle: platform_get_irq: handle 2-statement
 branches
In-Reply-To: <d178b6b3-7ef1-4ad7-a747-d65249a9667a@web.de>
Message-ID: <alpine.DEB.2.21.1911192235010.2592@hadrien>
References: <1574184500-29870-3-git-send-email-Julia.Lawall@lip6.fr> <d178b6b3-7ef1-4ad7-a747-d65249a9667a@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-319011006-1574199412=:2592"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-319011006-1574199412=:2592
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 19 Nov 2019, Markus Elfring wrote:

> > From: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I wonder about this information.
> Would you like to use the tag “Suggested-by” instead?

Sorry, I seem to have done something quite wrong on this patch.  I will
fix it.

>
>
> …
> > +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> > @@ -31,6 +31,25 @@ if ( \( ret < 0 \| ret <= 0 \) )
> …
> > +ret =
> > +(
> > +platform_get_irq
> > +|
> > +platform_get_irq_byname
> > +)(E, ...);
> > +
> > +if ( \( ret < 0 \| ret <= 0 \) )
> > +-{
> > +-dev_err(...);
> > +S
> > +-}
>
> How do you think about to use the following SmPL code variant?

And the benefit is what?

julia

> + ret =
> +(platform_get_irq
> +|platform_get_irq_byname
> +)(E, ...);
> +
> + if ( \( ret < 0 \| ret <= 0 \) )
> +-{
> +-dev_err(...);
> + S
> +-}
>
> Regards,
> Markus
>
--8323329-319011006-1574199412=:2592--
