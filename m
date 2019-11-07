Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2761F2A56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfKGJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:14:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbfKGJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZlRZYAP/tuUVYsqNB4BSQnFRGSEm90ZYb/ulCduZKVk=; b=FdbIGFDpO9AvVFxqFJsMNSDQ/
        e5wIOtbJH4LFDEoinB9cyBHRfT3feH5OoueDevG1D1kAsb3guG02IBgaiL97HMjOlFmxizwKurfbc
        Xf2TnrIGnJjd4qvuhnxUzy4TqPiidRnU4UHLscpsEHnSNarMCA2PnzS9KwXsi7GCubEbQHKz1FW2t
        US8U1+MaM9qOlL8mQTHzgvvOmh8tZFK2buY5fevawPSKjxTG1BnGL7EtRvaQD30m+AFQG3/yVzs2Y
        dsMn6bVgUJRb7I40zMf8Sa6YX6NoRT1u+B72be6U4gqRYaoVGVpCfSEpKkMAk9gmQOaih2lzGZBLB
        87wp2VFwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSdrH-0008EM-44; Thu, 07 Nov 2019 09:13:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19E66305FE7;
        Thu,  7 Nov 2019 10:12:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B9262B13B366; Thu,  7 Nov 2019 10:13:37 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:13:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 8/9] x86/iopl: Remove legacy IOPL option
Message-ID: <20191107091337.GB4131@hirez.programming.kicks-ass.net>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.518518372@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202806.518518372@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:35:07PM +0100, Thomas Gleixner wrote:
> The IOPL emulation via the I/O bitmap is sufficient. Remove the legacy
> cruft dealing with the (e)flags based IOPL mechanism.

Much joy at seeing this code go!
