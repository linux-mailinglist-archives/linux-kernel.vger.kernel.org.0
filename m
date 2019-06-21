Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C585A4E356
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFUJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:21:15 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35903 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfFUJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:21:15 -0400
X-IronPort-AV: E=Sophos;i="5.63,399,1557180000"; 
   d="scan'208";a="388479067"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 11:21:13 +0200
Date:   Fri, 21 Jun 2019 11:21:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of redundant
 dev_err() calls
In-Reply-To: <13890878-9e5f-f297-7f7c-bcc1212d83b7@web.de>
Message-ID: <alpine.DEB.2.20.1906211119430.3740@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de> <alpine.DEB.2.21.1906202046550.3087@hadrien> <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de> <alpine.DEB.2.21.1906202110310.3087@hadrien> <13890878-9e5f-f297-7f7c-bcc1212d83b7@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Jun 2019, Markus Elfring wrote:

> > I think that something like
> >
> > if (IS_ERR(e))
> > {
> > <+...
> > *dev_err(...)
> > ...+>
> > }
> >
> > would be more appropriate.  Whether there is a return or not doesn't
> > really matter.
>
> Do you find the following SmPL change specification useful and acceptable?
>
>
> @deletion depends on patch@
> expression e;
> @@
>  e = devm_ioremap_resource(...);
>  if (IS_ERR(e))
> (
> -{
> -   dev_err(...);
>     return (...);

I still don't see the point of specifying return.  Why not just S, where S
is a statement metavariable?

julia

> -}
> |{

I realize that you confuse conciseness with readability, but it would
really look better to have the | on a line by itself.

julia

>  <+...
> -   dev_err(...);
>  ...+>
>  }
> )
>
>
> Would this approach need a version check for the Coccinelle software?

Why would that be necessary?
