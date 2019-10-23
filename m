Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90D3E14CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfJWIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:55:43 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:12734
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387829AbfJWIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:55:43 -0400
X-IronPort-AV: E=Sophos;i="5.68,220,1569276000"; 
   d="scan'208";a="323927878"
Received: from unknown (HELO hadrien) ([154.43.32.124])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 10:55:40 +0200
Date:   Wed, 23 Oct 2019 10:55:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     zhongshiqi <zhong.shiqi@zte.com.cn>
cc:     Julia.Lawall@lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, yamada.masahiro@socionext.com
Subject: Re: [PATCH] Configuring COCCI parameter as a directory is
 supportted
In-Reply-To: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1910231054250.2335@hadrien>
References: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Oct 2019, zhongshiqi wrote:

> This patch puts a modification in scripts/coccicheck which supports users
> in configuring COCCI parameter as a directory to traverse files in
> directory.
>
> Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
> ---
>  scripts/coccicheck | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328..a1c4197 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
>      for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
>  	coccinelle $f
>      done
> +elif [ -d "$COCCI" ] ; then
> +    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
> +	coccinelle $f
> +    done
>  else
>      coccinelle $COCCI
>  fi

Thanks for the contribution.  I'm not that knowledgeable about these
scripts.  What is the relation between the last two if branches?  If the
first one fails, does that mean that $COCCI has no definition?  In that
case, is the final else useful?

thanks,
julia
