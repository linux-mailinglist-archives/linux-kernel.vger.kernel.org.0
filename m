Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0150DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfFXO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 10:29:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:43898 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfFXO3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:29:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C180D537;
        Mon, 24 Jun 2019 14:29:51 +0000 (UTC)
Date:   Mon, 24 Jun 2019 08:29:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190624082950.5e338d37@lwn.net>
In-Reply-To: <20190622144610.26b7d99c@coco.lan>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
        <20190621220046.3de30d9d@coco.lan>
        <20190622084346.28c7c748@lwn.net>
        <20190622144610.26b7d99c@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019 14:46:10 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > > .. c:function:: int ioctl( int fd, int request, void *argp )
> > >     :name: v4l2-ioctl    
> > 
> > Some digging around didn't turn up any documentation for :name:, but it
> > seems to prevent ioctl() from going into the list of functions that can be
> > cross-referenced.   
> 
> It took me a while to discover this way to be able to re-define the
> name of a symbol at the C domain, but I'm pretty sure I read this
> somewhere at the Sphinx docs (or perhaps on some bug track or Stack
> Overflow).
> 
> I don't remember exactly where I get it, but I guess it is related to
> this:
> 
> 	http://docutils.sourceforge.net/docs/howto/rst-roles.html
> 
> > I wonder if the same should be done for the others?  
> 
> Sure.

It actually occurs to me that it might be better to keep the skip list and
maybe expand it.  There are vast numbers of places where people write
open() or whatever(), and there is no point in even trying to
cross-reference them.  I should do some tests, it might even make a
measurable difference in the build time to skip them :)  And in any case,
somebody is bound to put one of those common names into the namespace in
the future, recreating the current problem.

jon
