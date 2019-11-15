Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9844FD3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 05:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKOEvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 23:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKOEvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:51:00 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18905206E6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573793459;
        bh=Zf6sTIMli76oYQWsxTvqKPeMc72IZB/Z2B0hBOL0C+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U6HSO2YxLNSLY6xFeYZ9L9kZOnK1zLpDkmnckCZ40n7Wa2tNA8RrHy8A/3JbXDRMO
         0c59Tcos/mF4g2JiaTaJAqm7VWCRDVjlegnSnsoXJdJUDHp9MEEUWO4o2/BDcp1Zog
         VLk+oFYf+bN8ZPmHI3WhZycAGPyJWHg/ObSj/sa8=
Received: by mail-qk1-f180.google.com with SMTP id m4so7114815qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 20:50:59 -0800 (PST)
X-Gm-Message-State: APjAAAWJQqc4V7noWubu2i1oYtoG1bqRkvIZw1YwNNPEwCMyOvxukvu4
        BoxTYMgYRyRSmwDKHNAkgxf9v1vIiRqwvNLes5k=
X-Google-Smtp-Source: APXvYqzfQ+D+sIW1zancKDC1U3nM1foEwdOLpsyTt+w7ZHUDx3VbOqfLeYpK5/1wDeVyzBxq3G2x5b7W0mA8w1wSKUE=
X-Received: by 2002:a37:9d44:: with SMTP id g65mr10669230qke.302.1573793458206;
 Thu, 14 Nov 2019 20:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-8-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-8-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 14 Nov 2019 22:50:21 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXHK9U_Y7_VgVmuOFKDAh4OqBJ7hZx58hisZZ6Cz6xE2w@mail.gmail.com>
Message-ID: <CAOZdJXXHK9U_Y7_VgVmuOFKDAh4OqBJ7hZx58hisZZ6Cz6xE2w@mail.gmail.com>
Subject: Re: [PATCH v4 07/47] soc: fsl: qe: qe.c: guard use of
 pvr_version_is() with CONFIG_PPC32
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> +static bool qe_general4_errata(void)
> +{
> +#ifdef CONFIG_PPC32
> +       return pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x);
> +#endif
> +       return false;
> +}
> +
>  /* Program the BRG to the given sampling rate and multiplier
>   *
>   * @brg: the BRG, QE_BRG1 - QE_BRG16
> @@ -223,7 +231,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
>         /* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
>            that the BRG divisor must be even if you're not using divide-by-16
>            mode. */

Can you also move this comment (and fix the comment formatting so that
it's a proper function comment) to qe_general4_errata()?
