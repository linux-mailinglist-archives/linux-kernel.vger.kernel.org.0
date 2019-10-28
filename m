Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE1E753B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfJ1Pd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfJ1Pd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:33:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4259E208C0;
        Mon, 28 Oct 2019 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572276807;
        bh=GEAF8WDYQJXvdBM/dpAEVJw2HHTIQL1AvbxtREOQuSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANU6gVra1VheFuJcodGL9rT6RSxzn0BOth8DLZHkrTlZG9MdaIkeqzKvlxlbUrAWN
         RhLossBe3fZ3S3Viw+BReJ7HZ6oxH13+DiwBZu6alA9yl5XAc0OeO5/bYwTGEb8P+Y
         z6JtU8v3lCLmpPxW7uy6U7zbL03veg3OAm7Tzp3I=
Date:   Mon, 28 Oct 2019 15:33:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] docs: remove :c:func: from refcount-vs-atomic.rst
Message-ID: <20191028153321.GB5576@willie-the-truck>
References: <20191004105449.3671ff78@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004105449.3671ff78@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:58:22AM -0600, Jonathan Corbet wrote:
> As of 5.3, the automarkup extension will do the right thing with function()
> notation, so we don't need to clutter the text with :c:func: invocations.
> So remove them.
> 
> Looking at the generated output reveals that we lack kerneldoc coverage for
> much of this API, but that's a separate problem.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> I'll feed this through docs-next unless somebody tells me otherwise...
> 
>  Documentation/core-api/refcount-vs-atomic.rst | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Certainly looks more readable to me :)

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
