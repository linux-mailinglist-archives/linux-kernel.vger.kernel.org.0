Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A0C8FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfJBRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:24:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+MLBofc4j9osl2yU3VJpS38KKBod3J16m+z6vlWoOKA=; b=jvJPgcEcMJjE7yiZmjiveLggJ
        owTCmfyjq8tommOTzuIFpBzmDBkz/xz9P2cMGIiZs6TSy8v70mSvHaUBApDQc7bcb0xWUlia1SFzY
        BweSqEPKhwhow2//jdTnStg2Agww+zAtB753OW4JMbCl/zWxGSkjvOCY4KFGmR7rEn2wsaaRc0xWZ
        v6sC1t8bqlCltMXps80jFXsU2CdkoLfdmdlxn5Z79x3T01PrmKqfUnXEzBRA3H8d293J84/6aFfhn
        LGBz9aWpAQ073pYQ19dg57IQjqP4yEdlgYHzNTn3tSeyOiHriBzR1XkeS+FG3RV1TQN6rvVxhUHeu
        djP/5gu1Q==;
Received: from 177.133.68.49.dynamic.adsl.gvt.net.br ([177.133.68.49] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFiML-00029Q-9h; Wed, 02 Oct 2019 17:24:17 +0000
Date:   Wed, 2 Oct 2019 14:24:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: Programmatically render MAINTAINERS into
 ReST
Message-ID: <20191002142413.09a12266@coco.lan>
In-Reply-To: <20191002102535.1e518877@lwn.net>
References: <20191001182532.21538-1-keescook@chromium.org>
        <20191002102535.1e518877@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 2 Oct 2019 10:25:35 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue,  1 Oct 2019 11:25:30 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > v1: https://lore.kernel.org/lkml/20190924230208.12414-1-keescook@chromium.org
> > 
> > v2: fix python2 utf-8 issue thanks to Jonathan Corbet
> > 
> > 
> > Commit log from Patch 2 repeated here for cover letter:
> > 
> > In order to have the MAINTAINERS file visible in the rendered ReST
> > output, this makes some small changes to the existing MAINTAINERS file
> > to allow for better machine processing, and adds a new Sphinx directive
> > "maintainers-include" to perform the rendering.  
> 
> OK, I've applied this.  Some notes, none of which really require any
> action...
> 
> It adds a new warning:
> 
>   /stuff/k/git/kernel/MAINTAINERS:40416: WARNING: unknown document: ../misc-devices/xilinx_sdfec           
> 
> I wonder if it's worth checking to be sure that documents referenced in
> MAINTAINERS actually exist.  OTOH, things as they are generate a warning,
> which is what we want anyway.

We check already links that start with Documentation/ and :doc: via the
scripts/documentation-file-ref-check script. It shouldn't probably be hard
to check other files at MAINTAINERS, although some care should be taken
for this to not take too long.

Right now, the script is very fast here (SSD), doing all the checks on
less than one second.

> I did various experiments corrupting the MAINTAINERS file and got some
> fairly unphotogenic results.  Again, though, I'm not sure that adding a
> bunch of code to generate warnings is really worth the trouble.
> 
> The resulting HTML file is 3.4MB and definitely makes my browser sweat when
> loading it :)

In the future, the script could split the MAINTAINERS output into multiple
files, for example:

	maintainers.rst (with an index file)
	maintainers_a.rst	# entries that starts with A
	maintainers_b.rst	# entries that starts with B
	...
	maintainers_z.rst	# entries that starts with Z


> 
> It adds about 20 seconds to a full "make htmldocs" build, which takes just
> over 3 minutes on the system in question.  So a 10% overhead, essentially.

Python is slow. On my tests with ABI automation, I also noticed some
performance degradation, and did some measurements. Reading all the
ABI files was very fast (specially since there I opted to use Perl,
with is a lot faster than Python). It was equally fast to output the data
(I wrote .rst files at the Python extension during my tests). What really
took almost all of the time of the extension was the Sphinx's internal
logic that parses ReST, which makes sense.

I guess that the increase of time for "make *docs" targets is
unavoidable: more documentation input means that it will take more time
to produce an output.

I suspect that, if we split the MAINTAINERS into multiple rst files,
the script will speedup, as Sphinx could better use the existing CPUs
in order to split its workload.

> 
> All told, it does what it's expected to do.  Thanks for doing this.
> 
> jon



Thanks,
Mauro
