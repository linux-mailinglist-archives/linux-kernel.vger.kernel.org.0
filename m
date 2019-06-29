Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992C65A97F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF2HtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 03:49:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42778
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfF2HtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:49:06 -0400
X-IronPort-AV: E=Sophos;i="5.63,430,1557180000"; 
   d="scan'208";a="311853501"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 09:49:04 +0200
Date:   Sat, 29 Jun 2019 09:49:04 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
In-Reply-To: <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
Message-ID: <alpine.DEB.2.21.1906290947470.2579@hadrien>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn> <904b9362-cd01-ffc9-600b-0c48848617a0@web.de> <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-766857525-1561794544=:2579"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-766857525-1561794544=:2579
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 29 Jun 2019, Markus Elfring wrote:

> >> +if (x == NULL || ...) S
> >> +... when != e = (T)x
> >> +    when != true x == NULL
> >
> > I wonder if this code exclusion specification is really required
> > after a null pointer was checked before.
>
> I would like to add another view for this implementation detail.
>
> The when constraint can express a software desire which can be reasonable
> to some degree. You would like to be sure that a null pointer will not occur
> after a corresponding check succeeded.

He wants to be sure that the true branch through a NULL pointer check is
not taken.

> * But I feel unsure about the circumstances under which the Coccinelle software
>   can determine this aspect actually.
>
> * I find that it can eventually make sense only after the content of
>   the local variable (which is identified by “x”) was modified.
>   Thus I would find the exclusion of assignments more useful at this place.

I assume that it was added because it was found to be useful.  Please
actually try things out before declaring them to be useless.

julia
--8323329-766857525-1561794544=:2579--
