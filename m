Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC853C3E24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfJARFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:05:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:38270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfJARFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:05:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7E393491;
        Tue,  1 Oct 2019 17:05:50 +0000 (UTC)
Date:   Tue, 1 Oct 2019 11:05:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <20191001110549.4b497f32@lwn.net>
In-Reply-To: <201910010913.2BAAC8A@keescook>
References: <20190924230208.12414-1-keescook@chromium.org>
        <20191001083147.3a1b513f@lwn.net>
        <20191001120930.5d388839@coco.lan>
        <201910010913.2BAAC8A@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 09:16:41 -0700
Kees Cook <keescook@chromium.org> wrote:

> > > This almost certainly has to do with the fact that I'm (intentionally)
> > > running the Python2 Sphinx build here.  Something's not doing unicode that
> > > should be.  
> 
> Given this would be for v5.5, and python2 is EOL in 2 months[1], I don't
> think it's unreasonable to deprecate it. Especially considering there
> are already explicit "python3" shebangs in existing code in the sphinx/
> directory.

Two months and 30 days, don't exaggerate, man! :)

FWIW, the "shebangs" in that directory are no-ops.  Those are extensions
read into sphinx, not standalone programs; they go into a Python 2 sphinx
instance just fine.

Which isn't an argument against dropping Python 2, of course.  That's
really just a matter of when.

> > I'm almost sure we got this already. If I'm not mistaken, the solution
> > is to add the encoding line after shebang. Looking at 
> > Documentation/sphinx/maintainers_include.py (patch 2/2), the script
> > starts with:
> > 
> > 	#!/usr/bin/env python
> > 	# SPDX-License-Identifier: GPL-2.0
> > 	# -*- coding: utf-8; mode: python -*-
> > 	# pylint: disable=R0903, C0330, R0914, R0912, E0401
> > 
> > But, as I pointed before, the SPDX header at the wrong place is causing the 
> > crash, as the encoding line should be the second line, not the third one,
> > e. g.:
> > 
> > 	#!/usr/bin/env python
> > 	# -*- coding: utf-8; mode: python -*-
> > 	# SPDX-License-Identifier: GPL-2.0
> > 	# pylint: disable=R0903, C0330, R0914, R0912, E0401
> > 
> > I also suspect that this would happen even with python3, depending on
> > how LC_ALL, LANG, ... are set on the distro you use.  
> 
> Oh that's a delightful bug. :P I haven't been able to reproduce this
> failure (maybe all my LANG junk is accidentally correct)?

Delightful - and wrong; moving that line around doesn't change anything.
The crash comes from deep within sphinx; the more I look at it the more
confused I get.  Stay tuned...

jon
