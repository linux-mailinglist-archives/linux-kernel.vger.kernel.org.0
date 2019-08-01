Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0E7DE47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfHAOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:53:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42778 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:53:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so24026695wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQwjCZHn0hCfiGPjPuKEwhUSkgHi6FqRy5NYtVOPZRM=;
        b=pqSYmUoWn7Y9stRF6ZpR06REAdu4QQiiYgSVTaYT96C/7YWj+FlPvttmcGZbl8QL3L
         DjwL87YY/0mvbttZweuZQQdd6vZqjun4lfuJvQy566ZthS79p+QgVdx6GJLGaT8WfhSJ
         z/D80HhzN0TTEtZiAXEhDP/Jciq52ZsUX8HJS5scxJ4PiNKnY+bHDh2SFwdp3rUV/9Yp
         DfDaxuNpKXuDh2/3o36oJPEdVtyrwAXNmuh9kEw7KusrIWugmk/cBaHfwaKl5/Ai3pnt
         r6b2fDN/D9K7gxk2tYh0b0lUkiKKuCSjNniTYJytMTa6OrkmIdAjk8MnCSgvyV5VwHON
         7gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQwjCZHn0hCfiGPjPuKEwhUSkgHi6FqRy5NYtVOPZRM=;
        b=cl0a9UEkqAn6mYKgnChO0g2PfcmvnhT/eVfSZMXcUGmzYEQnKF+F/L5qXdtLHUihXG
         IMjQoCysoff9iFwYHAFowGV3cSkd9gjLgB9f2amghdxZJop3ogac0ayUmFTg6L7reDhH
         PlI4Cd2tCSKarsfBnWGCF6Ir0frMh+RhanWs3q2dKPaexDhnDW4c3Lsnur+KiziTsP+a
         q+dOXWYfhGYvpM4xrwdfALWniPbCYFfyDfegFcfmovrM2L+m6gZwnNPX9J0LvsUhigca
         BhqFv30cewP5jrYG7uMwCEBI07ZMpAgavXkT/VqrPfKyikBgpRBcOBlGtEdVg4L1CdX1
         BdIg==
X-Gm-Message-State: APjAAAXdY4BRU2+wv01btuaCHEdZXDTxm5hl7U7sFz9nl2kdaLyUGWpT
        +PZB3jiROeAj6pONOgd7xAJfYtVL3NL1hS6oJGM=
X-Google-Smtp-Source: APXvYqzpaG1YbScy9oUumOFNtfVu0QAC2W3EyQb8DVsoVEborz1WwCAMqWFBurRipPcj7KfZXMJ8FuA/5zGH6L5tlBA=
X-Received: by 2002:adf:f450:: with SMTP id f16mr108790740wrp.335.1564671234760;
 Thu, 01 Aug 2019 07:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190731205539.13997-1-daniel.baluta@nxp.com> <20190801061033.4diqrc4x4mighyju@pengutronix.de>
In-Reply-To: <20190801061033.4diqrc4x4mighyju@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 1 Aug 2019 17:53:43 +0300
Message-ID: <CAEnQRZCG4J-e_sx29qaPXUiBHcYirEZV=99dijctg9hr5pPH0w@mail.gmail.com>
Subject: Re: [PATCH] mailbox: imx: Fix Tx doorbell shutdown path
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, jassisinghbrar@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

Thanks for review

<snip>

>
> your patch is in conflicht with Richard's Zhu <hongxing.zhu@nxp.com>
> patch "[PATCH v3] mailbox: imx: add support for imx v1 mu".
> Please sync your works.

Sent an email to Richard. Hopefully he can rebase his change on my patches.

<snip>

>
> Looks like here is one more bug "from the beginning of times" :)
> The imx_mu_xcr_rmw() should disable only one channel depending on the
> type of channel.
>
> It should be:
>         switch (cp->type) {
>         case IMX_MU_TYPE_TX:
>                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>                 break;
>         case IMX_MU_TYPE_RX:
>                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(cp->idx));
>                 break;
>         case IMX_MU_TYPE_RXDB:
>                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_GIEn(cp->idx));
>                 break;
>         default:
>                 break;

Honestly, this is not really a bug. The registers are expected to
already be cleared.
Also, please mind that we shouldn't clear TIE here because it should be cleared
in the mu_isr.

Anyhow, I have sent the patches with your exact suggestion to Richard.

>         }
>
> Right now I'm on vocation and have nothing against, if you'll provide
> this fix.

Have a nice vacation and thanks for the review.
