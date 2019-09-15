Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0328B3118
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 19:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfIORMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 13:12:05 -0400
Received: from baldur.buserror.net ([165.227.176.147]:32810 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIORMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:12:05 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i9Y1u-00037s-1D; Sun, 15 Sep 2019 12:09:42 -0500
Message-ID: <fb07c36767c1b4c6bacfd4bb0fddf789d248573e.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 15 Sep 2019 12:09:40 -0500
In-Reply-To: <e9437d8c-564e-cc76-e8fd-54e4000c2349@c-s.fr>
References: <b51b96090138aba1920d2cf7c0e0e348667f9a69.1566564560.git.christophe.leroy@c-s.fr>
         <331759c1bcba5797d30f8eace74afb16ac5f3c36.1566564560.git.christophe.leroy@c-s.fr>
         <b201df6242e7f6cebd525e0a301eef2afdb38f30.camel@buserror.net>
         <e9437d8c-564e-cc76-e8fd-54e4000c2349@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
Subject: Re: [PATCH 2/2] powerpc/83xx: map IMMR with a BAT.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-14 at 18:51 +0200, Christophe Leroy wrote:
> 
> Le 14/09/2019 à 16:34, Scott Wood a écrit :
> > On Fri, 2019-08-23 at 12:50 +0000, Christophe Leroy wrote:
> > > On mpc83xx with a QE, IMMR is 2Mbytes.
> > > On mpc83xx without a QE, IMMR is 1Mbytes.
> > > Each driver will map a part of it to access the registers it needs.
> > > Some driver will map the same part of IMMR as other drivers.
> > > 
> > > In order to reduce TLB misses, map the full IMMR with a BAT.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > >   arch/powerpc/platforms/83xx/misc.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/platforms/83xx/misc.c
> > > b/arch/powerpc/platforms/83xx/misc.c
> > > index f46d7bf3b140..1e395b01c535 100644
> > > --- a/arch/powerpc/platforms/83xx/misc.c
> > > +++ b/arch/powerpc/platforms/83xx/misc.c
> > > @@ -18,6 +18,8 @@
> > >   #include <sysdev/fsl_soc.h>
> > >   #include <sysdev/fsl_pci.h>
> > >   
> > > +#include <mm/mmu_decl.h>
> > > +
> > >   #include "mpc83xx.h"
> > >   
> > >   static __be32 __iomem *restart_reg_base;
> > > @@ -145,6 +147,14 @@ void __init mpc83xx_setup_arch(void)
> > >   	if (ppc_md.progress)
> > >   		ppc_md.progress("mpc83xx_setup_arch()", 0);
> > >   
> > > +	if (!__map_without_bats) {
> > > +		int immrsize = IS_ENABLED(CONFIG_QUICC_ENGINE) ? SZ_2M :
> > > SZ_1M;
> > 
> > Any reason not to unconditionally make it 2M?  After all, the kernel being
> > built with CONFIG_QUICC_ENGINE doesn't mean that the hardware you're
> > running
> > on has it...
> > 
> 
> Euh .. ok. I didn't see it that way, but you are right.
> 
> Do you think it is not a problem to map 2M even when the quicc engine is 
> not there ? Or should it check device tree instead ?

It should be OK, since it's a guarded mapping.  Unless the IMMR base is not 2M
aligned...

-Scott


