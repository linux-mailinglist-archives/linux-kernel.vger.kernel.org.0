Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577352E8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE2XCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:02:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:43954 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2XCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:02:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8E952B4;
        Wed, 29 May 2019 23:02:03 +0000 (UTC)
Date:   Wed, 29 May 2019 17:02:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190529170202.65c7f9ca@lwn.net>
In-Reply-To: <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 08:07:40 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Since Sphinx version 1.7, it is possible to use "-jauto" in
> order to speedup documentation builds. On older versions,
> while -j was already supported, one would need to set the
> number of threads manually.
> 
> So, if SPHINXOPTS is not provided, add -jauto, in order to
> speed up the build. That makes it *a lot* times faster than
> without -j.
> 
> If one really wants to slow things down, it can just use:
> 
> 	make SPHINXOPTS=-j1 htmldocs
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 380e24053d6f..794233d05789 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -28,6 +28,8 @@ ifeq ($(HAVE_SPHINX),0)
>  
>  else # HAVE_SPHINX
>  
> +SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
> +

So this totally fails to work for me with any version of sphinx, and I'm
not enough of a Perl person to figure it out.  Sometimes I'll see the
sphinx-build output, i.e.:

    sphinx-build 1.8.4

and sometimes (like with 2.0) I don't, but I never get -jauto regardless.
Not sure what's going on here?

Thanks,

jon
