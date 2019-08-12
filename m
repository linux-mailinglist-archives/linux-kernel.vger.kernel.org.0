Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C378998F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHLJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 05:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfHLJMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:12:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A57E2087B;
        Mon, 12 Aug 2019 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565601129;
        bh=jKSLap3YVUDN9GWCFGXtKB+Evr/yw7GL/49Uhe/orpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsrXP1+z22UZqgEGm68hWnSFd+6iCHjbKMpWDiPS1zCwotLm7wTffeuylAZV7D8FE
         YdusTaYHesQtD10SIDnaq4RoJnD6VDL0Pr+m59JU1FkiP3YUpa8PcgfdRdgtnf50uE
         S0Fuc617rVlhICH7J/g0zXUPuMMG8v2u5obq2JuI=
Date:   Mon, 12 Aug 2019 10:12:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [semaphore] Removed redundant code from semaphore's down
 family of function
Message-ID: <20190812091204.jqx3s6cq2y3swi4a@willie-the-truck>
References: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:31:43AM +0000, Satendra Singh Thakur wrote:
> -The semaphore code has four funcs
> down,
> down_interruptible,
> down_killable,
> down_timeout
> -These four funcs have almost similar code except that
> they all call lower level function __down_xyz.
> -This lower level func in-turn call inline func
> __down_common with appropriate arguments.
> -This patch creates a common macro for above family of funcs
> so that duplicate code is eliminated.
> -Also, __down_common has been made noinline so that code is
> functionally similar to previous one
> -For example, earlier down_killable would call __down_killable
> , which in-turn would call inline func __down_common
> Now, down_killable calls noinline __down_common directly
> through a macro
> -The funcs __down_interruptible, __down_killable etc have been
> removed as they were just wrapper to __down_common
> 
> Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
> ---
>  kernel/locking/semaphore.c | 107 +++++++++++++------------------------
>  1 file changed, 38 insertions(+), 69 deletions(-)

Something has gone very wrong with your mail setup, so this patch is
mangled beyond repair.

Please read Documentation/process/email-clients.rst and also work with
your employer to remove the disclaimer at the end of your email too.

Thanks,

Will
