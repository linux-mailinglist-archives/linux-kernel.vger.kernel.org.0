Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07A7195CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0RfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:35:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0RfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VYuBB0bAQRj70GP06mt9tc9IoP3K7fcjEnkiFnaHqTU=; b=hBe+vc3IGuMijH+RTA9jPWr+pQ
        fHbckaim/P7M+TKJndc4w8P/0ZvHkSxlT/bVSggjsE1JDpyu658iX33gKiK4OnxGwY0aO0bnoJ+fw
        9M4ONuSmv23/xu2uc8Riu1bgS8IR/mKh+Uu9N+bALhFwummxTSeyR9tP8Z1OX4sRK/QlV+CurxW3C
        Dp7VBEeIZT/mq643+Ud+qkxPw6YaQDsoNE913AtfXk3L9dLLk7g+JwxDwDEv6POOHxTGKAUEHKQaU
        5zoOtR3FgoxnkLH5RHNUwn/mXkaPK4hV9in5r9qlHLBXsrvBv2dZDpIMmJ21mNRax1nFpM40gNMk4
        Kr7ljG8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHssm-0001AK-9j; Fri, 27 Mar 2020 17:35:00 +0000
Date:   Fri, 27 Mar 2020 10:35:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        peter@bikeshed.quignogs.org.uk, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
Message-ID: <20200327173500.GR22483@bombadil.infradead.org>
References: <20200326192947.GM22483@bombadil.infradead.org>
 <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
 <87imiqghop.fsf@intel.com>
 <20200327104126.667b5d5b@lwn.net>
 <20200327165022.GP22483@bombadil.infradead.org>
 <20200327111106.57982763@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327111106.57982763@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:11:06AM -0600, Jonathan Corbet wrote:
> On Fri, 27 Mar 2020 09:50:22 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Let me just check I understand Jani's proposal here.  You want to change
> > 
> > * Return: Number of pages, or negative errno on failure
> > 
> > to
> > 
> > * Return
> > * ~~~~~~
> > * Number of pages, or negative errno on failure
> > 
> > If so, I oppose such an increase in verbosity and I think most others
> > would too.  If not, please let me know what you're actually proposing ;-)
> 
> I told you there would be resistance :)

Happy to help out!

> I think a reasonable case can be made for using the same documentation
> format throughout our docs, rather than inventing something special for
> kerneldoc comments.  So I personally don't think the above is terrible,
> but as I already noted, I anticipate resistance.
> 
> An alternative would be to make a little sphinx extension; then it would
> read more like:
> 
> 	.. returns:: Number of pages, except when the moon is full
> 
> ...which would still probably not be entirely popular.

I certainly see the value in consistency throughout our documentation.
But I don't think it's a given that the documentation of the return
value is necessarily its own section.  I see kernel-doc as being more
about semantic markup and the rst files as being a presentation markup.

So I'm fine with Return:: introducing a list or Example:: introducing
a code section; these are special purpose keywords.  I'm not a fan of
using raw rst in kernel-doc.  Of course if we can make the kernel-doc
and rst languages the same for the same concepts, that's great.
