Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65FB5D903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfGCAdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfGCAdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38662218EA;
        Tue,  2 Jul 2019 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562105176;
        bh=hVh0DP1hDzK9QjloJIO8tuHaop71NPGQzlf192YHV08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Yz+9eRy1/q9tDqMxLekJDOLDaMWutxNFfTn2WV7xifEmMRAIIRiecyoCkbX/Nva/
         Q38IpeHfCxE1sIhNQWjbuPDfPM4mQH9Ku6M/Ou2v255ShPbmo6EN5UUKyVjY8WzN9G
         zMqBtv0/5P14Fdaxs0zMCFWI9YM1aSM/LHCl9GRQ=
Date:   Tue, 2 Jul 2019 15:06:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        hch@lst.de, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-Id: <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org>
In-Reply-To: <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
        <20190530080358.GG2623@hirez.programming.kicks-ass.net>
        <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
        <20190603123705.GB3419@hirez.programming.kicks-ass.net>
        <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
        <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
        <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 08:22:32 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> Andrew, can you queue Oleg's patch for 5.2? You can also add my:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Sure.  Although things are a bit of a mess.  Oleg, can we please have a
clean resend with signoffs and acks, etc?

