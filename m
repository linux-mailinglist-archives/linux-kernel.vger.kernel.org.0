Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD31195B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgC0QuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0QuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XntsRbiWBGPoRBEzR9SIe4lR6YMOOA/pTvrAdkFuPYM=; b=otTDggF52jMPdIOE5nj5rTyk/X
        Fd2fjDfsOsiR8SLNVLIocclangmK0Qgy138mURh5YZHGqCUULis9Fvx1+1gvpkV1xZ212W7xEVxfF
        8P3RVvSmd4QH4X5lQuvfFX+hAZ03/6qTtspWzvryWK4R9ER7U2bjDYWu6hTJCm6f9aLYZOCNuJuoL
        uT/Rdk9hVEYcOw5aQ+gMOnf8XyZ/1v8gbEpvq9bqJCEr6wXunrFsFIYq0HLwLRu0LAWKjx6u4LnEN
        y4rZ3NUIRip5fIoE/+GZ+p6bJJB8GxqW7mOroyv8B2GtIFHGUFTBV8y/DYKDU1eSRVeMtEv6VMVEE
        yl6qQdkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsBa-0003vl-Kh; Fri, 27 Mar 2020 16:50:22 +0000
Date:   Fri, 27 Mar 2020 09:50:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        peter@bikeshed.quignogs.org.uk, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
Message-ID: <20200327165022.GP22483@bombadil.infradead.org>
References: <20200326192947.GM22483@bombadil.infradead.org>
 <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
 <87imiqghop.fsf@intel.com>
 <20200327104126.667b5d5b@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327104126.667b5d5b@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:41:26AM -0600, Jonathan Corbet wrote:
> On Fri, 27 Mar 2020 13:28:54 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> > IMHO the real problem is kernel-doc doing too much preprocessing on the
> > input, preventing us from doing what would be the sensible thing in
> > rst. The more we try to fix the problem by adding more kernel-doc
> > processing, the further we dig ourselves into this hole.
> > 
> > If kernel-doc didn't have its own notion of section headers, such as
> > "example:", we wouldn't have this problem to begin with. We could just
> > use the usual rst construct; "example::" followed by an indented block.
> > 
> > I'm not going to stand in the way of the patch, but I'm telling you,
> > this is going to get harder, not easier, on this path.
> 
> I agree with you in principle.  The problem, of course, is that this is a
> legacy gift from before the RST days and it will be hard to change.
> 
> A quick grep shows that the pattern:
> 
> 	* Example:
> 
> appears nearly 100 times in current kernels.  It is not inconceivable to
> make a push to get rid of all of those, turning them into ordinary RST
> syntax - especially since not all of those are actually kerneldoc
> comments.
> 
> The same quick grep says that "returns?:" appears about 10,000 times.
> *That* will be painful to change, and I can only imagine that some
> resistance would have to be overcome at some point.
> 
> So what do folks think we should do? :)

Let me just check I understand Jani's proposal here.  You want to change

* Return: Number of pages, or negative errno on failure

to

* Return
* ~~~~~~
* Number of pages, or negative errno on failure

If so, I oppose such an increase in verbosity and I think most others
would too.  If not, please let me know what you're actually proposing ;-)

