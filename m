Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCF156FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 08:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJHQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 02:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgBJHQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:16:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8072820838;
        Mon, 10 Feb 2020 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581319012;
        bh=/6cxKBThRZTqraEt22L56fCJKgcPzcS1pcT8+oik2+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkmMpaSM1ksPOMAwYdsOtRHTXSI4dy4cCI/OgvQZSt/EsiDkhuwdnwDBA6uB/3aZl
         TcAX4y1zFnOYKFIvKCx+5C852zBtOveiwEqnnI1X+5clK1OIHPGLmdmiZObu95A+Lt
         njiQ8aLlbjnaYBGUUBERzAFAFL5Ip/cEcZsF3DPQ=
Date:   Mon, 10 Feb 2020 16:16:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation: bootconfig: fix Sphinx block warning
Message-Id: <20200210161647.416ce0dcd0710f4349a665b1@kernel.org>
In-Reply-To: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
References: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2020 19:53:17 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx format warning:
> 
> lnx-56-rc1/Documentation/admin-guide/bootconfig.rst:26: WARNING: Literal block expected; none found.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for the fix!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-56-rc1.orig/Documentation/admin-guide/bootconfig.rst
> +++ lnx-56-rc1/Documentation/admin-guide/bootconfig.rst
> @@ -23,7 +23,7 @@ of dot-connected-words, and key and valu
>  has to be terminated by semi-colon (``;``) or newline (``\n``).
>  For array value, array entries are separated by comma (``,``). ::
>  
> -KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
>  
>  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
