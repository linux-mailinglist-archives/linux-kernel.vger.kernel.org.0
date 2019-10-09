Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE999D13FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfJIQ1i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Oct 2019 12:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:27:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C0820B7C;
        Wed,  9 Oct 2019 16:27:36 +0000 (UTC)
Date:   Wed, 9 Oct 2019 12:27:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
Message-ID: <20191009122735.17415f9c@gandalf.local.home>
In-Reply-To: <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
        <20191009110943.7ff3a08a@gandalf.local.home>
        <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 09:13:17 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 9 Oct 2019 14:14:28 +0200
> > Markus Elfring <Markus.Elfring@web.de> wrote:
> >  
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Wed, 9 Oct 2019 13:53:59 +0200
> > >
> > > Several functions return values with which useful data processing
> > > should be performed. These values must not be ignored then.
> > > Thus use the annotation “__must_check” in the shown function declarations.
> > >
> > > Add also corresponding parameter names for adjusted functions.
> > >
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > >  
> >
> > I'm curious. How many warnings showed up when you applied this patch?  
> 
> I got zero for x86_64 and arm64 defconfig builds of linux-next with
> this applied.  Hopefully that's not an argument against the more
> liberal application of it?  I view __must_check as a good thing, and
> encourage its application, unless someone can show that a certain
> function would be useful to call without it.

Not at all, I was just curious, because I would have expected patches
to fix possible bugs with it.

-- Steve
