Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE21E828
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEOGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:11:22 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49741 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfEOGLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:11:22 -0400
X-IronPort-AV: E=Sophos;i="5.60,471,1549926000"; 
   d="scan'208";a="383210706"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:11:20 +0200
Date:   Wed, 15 May 2019 08:11:19 +0200 (CEST)
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
Subject: Re: [2/3] Coccinelle: pci_free_consistent: Reduce a bit of duplicate
 SmPL code
In-Reply-To: <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
Message-ID: <alpine.DEB.2.21.1905150811010.2591@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de> <alpine.DEB.2.21.1905142146560.2612@hadrien> <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-192762635-1557900680=:2591"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-192762635-1557900680=:2591
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 15 May 2019, Markus Elfring wrote:

> >> A return statement was specified with a known value for three branches
> >> of a SmPL disjunction.
> >> Reduce duplicate SmPL code there by using another disjunction for
> >> these return values.
> …
> > NACK.  The goak is not to squeeze the most information into the fewest
> > number of characters.
>
> Can you accept any other formatting for the adjusted SmPL code?

No.  It's fine as is.

>
>
> > The rule was fine as it was.
>
> Can different run time characteristics become relevant here?

No.

julia
--8323329-192762635-1557900680=:2591--
