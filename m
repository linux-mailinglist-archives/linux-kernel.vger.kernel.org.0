Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29797BABAE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 22:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbfIVU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 16:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388240AbfIVU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:28:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C56620644;
        Sun, 22 Sep 2019 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569184132;
        bh=aNmux5WskQasXL3W5fSP8ZeWxPMhq3DVtOInr703h6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grEjxYiaui+8pzlJzi4Uxw9wBu+cJ7hfHMnmlrjZ/rOTd9eIlDw4z7lkn1YCyANJF
         gbm4oy3c9/bRzjwckCvg8YQka0iTqlVECGOUBs2h1SdQlJWQiGvcYoR7hlAmIJNbH9
         jvPihnmlinAqdtJmr6Yvk7HAHDVahns74+xtV11U=
Date:   Sun, 22 Sep 2019 21:28:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb
Message-ID: <20190922202846.n2gtdkio6ygu6mhn@willie-the-truck>
References: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:44:47AM -0700, Douglas Anderson wrote:
> I'm interested in kdb / kgdb and have sent various fixes over the
> years.  I'd like to get CCed on patches so I can be aware of them and
> also help review.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c740cf3f93ef..d243c70fc8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9052,6 +9052,7 @@ F:	security/keys/
>  KGDB / KDB /debug_core
>  M:	Jason Wessel <jason.wessel@windriver.com>
>  M:	Daniel Thompson <daniel.thompson@linaro.org>
> +R:	Douglas Anderson <dianders@chromium.org>
>  W:	http://kgdb.wiki.kernel.org/
>  L:	kgdb-bugreport@lists.sourceforge.net
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git

Acked-by: Will Deacon <will@kernel.org>

I really wanted to rip kgdb out of arm64 a while ago and you stopped me, so
you deserve to have your name in lights ;)

Thanks.

Will
