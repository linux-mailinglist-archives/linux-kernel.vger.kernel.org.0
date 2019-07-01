Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854A84832E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfFQMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFQMyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B73204EC;
        Mon, 17 Jun 2019 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560776081;
        bh=vjYiSvVQdR3JA3dPjhZJabq2wvGGMHTWiZ5C19FCbeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+V2FTnaE9McfD6PC9Ha2Yrarg+z2tNKy8h0c+cp6hWDrLLNkYYjL7AyUofCHeeH+
         TMYJCAnup3M0xU7xcW++aQQw1qGKJTpNvCQ6KUgOFat/c2aT7l+JWbBW/i/H/QWvqV
         zqDLdzUd73msDhX6AOKD5WL+RnnKBeOrZzfUfNEo=
Date:   Mon, 17 Jun 2019 14:54:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190617125438.GA18554@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
 <87o930uvur.fsf@intel.com>
 <20190614140603.GB7234@kroah.com>
 <20190614122755.1c7b4898@coco.lan>
 <874l4ov16m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l4ov16m.fsf@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:36:17PM +0300, Jani Nikula wrote:
> On Fri, 14 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Em Fri, 14 Jun 2019 16:06:03 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >
> >> On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:
> >> > 2) Have the python extension read the ABI files directly, without an
> >> >    extra pipeline.  
> >> 
> >> He who writes the script, get's to dictate the language of the script :)
> 
> The point is, it's an extension to a python based tool, written in perl,
> using pipes for communication, and losing any advantages of integrating
> with the tool it's extending.
> 
> I doubt you'd want to see system() to be used to subsequently extend the
> perl tool.
> 
> I think it's just sad to see the documentation system slowly drift
> further away from the ideals we had, and towards the old ways we worked
> so hard to fix.

What are those ideals?

I thought the goal was to be able to write documentation in a as much
as a normal text file as possible and have automation turn those files
into "pretty" documentation that we can all use.

And I think that fits with the way this patch set goes, right?  We are
not on a quest for purity of scripts to generate the documentation at
the expense of having to force hundreds, or thousands, of developers to
change their ways, or to force a "flag day" conversion of existing
documentation resulting in a huge merge mess.

So, we are stuck with the current structure that I totally made up for
Documentation/ABI/.  Turns out it is almost parsable, as Mauro's tool
shows.  His tool also validates the existing text, which is great, and
has caused fixes for it.

If someone wants to write that tool in some other language, like python,
wonderful, I have no objection, but as it is, this is a useful tool
already, allowing us to validate, and search, existing documentation
entries that we have never been able to do before.  It also provides an
output that can be turned into pretty html/pdf/whatever files by other
tools in the pipeline, a totally bonus benefit.

So what is going backwards here?

Maybe the processing pipeline isn't as nice as you would like, but
remember to view this from a normal developer's point of view, not a
documentation pipeline developer's point of view please.

So, in short, my requirements are:
	- keep Documentation/ABI/ file formats as close as possible to
	  what we have today, preventing any flag-day issues or merge
	  problems
	- be able to query and validate Documentation/ABI/
	- be able to turn Documentation/ABI into pretty documentation.

If you object to the mechanics of the last requirement here, I don't
object either, provide something else that works better.  But don't
throw away the whole thing just because you don't like how things are
hooked up here.

I'm going to go apply most of the rest of these patches to my
driver-core tree, stopping at the "hook it up to the kernel
documentation" point.  Is that ok?

thanks,

greg k-h
