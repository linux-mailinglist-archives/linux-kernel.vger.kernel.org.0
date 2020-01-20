Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4F142E34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgATO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 09:57:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DGoBy5lueJuGdaXaHkZHhUG39mTwTUjVgeOPvuTvBY8=; b=Z5t+4iwWO6pTKcFSOv3OQX70a
        5xWTubtEAVFD1kGqSUz271Ob4ZFezSnul12w8ihlsGRGlg8YustxibsfSDN987u1VgyDHektjgm29
        mzCWSTG3gOQBWzJ7ljErmQt/pq3QfpttiRFMA4AWAt9klc3USkxAiNkaGHG44jRNTtfi3krbej6it
        8+gZFHZwFOgn/yf71MVm5ZmIH2TAh/KriHO9IJ/Z4GJCmLQt6x7mt5NydXylPcKx78oryeZ49BwIc
        SViMAbhuqeLy4ZaouAPY78rB+dyj+UTNt/pUE2D0LS9F+RVgfXjJHsKra519gB75QQz9vtUTe7JEn
        VfYWCd9Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itYU6-0007t4-74; Mon, 20 Jan 2020 14:56:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA6BF3010D2;
        Mon, 20 Jan 2020 15:55:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5856E28B86E61; Mon, 20 Jan 2020 15:56:56 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:56:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 12/57] objtool: check: Allow jumps from an alternative
 group to itself
Message-ID: <20200120145656.GC14897@hirez.programming.kicks-ass.net>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-13-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-13-jthierry@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:15PM +0000, Julien Thierry wrote:
> Alternatives can contain instructions that jump to another instruction
> in the same alternative group. This is actually a common pattern on
> arm64.

LL/SC I bet...

