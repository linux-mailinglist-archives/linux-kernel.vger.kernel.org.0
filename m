Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADE60D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfGEVnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 17:43:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGEVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:43:51 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjVzd-0008F6-2f; Fri, 05 Jul 2019 23:43:45 +0200
Date:   Fri, 5 Jul 2019 23:43:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch V2 01/25] x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
In-Reply-To: <20190704155608.347938562@linutronix.de>
Message-ID: <alpine.DEB.2.21.1907052342250.3648@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.347938562@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Thomas Gleixner wrote:

> apic->send_IPI_allbutself() takes a vector number as argument.
> 
> APIC_DM_NMI is clearly not a vector number. It's defined to 0x400 which is
> outside the vector space.
> 
> Use NMI_VECTOR instead as that's what it is intended to be.
> 
> Fixes: 82da3ff89dc2 ("x86: kgdb support")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/kgdb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -424,7 +424,7 @@ static void kgdb_disable_hw_debug(struct
>   */
>  void kgdb_roundup_cpus(void)
>  {
> -	apic->send_IPI_allbutself(APIC_DM_NMI);
> +	apic->send_IPI_allbutself(VECTOR_NMI);

The changelog got it right, but this here needs to be VECTOR_NMI. While I
didn't 0-day was able to find and turn on the config option ...

/blush

