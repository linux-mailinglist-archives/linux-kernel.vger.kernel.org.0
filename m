Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C23C0AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfI0SSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:18:48 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:47160 "EHLO
        2.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfI0SSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:18:48 -0400
X-Greylist: delayed 12603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 14:18:47 EDT
Received: from player718.ha.ovh.net (unknown [10.109.160.11])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3E4B81423A2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 20:18:45 +0200 (CEST)
Received: from RCM-web9.webmail.mail.ovh.net (unknown [109.190.253.11])
        (Authenticated sender: steve@sk2.org)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id DAB08A401549;
        Fri, 27 Sep 2019 18:18:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Sep 2019 20:18:37 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk/ti/adpll: allocate room for terminating null
In-Reply-To: <20190927180559.18162-1-steve@sk2.org>
References: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
 <20190927180559.18162-1-steve@sk2.org>
Message-ID: <8e45c174b787a26eb60762b8ca2e4747@sk2.org>
X-Sender: steve@sk2.org
User-Agent: Roundcube Webmail/1.3.10
X-Originating-IP: 109.190.253.11
X-Webmail-UserID: steve@sk2.org
X-Ovh-Tracer-Id: 5946158883481472455
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/09/2019 20:05, Stephen Kitt a écrit :
> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> terminating null. This patch switches to ka_sprintf to avoid

Aargh, devm_kasprintf of course...

> overflowing.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/clk/ti/adpll.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index fdfb90058504..021cf9e2b4db 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -195,14 +195,8 @@ static const char *ti_adpll_clk_get_name(struct
> ti_adpll_data *d,
>  			return NULL;
>  	} else {
>  		const char *base_name = "adpll";
> -		char *buf;
> -
> -		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
> -				    strlen(postfix), GFP_KERNEL);
> -		if (!buf)
> -			return NULL;
> -		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
> -		name = buf;
> +		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.%s.%s",
> +				      d->pa, base_name, postfix);
>  	}
> 
>  	return name;
