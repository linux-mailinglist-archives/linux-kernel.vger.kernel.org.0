Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493FE150F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgBCSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 13:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgBCSIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:08:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607D620838;
        Mon,  3 Feb 2020 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580753315;
        bh=4eD3rDXxW60j+H1NP2OqAujGFcgndqdD6vtGqWg5yII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nARYeB+4A7YHVm5QW3bw9H1KvX35gnxpIa8D9P+RvoHIG7wGRprjacjtTdkSNIQkL
         rBs9agFUqGBOZBNzwWO1Qz/Ua7SWHFrTjnaOWiF9m/t8+cM5oRmA7luMJ2xFsWrc4u
         4XNJQg3uCwb6llteHfZqljM4+YqsJNG3aWhYMhuI=
Date:   Mon, 3 Feb 2020 18:08:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, oleg@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
Message-ID: <20200203180829.GA12136@willie-the-truck>
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131150703.194229898@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 04:07:03PM +0100, Peter Zijlstra wrote:
> This is the long awaited report of the percpu-rwsem rework (sorry Juri).
> 
> IIRC (I really have trouble keeping up momentum on this series) I've addressed
> all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
> this in tip/locking/core for inclusion in the next merge.
> 
> It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.
> 
> Any objections to me stuffing it in so we can all forget about it properly?

Whole series looks fine to me and it also passes my arm64 build tests, so:

Acked-by: Will Deacon <will@kernel.org>

Will
