Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E415307A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBEMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 07:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBEMTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:19:13 -0500
Received: from localhost (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7012D2072B;
        Wed,  5 Feb 2020 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580905153;
        bh=LOewdwSTaVK8VM0ryRaJS1Fmt63m9VezPAf3BvT7ukg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w5gXdX7dC8sMqpjcPAj5EfndRO7hIwEguTYeiTh7vDbWwDOHAxo03Cfa6KK68BReE
         AuSU5i/IpNaHKTlvlCJ/mvtqD14wM0gzODMU6uewLVGGp4QIcvG/6Wf7Iz2Biz9QZZ
         D8B8Eme59qOw05MlLwXTepvyKJ8FPjy7xtPXNTac=
Date:   Wed, 5 Feb 2020 12:19:10 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Documentation/process: Add Arm contact for embargoed HW
 issues
Message-ID: <20200205121910.GA1184961@kroah.com>
References: <20200205001627.27356-1-grant.likely@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205001627.27356-1-grant.likely@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 12:16:27AM +0000, Grant Likely wrote:
> Adding myself to list after getting voluntold
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ ./scripts/get_maintainer.pl --file Documentation/process/embargoed-hardware-issues.rst
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:3/11=27%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:10/11=91%)
....

{sigh}

I'll pick this up :)

thanks,

greg k-h


