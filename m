Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B335DA27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 03:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGCBDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGCBDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF65A21874;
        Tue,  2 Jul 2019 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562098428;
        bh=JSSTummgovKzjJ78cGvRjxWkWBFR6+oqkDGCqnix+5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pVL9BX1mfkWNMZ4JuOXEP1bLnhu3I9BVToumxa1kjdZNRBH56OgKPIrtlVhivYmCX
         ByFpnYvXObta8eYhxDF+YD3vem2AyauZtEzCHZHVRal/nPjba1ZSg4n+ipbJJB+Ury
         uo7TwFjCDC96bjssFiG+pA6PpZbeBceSeH91LZd4=
Date:   Tue, 2 Jul 2019 13:13:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH] proc/sysctl: add shared variables for range check
Message-Id: <20190702131348.9004db6da7e1cbeb7db5ca9f@linux-foundation.org>
In-Reply-To: <CAGnkfhxPhHxmNFCMHj8QTYKtLi08O8C5-6Qua8zRz4FX=8g+pw@mail.gmail.com>
References: <20190702170228.GA4404@avx2>
        <CAGnkfhxPhHxmNFCMHj8QTYKtLi08O8C5-6Qua8zRz4FX=8g+pw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 19:21:33 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> On Tue, Jul 2, 2019 at 7:13 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > -static long zero;
> > >  static long long_max = LONG_MAX;
> > >
> > >  struct ctl_table epoll_table[] = {
> > > @@ -301,7 +300,7 @@ struct ctl_table epoll_table[] = {
> > >                 .maxlen         = sizeof(max_user_watches),
> > >                 .mode           = 0644,
> > >                 .proc_handler   = proc_doulongvec_minmax,
> > > -               .extra1         = &zero,
> > > +               .extra1         = SYSCTL_ZERO,
> > >                 .extra2         = &long_max,
> >
> > This looks wrong: proc_doulongvec_minmax() expects "long"s.
> > The whole patch needs rechecking.
> >
> > > +/* shared constants to be used in various sysctls */
> > > +const =======>int<========== sysctl_vals[] = { 0, 1, INT_MAX };
> > > +EXPORT_SYMBOL(sysctl_vals);
> 
> Yes, you're right, that chunk must be dropped.
> Anyway I've checked the patch, this was the only long field touched.

Yup.

akpm3:/usr/src/25> find . -name "*.c" | xargs grep -C4 SYSCTL_ZERO|grep long
./fs/eventpoll.c-               .proc_handler   = proc_doulongvec_minmax,
./fs/eventpoll.c-               .extra2         = &long_max,

I did this:

--- a/fs/eventpoll.c~proc-sysctl-add-shared-variables-for-range-check-fix-4
+++ a/fs/eventpoll.c
@@ -291,6 +291,7 @@ static LIST_HEAD(tfile_check_list);
 
 #include <linux/sysctl.h>
 
+static long long_zero;
 static long long_max = LONG_MAX;
 
 struct ctl_table epoll_table[] = {
@@ -300,7 +301,7 @@ struct ctl_table epoll_table[] = {
 		.maxlen		= sizeof(max_user_watches),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.extra1		= &long_zero,
 		.extra2		= &long_max,
 	},
 	{ }

I renamed it to avoid using "&zero," in this situation.
