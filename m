Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D21C164C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfI2Qk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 12:40:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39521 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfI2Qk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 12:40:58 -0400
X-IronPort-AV: E=Sophos;i="5.64,563,1559512800"; 
   d="scan'208";a="403855449"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 18:40:56 +0200
Date:   Sun, 29 Sep 2019 18:40:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
In-Reply-To: <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
Message-ID: <alpine.DEB.2.21.1909291840280.3346@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com> <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-78162315-1569775256=:3346"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-78162315-1569775256=:3346
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> I suggest to think a bit more about the desired directory hierarchy.
> If you would like to keep these files generally within a (sub)folder
> of “scripts/coccinelle”, other solutions should be taken into account.
> How do you think about to adjust the filter command?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck?id=02dc96ef6c25f990452c114c59d75c368a1f4c8f#n257

Changing this could also be a solution.

julia
--8323329-78162315-1569775256=:3346--
