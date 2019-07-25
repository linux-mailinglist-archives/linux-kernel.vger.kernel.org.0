Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD55274EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfGYNRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:17:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eLe48Adx8R3R6OOpcoVeRgHWjDYnlo+eTHsUo3OxR/w=; b=mBV7xxZMfC2hu1g8aAurdH3k8
        puv4YVAEPATgBUGc96cD/eZxpaNEa/7RVhLiSo7RXaaZoDkXFzstIPoRifvHqOLTQJznX4VBKRYlt
        /X9mjV1uyuNwkESje9LzMoRjVsecQ8foHiUWxHLV66Lm0ToJDdV2Bx2D85qVdblaAVig9Dk3DjVwC
        EfhLmuv2jhTkY4RDG2IYNDp9AxlMnjxBv9v8aev9AplE7oUTni7pBZDMH331hE48Rji0ws6l39f65
        pW+CMt905juPn4c8iH6THw4PjWo/Ewl3nYJHgjd3k2eCMNIaOAlPBifcUjMi+G8v4/UjXTsuljcoW
        7ueTKEjBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdco-0006ls-SV; Thu, 25 Jul 2019 13:17:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17F9820A28393; Thu, 25 Jul 2019 15:17:36 +0200 (CEST)
Date:   Thu, 25 Jul 2019 15:17:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch V3 00/25] x86/apic: Support for IPI shorthands
Message-ID: <20190725131736.GK31381@hirez.programming.kicks-ass.net>
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722104705.550071814@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:47:05PM +0200, Thomas Gleixner wrote:
> This is merily a refresh of V2.
> 
> Changes vs. V2 (https://lkml.kernel.org/r/20190704155145.617706117@linutronix.de)
> 
>   - Fix the NMI_VECTOR/VECTOR_NMI typo in kgdb
> 
>   - Remove the misleading vector 0-31 wording
> 

These all look really good!

With a bit of luck Nadav will show it even makes TLB-invalidate go
faster :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
