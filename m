Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09225D9453
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393931AbfJPOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731578AbfJPOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:52:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63599B448;
        Wed, 16 Oct 2019 14:52:09 +0000 (UTC)
Date:   Wed, 16 Oct 2019 16:52:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] printf: add support for printing symbolic error names
Message-ID: <20191016145208.dqvquyw2m4o5skbz@pathway.suse.cz>
References: <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191015190706.15989-1-linux@rasmusvillemoes.dk>
 <CAHp75Vcw9Wn6a2VEhQ00o1FZq=egtiQGjC1=uX1J71wQ9pf-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcw9Wn6a2VEhQ00o1FZq=egtiQGjC1=uX1J71wQ9pf-pw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-10-16 16:49:41, Andy Shevchenko wrote:
> On Tue, Oct 15, 2019 at 10:07 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
> > +const char *errname(int err)
> > +{
> > +       const char *name = __errname(err > 0 ? err : -err);
> 
> Looks like mine comment left unseen.
> What about to simple use abs(err) here?

Andy, would you want to ack the patch with this change?
I could do it when pushing the patch.

Otherwise, it looks ready to go.

Thanks everybody involved for the patience.

Best Regards,
Petr
