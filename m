Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17A95B6D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGAI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 04:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfGAI2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:28:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB05208C4;
        Mon,  1 Jul 2019 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561969691;
        bh=VA7edMDdwxFSaRG0IcUd5SjoTcBPI34Q3YvdIxNtTpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFxuos+Z/2a0YjDDcJRC7XZY/mCtH3+PCtm9X557iA/Z16aYYDReA9p4fgKQeIxZu
         pSERArKKEzOykrNrhNpf7mq528eLZSRxrILKvY34p2s/4tOlzZdMmw1889YCCRAUSs
         6cNfbrXg8MwhnXn7BMlpEimqIahF4v1vNuHuQ+aM=
Date:   Mon, 1 Jul 2019 09:28:06 +0100
From:   Will Deacon <will@kernel.org>
To:     "Saidi, Ali" <alisaidi@amazon.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Matt Mackall <mpm@selenic.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rindjunsky, Ron" <ronrindj@amazon.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH 0/3] Add support for Graviton TRNG
Message-ID: <20190701082805.pifv4attux4mddld@willie-the-truck>
References: <20190604203100.15050-1-alisaidi@amazon.com>
 <20190605122031.GK15030@fuggles.cambridge.arm.com>
 <7EC45708-38A1-4826-BC82-298EFAAE30B1@amazon.com>
 <3104F396-094F-454C-8308-BF651FAB99AB@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3104F396-094F-454C-8308-BF651FAB99AB@amazon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this was in my spam folder]

On Fri, Jun 28, 2019 at 06:05:10PM +0000, Saidi, Ali wrote:
> On 6/7/19, 7:59 AM, " Ali Saidi" <alisaidi@amazon.com> wrote:
>     On 6/5/19, 7:20 AM, "Will Deacon" <will.deacon@arm.com> wrote:
>         On Tue, Jun 04, 2019 at 08:30:57PM +0000, Ali Saidi wrote:
>         > AWS Graviton based systems provide an Arm SMC call in the vendor defined
>         > hypervisor region to read random numbers from a HW TRNG and return them to the
>         > guest. 
>         > 
>         > We've observed slower guest boot and especially reboot times due to lack of
>         > entropy and providing access to a TRNG is meant to address this. 
>         
>         Curious, but why this over something like virtio-rng?
>         
>     This interface allows us to provide the functionality from both EL2
>     and EL3 and support multiple different types of our instances which we
>     unfortunately can't do with virt-io.
>     
> Any additional comments?
> Do you know when you'll have a chance to rebase arm64/smccc-cleanup?

Sorry, Ali, this slipped through the cracks. Marc and I will chat today and
look at respinning what we had before; it should then hopefully be
straightforward enough for you to take that as a base for what you want to
do.

Will
