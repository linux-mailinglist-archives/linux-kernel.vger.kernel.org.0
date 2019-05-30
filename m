Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB882FB67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfE3MFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 08:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfE3MFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EA1EA0B58;
        Thu, 30 May 2019 12:05:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id B24C819736;
        Thu, 30 May 2019 12:05:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 May 2019 14:05:34 +0200 (CEST)
Date:   Thu, 30 May 2019 14:05:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190530120531.GE22536@redhat.com>
References: <20190529113157.227380-1-jannh@google.com>
 <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 30 May 2019 12:05:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29, Jann Horn wrote:
>
> > (I am wondering if smp_acquire__after_ctrl_dep() could be used instead, just to
> >  make this code look more confusing)
>
> Uuh, I had no idea that that barrier type exists. The helper isn't
> even explicitly mentioned in Documentation/memory-barriers.rst. I
> don't really want to use dark magic in the middle of ptrace access
> logic...

Yes. and if it was not clear I didn't try to seriously suggest to use this
barrier. I was just curious if it can be used or not in this particular case.

> Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
> make sense here;

Well I still _think_ it should work, it provides the LOAD-LOAD ordering
and this is what we need.

But I can be easily wrong, and again, I wasn't serious.

Oleg.

