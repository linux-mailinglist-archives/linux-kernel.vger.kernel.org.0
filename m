Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8A2688ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfGOMcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 08:32:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46058 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IZmADf5/xR5R3mmqabrQ4fHdojbS9pEGiQhr85URq6M=; b=aEybarIkTFSF6XayXEm9oTybN
        bRM340R6NHNLm2LEYd9DXp+8WWywggz0CuALF0J1wDzPuVxYFHl5h/Jw4SbiTUAtP+p3zqM/a6Lca
        uWAH/o4UXolDp6pR2+auZSFsE7irfkrG9l09A5kXNeTbBAkAuv9b3pSh6LV69G8TU2UFR19P7dSHs
        BP/piakMXAWFL9OGZtkRexsPfwx3DEGrBE5V6cPibP0GfHeoDmoIkzc3BID6B4OgeBLXPSMp7WZ2w
        RoSrOscOWXXcDUJRqOdN97QTU1LKAIpoBiSQ+oHxTwaZ5aC5ON7p97SNIWay0hnMAhwYsz9qoBbqS
        6ZKU8MzGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hn09K-0002Kz-NY; Mon, 15 Jul 2019 12:32:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2AA820144520; Mon, 15 Jul 2019 14:32:07 +0200 (CEST)
Date:   Mon, 15 Jul 2019 14:32:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
Message-ID: <20190715123207.GE3419@hirez.programming.kicks-ass.net>
References: <20190715113739.17694-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715113739.17694-1-jgross@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 01:37:37PM +0200, Juergen Gross wrote:
> The long term plan has been to replace Xen PV guests by PVH. The first
> victim of that plan are now 32-bit PV guests, as those are used only
> rather seldom these days. Xen on x86 requires 64-bit support and with
> Grub2 now supporting PVH officially since version 2.04 there is no
> need to keep 32-bit PV guest support alive in the Linux kernel.
> Additionally Meltdown mitigation is not available in the kernel running
> as 32-bit PV guest, so dropping this mode makes sense from security
> point of view, too.
> 
> Juergen Gross (2):
>   x86/xen: remove 32-bit Xen PV guest support
>   x86/paravirt: remove 32-bit support from PARAVIRT_XXL

Hooray!
