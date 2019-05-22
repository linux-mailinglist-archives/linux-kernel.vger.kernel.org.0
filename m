Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373A625DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfEVFwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 01:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfEVFwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:52:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD27C2075B;
        Wed, 22 May 2019 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558504358;
        bh=MOOvFks2X2/0Me/x7uUKuKfWslyU2/dV4Y1ZvWtG8Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tquLToUxhpWNSQQ5bRsDNiT5VCMYBXGFhf3QCxP/K7r/9PGAMyYSNZM5U5CBYArSJ
         lK3+0xRnm6uaFLiepxa/bFSUMsOhIucJnQcalVE1gLYj+66iRBpXMkKi/HCQFLRjFR
         5NfvrXoOoy34nFIc9eTFC0atwCZD7SUvN6mdOPlA=
Date:   Wed, 22 May 2019 07:52:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190522055235.GC13702@kroah.com>
References: <20190522110115.7350be3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522110115.7350be3e@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:01:15AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pidfd tree got a conflict in:
> 
>   tools/testing/selftests/pidfd/Makefile
> 
> between commit:
> 
>   ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")
> 
> from Linus' tree and commit:
> 
>   233ad92edbea ("pidfd: add polling selftests")
> 
> from the pidfd tree.

Sorry, you are going to get a number of these types of minor conflicts
now.  That's the problem of touching thousands of files :(

thanks,

greg k-h
