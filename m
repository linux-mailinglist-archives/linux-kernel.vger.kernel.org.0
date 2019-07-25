Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23C374CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391794AbfGYLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 07:21:52 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37528 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389393AbfGYLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:21:52 -0400
X-IronPort-AV: E=Sophos;i="5.64,306,1559512800"; 
   d="scan'208";a="393273205"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 13:21:32 +0200
Date:   Thu, 25 Jul 2019 06:21:29 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Matthias Maennich <maennich@google.com>
cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-spdx@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Subject: Re: [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX License
 Identifier
In-Reply-To: <20190725101705.179924-1-maennich@google.com>
Message-ID: <alpine.DEB.2.21.1907250621120.2535@hadrien>
References: <20190725101705.179924-1-maennich@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2019, Matthias Maennich wrote:

> Add the missing GPLv2 SPDX license identifier.
>
> It appears this single file was missing from 7f904d7e1f3e ("treewide:
> Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
> addressed all other files in scripts/coccinelle. Hence I added
> GPL-2.0-only consitently with the mentioned patch.
>
> Cc: linux-spdx@vger.kernel.org
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks!


> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> index 988120e0fd67..0f78d94abc35 100644
> --- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  // Check if refcount_t type and API should be used
>  // instead of atomic_t type when dealing with refcounters
>  //
> --
> 2.22.0.657.g960e92d24f-goog
>
>
