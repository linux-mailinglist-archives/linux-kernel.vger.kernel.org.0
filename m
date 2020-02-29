Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A583E1749E2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgB2W4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 17:56:08 -0500
Received: from baldur.buserror.net ([165.227.176.147]:54214 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2W4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:56:08 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j8B1i-0002GE-9Q; Sat, 29 Feb 2020 16:56:06 -0600
Message-ID: <79d6c3104e4fbb9b38150d2f8d336daa2f13a844.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Kumar Gala <galak@kernel.crashing.org>
Date:   Sat, 29 Feb 2020 16:56:05 -0600
In-Reply-To: <20200224233146.23734-8-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
         <20200224233146.23734-8-mpe@ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, galak@kernel.crashing.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this recipient and sender
Subject: Re: [PATCH 8/8] powerpc: Update 83xx/85xx MAINTAINERS entry
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 10:31 +1100, Michael Ellerman wrote:
> Scott said he was still maintaining this "sort of", so change the
> status to Odd Fixes.
> 
> Kumar has long ago moved on to greener pastures.
> 
> Remove the dead penguinppc.org link.
> 
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index febffee28d00..2e917116ef6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9650,11 +9650,9 @@ F:	arch/powerpc/platforms/44x/
>  
>  LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
>  M:	Scott Wood <oss@buserror.net>
> -M:	Kumar Gala <galak@kernel.crashing.org>
> -W:	http://www.penguinppc.org/
>  L:	linuxppc-dev@lists.ozlabs.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> -S:	Maintained
> +S:	Odd fixes

Acked-by: Scott Wood <oss@buserror.net>

-Scott


