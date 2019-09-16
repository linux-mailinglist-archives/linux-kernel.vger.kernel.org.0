Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3086B41F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbfIPUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 16:36:35 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35306 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIPUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:36:35 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i9xjV-0001Rl-Ai; Mon, 16 Sep 2019 15:36:25 -0500
Message-ID: <a4aaf0a84ce0d48840d4c80af19bf4899667d330.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Sep 2019 15:36:23 -0500
In-Reply-To: <269a00951328fb6fa1be2fa3cbc76c19745019b7.1568665466.git.christophe.leroy@c-s.fr>
References: <a212bd36fbd6179e0929b6c727febc35132ac25c.1568665466.git.christophe.leroy@c-s.fr>
         <269a00951328fb6fa1be2fa3cbc76c19745019b7.1568665466.git.christophe.leroy@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Subject: Re: [PATCH v3 2/2] powerpc/83xx: map IMMR with a BAT.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 20:25 +0000, Christophe Leroy wrote:
> On mpc83xx with a QE, IMMR is 2Mbytes and aligned on 2Mbytes boundarie.
> On mpc83xx without a QE, IMMR is 1Mbyte and 1Mbyte aligned.
> 
> Each driver will map a part of it to access the registers it needs.
> Some drivers will map the same part of IMMR as other drivers.
> 
> In order to reduce TLB misses, map the full IMMR with a BAT. If it is
> 2Mbytes aligned, map 2Mbytes. If there is no QE, the upper part will
> remain unused, but it doesn't harm as it is mapped as guarded memory.
> 
> When the IMMR is not aligned on a 2Mbytes boundarie, only map 1Mbyte.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> v2:
> - use a fixmap area instead of playing with ioremap_bot
> - always map 2M unless IMMRBAR is only 1M aligned
> 
> v3:
> - replaced __fix_to_virt() by fix_to_virt()
> ---
>  arch/powerpc/include/asm/fixmap.h  |  8 ++++++++
>  arch/powerpc/platforms/83xx/misc.c | 11 +++++++++++
>  2 files changed, 19 insertions(+)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


