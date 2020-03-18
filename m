Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4D189A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 07:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRLBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8B42076D;
        Wed, 18 Mar 2020 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584529270;
        bh=M8URaHMyLbOAuXYgTHwd0O8zOnmlQoi9wjYDbhAlz30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwvR6OpwEeUWcjwMeYQZiyEmBLKi4CCnoeD3n0R/6HoPfpigLoZRIw5RA0jLBnorN
         XTdG5fo+Kjy8ETKhQZuZzuhgchcq9iPlf9NVcbCXFCIL5jeOTrcWRL2LCr3i4Qcs/s
         gN/OnsWSidwGOuiNMzDFmNgZv9qXNN4B1wiQlstw=
Date:   Wed, 18 Mar 2020 12:01:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vishnu DASA <vdasa@vmware.com>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: Re: [PATCH] VMCI: Fix potential NULL pointer dereference when
 acquire a lock
Message-ID: <20200318110108.GA2305113@kroah.com>
References: <1584376610-11979-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584376610-11979-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:36:47AM +0800, Xiyu Yang wrote:
> A NULL pointer can be returned by vmci_ctx_get(). Thus add a
> corresponding check so that a NULL pointer dereference will
> be avoided when acquire a lock in spin_lock.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> index 16695366ec92..a20878fba374 100644
> --- a/drivers/misc/vmw_vmci/vmci_context.c
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -898,6 +898,8 @@ void vmci_ctx_rcv_notifications_release(u32 context_id,
>  					bool success)
>  {
>  	struct vmci_ctx *context = vmci_ctx_get(context_id);
> +	if (context == NULL)
> +		return;

But, if you look at the code, context_id is guaranteed to point to a
valid context, right?  Or can this somehow get dropped between the last
"get" and this one?

Anyway, the coding style is wrong here, always run checkpatch.pl on your
patches please.

thanks,

greg k-h
