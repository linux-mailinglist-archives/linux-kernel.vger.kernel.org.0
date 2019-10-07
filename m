Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83041CE9E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfJGQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 12:56:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfJGQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=egyNvvDaF3fYRRuXgJGtqWgyD7ibad4z9LSF5N2tWuc=; b=H9ja7dGm/wjmfa+f5qooQvdWj
        xWSoPqJSHPb1zKrGwlJjlFXOei5erg578YBnAyf6Yt4gVFw2Bz2eKx81+zwCtmSZtnm5w22uNFjHw
        Bki0o++Wia2pWOpVa7DAcv74gcKOkS7Vb/5RBzjcW2xp/7aSOuq1duWkfIbwTWRpwVlgpScw2hUbJ
        2Ex1xZLr8BPvRTfRjdloKHYPkWdBHzqhFBxfvnzIZQwOF4tPjKuCGd3n130IQamj7Yiz1IVD2v0uk
        m/RWk95tNq2+m11JkryK7UjFYYF3BOHXXlk8OStcILl+RrbkldqzviHvv3qKJoqCq5tt8bYTMA1BM
        WfA9VAd1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHWJ2-00012n-H9; Mon, 07 Oct 2019 16:56:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 453B79802D2; Mon,  7 Oct 2019 18:56:18 +0200 (CEST)
Date:   Mon, 7 Oct 2019 18:56:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jie Meng <jmeng@fb.com>,
        Hechao Li <hechaol@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Message-ID: <20191007165618.GJ4643@worktop.programming.kicks-ass.net>
References: <20190904214618.3795672-1-songliubraving@fb.com>
 <20190930090253.GL4553@hirez.programming.kicks-ass.net>
 <B97C6326-7CA2-4F57-A259-F5FB152E14D1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B97C6326-7CA2-4F57-A259-F5FB152E14D1@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:31:37PM +0000, Song Liu wrote:
> Hi Peter,
> 
> > On Sep 30, 2019, at 2:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Sep 04, 2019 at 02:46:18PM -0700, Song Liu wrote:
> >> perf_mmap() always increases user->locked_vm. As a result, "extra" could
> >> grow bigger than "user_extra", which doesn't make sense. Here is an
> >> example case:
> >> 
> >> Note: Assume "user_lock_limit" is very small.
> >> | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
> >> | 0                    | 0                   | 0             |
> >> | 1                    | user_extra          | user_extra    |
> >> | 2                    | 3 * user_extra      | 2 * user_extra|
> >> | 3                    | 6 * user_extra      | 3 * user_extra|
> >> | 4                    | 10 * user_extra     | 4 * user_extra|
> >> 
> >> Fix this by maintaining proper user_extra and extra.
> > 
> > Aah, indeed.
> 
> Thanks for the feedback!
> 
> > 
> > Also, this code is unreadable (which is mostly my own fault I suppose)
> > :/
> 
> How does this patch look to you? Is it ready to merge?

Yes, I queued it, I'll get it into tip soon. It got held up due to me
working on some other patches, sorry about that.
