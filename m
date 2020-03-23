Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97418F140
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCWIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 04:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCWIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:52:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4F620663;
        Mon, 23 Mar 2020 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584953565;
        bh=wG7SF/RkUIf8rHHlON28AbIfMYRx4lCr5muY2st+zok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq+D2qplejpaEEiqKBfPUZfVoc8f0nWfIMvoK4uhIVehr0T/u9irhCLTM2abpYyqa
         uYZrJ5wH8dMpTNMiXi3rPw6df1vFI09lZs8uYQzwYDpy+5sd9tHI5NPmrj+fwn69KL
         7tEpDPkAnv77Ttj1cv/3do6EiivOo2aeo0AC0lzk=
Date:   Mon, 23 Mar 2020 09:52:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu DASA <vdasa@vmware.com>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200323085241.GA342330@kroah.com>
References: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:22:33PM +0800, Xiyu Yang wrote:
> A NULL vmci_ctx object may pass to vmci_ctx_put() from its callers.

Are you sure this can happen?

> Add a NULL check to prevent NULL pointer dereference.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What changed from v1?

Always put that below the --- line.

Please fix up and send a v3.

thanks,

greg k-h
