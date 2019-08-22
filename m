Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A429A397
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394265AbfHVXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbfHVXOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:14:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6CC2173E;
        Thu, 22 Aug 2019 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566515669;
        bh=vApCOM3H3LWmBhR9eGKlIz7FlGeav7+0V7QMAv0lrz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JnFvVQX53Ce1G2PQ2HOdxbB/SubAMwjIprQiE8EBfadRyLGqt1J+ii+olw/j5668Y
         +QtLBXDlkv6/aLoxjapTqHtWc0fc3gJRJDtnIBEIp+3qWO0oQofuFmpQXuSE4efjH3
         lHWO0el4UUudjvso5nDstFN30oxIxxABVA7nHCxs=
Date:   Thu, 22 Aug 2019 16:14:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
Message-Id: <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
In-Reply-To: <20190820202440.GH11147@phenom.ffwll.local>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
        <20190820081902.24815-4-daniel.vetter@ffwll.ch>
        <20190820202440.GH11147@phenom.ffwll.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 22:24:40 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:

> Hi Peter,
> 
> Iirc you've been involved at least somewhat in discussing this. -mm folks
> are a bit undecided whether these new non_block semantics are a good idea.
> Michal Hocko still is in support, but Andrew Morton and Jason Gunthorpe
> are less enthusiastic. Jason said he's ok with merging the hmm side of
> this if scheduler folks ack. If not, then I'll respin with the
> preempt_disable/enable instead like in v1.

I became mollified once Michel explained the rationale.  I think it's
OK.  It's very specific to the oom reaper and hopefully won't be used
more widely(?).

