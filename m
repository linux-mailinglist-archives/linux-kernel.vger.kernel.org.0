Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE270B04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfGVVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:09:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGVVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pY0LA8u0+TRN74LRfvbZ9clUI8/84sjDmmtXY1EVvV4=; b=rGWFNPUoxM9eF46CBWGZYiC4I
        12MmieSfQODgiiA2tRe5i/NGtXNT3dyP5lUxqXFQZWoCz5UAVZD9mPmrbmP+JRDnq9yl103cyoulg
        32BEnbX04xVNbYnQ/ajs6a5Y/jWPGdliZHznjbTYJYreDIKsztww+Wdy0tfhfgHyGy0gLCEj2RBu5
        CVs4UcR5OKm2Uj2/bY3xnwDsZR1wn5+fN0Z093T9FJXNoH1CaA8GzeTbqLyPIEy8Q8oCOdmCcGQo3
        aDcU4G0/AUgV5sfcsy5z46EENvsjsf3zRJV8Ko1KTRHyKGWFrmBP57TOyIwMIQ8StPmBnzBTk3G23
        RZpO0s0cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpfYf-0003OI-1a; Mon, 22 Jul 2019 21:09:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1B0B980D1F; Mon, 22 Jul 2019 23:09:18 +0200 (CEST)
Date:   Mon, 22 Jul 2019 23:09:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 0/7] x86/percpu: Use segment qualifiers
Message-ID: <20190722210918.GM6698@worktop.programming.kicks-ass.net>
References: <20190718174110.4635-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:41:03AM -0700, Nadav Amit wrote:
> GCC 6+ supports segment qualifiers. Using them allows to implement
> several optimizations:

Overall I like this. Nice!
