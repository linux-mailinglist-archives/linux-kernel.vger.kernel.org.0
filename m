Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215B013645C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 01:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgAJA1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 19:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbgAJA1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:27:15 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995BD2077C;
        Fri, 10 Jan 2020 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578616034;
        bh=iF6cKHHvaCJrFLsk2NPAolbXAhY80xnKk1DXl9W6AmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=By+3RcHJTihzsabdwfhzt0fSfb6Zc5q4XX+ALV4qrU/ArVluUUaaJ6ZgH6FLBzhLi
         EiwqW7TKtN3WXmpNsjw9dCQ4411eNiHMeLoCi07d16P8GIGg0ko74EGQ68EOj8kxtz
         2wEgi63R57CeeyEcYWDTLhlpNtP5tudfJlcMyA6s=
Date:   Thu, 9 Jan 2020 16:27:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2: remove unneeded header include path in
 fs/ocfs2/Makefile
Message-Id: <20200109162713.2054e05ff4545c30b0fa168f@linux-foundation.org>
In-Reply-To: <20200105070023.27806-1-masahiroy@kernel.org>
References: <20200105070023.27806-1-masahiroy@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 16:00:23 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> You can build fs/ocfs2 without this.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  fs/ocfs2/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ocfs2/Makefile b/fs/ocfs2/Makefile
> index cc9b32b9db7c..46381d9dd890 100644
> --- a/fs/ocfs2/Makefile
> +++ b/fs/ocfs2/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -I$(src)
>  
>  obj-$(CONFIG_OCFS2_FS) += 	\
>  	ocfs2.o			\

I get

fs/ocfs2/alloc.c:21:10: fatal error: cluster/masklog.h: No such file or directory
 #include <cluster/masklog.h>

