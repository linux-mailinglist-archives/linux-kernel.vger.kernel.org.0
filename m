Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A731D02B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 15:50:55 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62392
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfENTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:50:55 -0400
X-IronPort-AV: E=Sophos;i="5.60,469,1549926000"; 
   d="scan'208";a="306019357"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 21:50:52 +0200
Date:   Tue, 14 May 2019 21:50:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 3/3] Coccinelle: pci_free_consistent: Extend when
 constraints for two SmPL ellipses
In-Reply-To: <c4e9153c-234e-ab5a-0061-221374c2505b@web.de>
Message-ID: <alpine.DEB.2.21.1905142150360.2612@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <c4e9153c-234e-ab5a-0061-221374c2505b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 May 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 14 May 2019 18:12:15 +0200
>
> A SmPL ellipsis was specified for a search approach so that additional
> source code would be tolerated between an assignment to a local variable
> and the corresponding null pointer check.
>
> But such code should be restricted.
> * The local variable must not be reassigned there.
> * It must also not be forwarded to an other assignment target.
>
> Take additional casts for these code exclusion specifications into account
> together with optional parentheses.

I leave this up to the ZTE people.

julia


>
> Fixes: f7b167113753e95ae61383e234f8d10142782ace ("scripts: Coccinelle script for pci_free_consistent()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/free/pci_free_consistent.cocci | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
> index 45bc14ece151..48a36adfa3ce 100644
> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> +++ b/scripts/coccinelle/free/pci_free_consistent.cocci
> @@ -13,13 +13,15 @@ virtual org
>  local idexpression id;
>  expression x,y,z,e;
>  position p1,p2;
> -type T;
> +type T,T2,T3,T4;
>  @@
>
>  id = pci_alloc_consistent@p1(x,y,&z)
> -... when != e = id
> + ... when != id = (T2)(e)
> +     when != e = (T3)(id)
>  if (id == NULL || ...) { ... return ...; }
>  ... when != pci_free_consistent(x,y,id,z)
> +    when != id = (T4)(e)
>      when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
>      when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
>      when != e = (T)id
> --
> 2.21.0
>
>
