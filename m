Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874B4A34EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfH3KZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 06:25:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfH3KZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 584EBAC8F;
        Fri, 30 Aug 2019 10:25:22 +0000 (UTC)
Date:   Fri, 30 Aug 2019 12:25:20 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 2/2] x86/mm/pti: Do not invoke PTI functions when PTI is
 disabled
Message-ID: <20190830102520.GH17192@suse.de>
References: <20190828142445.454151604@linutronix.de>
 <20190828143124.063353972@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828143124.063353972@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:24:47PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -668,6 +668,8 @@ void __init pti_init(void)
>   */
>  void pti_finalize(void)
>  {
> +	if (!boot_cpu_has(X86_FEATURE_PTI))
> +		return;
>  	/*
>  	 * We need to clone everything (again) that maps parts of the
>  	 * kernel image.
>

Reviewed-by: Joerg Roedel <jroedel@suse.de>
