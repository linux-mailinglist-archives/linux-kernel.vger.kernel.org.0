Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C045D15548F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 04:24:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yaE19GgpjVX5EZUeoCXo1Tot1/ENKsmmaOeID2j9w7k=; b=fuRDhn/wOjdvyk0m/AyqA/kup7
        zrsbwXouGB5slDalE0R/KNtPkUPPkbVHPhS9GkjhGlxd2QdwEG+HgNMz8WK+EqsCwmUHfP2i3YUb6
        /Nt5s0JUx4pw2up1M/cQs/WXlr1o8zdkaAhQ2nh6fVIfysjqB1RrqFlu0wVpeYZn9/7l1PHcHe1PA
        S00jCNQJeqSygWrfPYXDdPej8QUmNXK0In69nBO8Rp6pX2DRS3frF6KHbQE8Hx7/qbQi1E6eXZMVF
        BYhV/FD4QlgOXZL6y1VtNr/6Ba1Gk6AoZ5sfo5Pq2L0W8Et7/gUgUzxQgGvovtV4xX42g6v3mKFcT
        CJFQnSOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izzsA-0007ba-3H; Fri, 07 Feb 2020 09:24:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABAC3304B7F;
        Fri,  7 Feb 2020 10:22:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BFDA2B81491C; Fri,  7 Feb 2020 10:24:23 +0100 (CET)
Date:   Fri, 7 Feb 2020 10:24:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200207092423.GC14914@hirez.programming.kicks-ass.net>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:02:36PM -0800, Andy Lutomirski wrote:
> Also, in the shiny new era of
> Intel-CPUs-can’t-handle-Jcc-spanning-a-cacheline, function alignment
> may actually matter.

*groan*, indeed. I just went and looked that up. I missed this one in
all the other fuss :/

So per:

  https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf

the toolchain mitigations only work if the offset in the ifetch window
(32 bytes) is preserved. Which seems to suggest we ought to align all
functions to 32byte before randomizing it, otherwise we're almost
guaranteed to change this offset by the act of randomizing.

