Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF23C3477
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfJAMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:39:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:36350 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:39:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A94F52CF;
        Tue,  1 Oct 2019 12:39:50 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:39:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <20191001063949.1b5e87dc@lwn.net>
In-Reply-To: <201909241627.CEA19509@keescook>
References: <201909241627.CEA19509@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 16:29:58 -0700
Kees Cook <keescook@chromium.org> wrote:

> While sphinx 1.7 and later supports "-jauto" for parallelism, this
> effectively ignores the "-j" flag used in the "make" invocation, which
> may cause confusion for build systems. Instead, extract the available
> parallelism from "make"'s job server (since it is not exposed in any
> special variables) and use that for the "sphinx-build" run. Now things
> work correctly for builds where -j is specified at the top-level:
> 
> 	make -j16 htmldocs
> 
> If -j is not specified, continue to fallback to "-jauto" if available.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I finally messed with this a bit; it seems to do exactly what's written on
the box.

It seems to me that The Real Solution™ here is to send a patch to the
Sphinx folks adding a "-jgmake" (or some such) option.  It also seems to
me that none of us is likely to get around to that in the near future.  So
I just applied this, thanks for dealing with all my picky comments...

jon
