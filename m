Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0858E90F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 12:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfHOKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 06:32:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39533 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfHOKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:32:08 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyD2z-0001jE-AI; Thu, 15 Aug 2019 12:31:57 +0200
Date:   Thu, 15 Aug 2019 12:31:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH 1/3] x86: cpu: Use constant definitions for CPU type
In-Reply-To: <bb09309eb9b4de8b8eff83d00d34c135b048fe25.1565856842.git.rahul.tanwar@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1908151226580.1923@nanos.tec.linutronix.de>
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com> <bb09309eb9b4de8b8eff83d00d34c135b048fe25.1565856842.git.rahul.tanwar@linux.intel.com>
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

Rahul,

On Thu, 15 Aug 2019, Rahul Tanwar wrote:

Please use the proper prefix for your patches. x86 uses

x86/subsystem: not x86: subsystem:

> This patch replaces direct values usage with constant definitions usage
> when access CPU models.

Please do not use 'This patch'. We already know that this is a patch
otherwise you wouldn't have sent it with [PATCH] on the subject line,
right?

See Documentation/process/submitting-patches.rst and search for 'This
patch'.

> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 8d6d92ebeb54..0419fba1ea56 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -265,9 +265,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
>  	if (c->x86 == 6) {
>  		switch (c->x86_model) {
> -		case 0x27:	/* Penwell */
> -		case 0x35:	/* Cloverview */
> -		case 0x4a:	/* Merrifield */
> +		case INTEL_FAM6_ATOM_SALTWELL_MID:	/* Penwell */
> +		case INTEL_FAM6_ATOM_SALTWELL_TABLET:	/* Cloverview */
> +		case INTEL_FAM6_ATOM_SILVERMONT_MID:	/* Merrifield */

Are these comments really still useful now that the defines are used? I
don't think so.

Thanks,

	tglx
