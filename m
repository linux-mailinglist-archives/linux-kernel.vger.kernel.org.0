Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8470B02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfGVVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:07:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGVVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IFeU/0oltT0V+jaMXcs+mhIGLcUmo4eqxZamdwL0OoU=; b=MBmhPZcX+btbne+QodGupnlko
        GTn2pfUZoL08+6pgExaN33JzkNmjSCbb3Hn7DxvEQcNIo5vfXtVuQjJNfRD86k+EEpIvX3VoMSOLz
        Jf7mIe51Wi9VN2yRsipoFsMqyvIKIlfXUo8ciU8YrL7JqI1Hdl6/92h1wIUYYwRlYgEUFfScbEzjJ
        TGoIH6VRh4KmJLu73yomnzZjXvwZ8W3/YpyaeYB8n1YrWTbUIa523+X9H8ZGEONJfGb3hbHQawCVY
        zSjT/mDncOGGsmKfFBm5a0yq28vpxUGi/e8KD96M1ys/nlUEwltc0tfbx+rildZ6xNdUOQgNksuPP
        YaPczcPDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpfWU-0003Hv-Fn; Mon, 22 Jul 2019 21:07:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47455980D1F; Mon, 22 Jul 2019 23:07:04 +0200 (CEST)
Date:   Mon, 22 Jul 2019 23:07:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 7/7] x86/current: Aggressive caching of current
Message-ID: <20190722210704.GL6698@worktop.programming.kicks-ass.net>
References: <20190718174110.4635-1-namit@vmware.com>
 <20190718174110.4635-8-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718174110.4635-8-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:41:10AM -0700, Nadav Amit wrote:
> The current_task is supposed to be constant in each thread and therefore
> does not need to be reread. There is already an attempt to cache it
> using inline assembly, using this_cpu_read_stable(), which hides the
> dependency on the read memory address.

Is that what it does?!, I never quite could understand
percpu_stable_op().
