Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2439BFD108
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 17:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfKNWkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:40:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E050F206E5;
        Thu, 14 Nov 2019 22:40:23 +0000 (UTC)
Date:   Thu, 14 Nov 2019 17:40:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] libtraceevent: fix header installation
Message-ID: <20191114174022.62c8259e@gandalf.local.home>
In-Reply-To: <20191114133719.309-1-sudipm.mukherjee@gmail.com>
References: <20191114133719.309-1-sudipm.mukherjee@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo,

Can you take this?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Thu, 14 Nov 2019 13:37:19 +0000
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> When we passed some location in DESTDIR, install_headers called
> do_install with DESTDIR as part of the second argument. But do_install
> is again using '$(DESTDIR_SQ)$2', so as a result the headers were
> installed in a location $DESTDIR/$DESTDIR. In my testing I passed
> DESTDIR=/home/sudip/test and the headers were installed in:
> /home/sudip/test/home/sudip/test/usr/include/traceevent.
> Lets remove DESTDIR from the second argument of do_install so that the
> headers are installed in the correct location.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> Hi Steve,
> sent this earlier as an attachment to an email thread, not sure if you
> saw it, so sending it now properly.
> The other problem with the pkgconfig, I guess we can live with that for
> now as that folder is given by pc_path.
> 
>  tools/lib/traceevent/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> index 5315f3787f8d..cbb429f55062 100644
> --- a/tools/lib/traceevent/Makefile
> +++ b/tools/lib/traceevent/Makefile
> @@ -232,10 +232,10 @@ install_pkgconfig:
>  
>  install_headers:
>  	$(call QUIET_INSTALL, headers) \
> -		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
> -		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
> -		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
> -		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
> +		$(call do_install,event-parse.h,$(includedir_SQ),644); \
> +		$(call do_install,event-utils.h,$(includedir_SQ),644); \
> +		$(call do_install,trace-seq.h,$(includedir_SQ),644); \
> +		$(call do_install,kbuffer.h,$(includedir_SQ),644)
>  
>  install: install_lib
>  

