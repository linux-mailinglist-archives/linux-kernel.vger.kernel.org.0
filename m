Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE65AFFE78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 07:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKRGVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 01:21:19 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:53851 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbfKRGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:21:19 -0500
X-IronPort-AV: E=Sophos;i="5.68,319,1569276000"; 
   d="scan'208";a="412230068"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 07:21:17 +0100
Date:   Mon, 18 Nov 2019 07:21:17 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Travis Davies <tdavies@darkphysics.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: Fix comment block per style guide
In-Reply-To: <20191117221647.GA10337@Cheese>
Message-ID: <alpine.DEB.2.21.1911180720340.2620@hadrien>
References: <20191117221647.GA10337@Cheese>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be v2.  Put that with the PATCH, and then explain below the
--- what changed.

On Sun, 17 Nov 2019, Travis Davies wrote:

> This patch places /* and */ on sepperate lines for a

You can fix the spelling of separate at the same time.

julia

> multiline block comment, in order to keep code style
> consistant with majority of blocks throughout the file.
>
> This will prevent a checkpatch.pl warning:
> 'Block comments use a trailing */ on a separate line'
>
> Signed-off-by: Travis Davies <tdavies@darkphysics.net>
>
> ---
>  include/linux/netdevice.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c20f190b4c18..a2605e043fa2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -95,9 +95,11 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
>  #define NET_XMIT_CN		0x02	/* congestion notification	*/
>  #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
>
> -/* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
> +/*
> + * NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
>   * indicates that the device will soon be dropping packets, or already drops
> - * some packets of the same priority; prompting us to send less aggressively. */
> + * some packets of the same priority; prompting us to send less aggressively.
> + */
>  #define net_xmit_eval(e)	((e) == NET_XMIT_CN ? 0 : (e))
>  #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
>
> --
> 2.21.0
>
>
