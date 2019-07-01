Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C663790C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfFFQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 12:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfFFQCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:02:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32DA720645;
        Thu,  6 Jun 2019 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559836950;
        bh=96z3Elkgrr+iSpmAnXe8RdLlNb1tSjIsOLLmdBj8Z8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjuPU/k9hlIieLjbhCrciuv1C2v4bTuYxfFHTgTVjTN/HcPgmevO3W8dKFtiz895Y
         +6WOmBQ9+zYb7AHsiRCpsnIBJmwyi6f+gW0abbba+WzaM8ithw1ms9P7hVjnNQsqDs
         5H4BBMec17s0kaAAWEULK9dmDepPOZBPoAkDDBQs=
Date:   Thu, 6 Jun 2019 18:02:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, arnd@arndb.de,
        jhansen@vmware.com, vdasa@vmware.com, aditr@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] VMCI: Fixup atomic64_t abuse
Message-ID: <20190606160228.GA29583@kroah.com>
References: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:34:28AM +0200, Peter Zijlstra wrote:
> 
> The VMCI driver is abusing atomic64_t and atomic_t, there is no actual
> atomic RmW operations around.
> 
> Rewrite the code to use a regular u64 with READ_ONCE() and
> WRITE_ONCE() and a cast to 'unsigned long'. This fully preserves
> whatever broken there was (it's not endian-safe for starters, and also
> looks to be missing ordering).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/vmw_vmci_defs.h |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

Now applied.

It's pretty horrid code, at least it's a tiny bit better now...

thanks,

greg k-h
