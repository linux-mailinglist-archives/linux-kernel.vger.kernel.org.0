Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097171051D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKULwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfKULwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:52:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E983F2089D;
        Thu, 21 Nov 2019 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337155;
        bh=9dV5S4yll5QlivhlsmfXP6fOtjF+LPAskIKlZvCsV7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wf+ZC3WAf5rDweKlimM3XCkS3Bq03Fk8YrQcr2NKyqGMkQhOWWN03SLMOo3flq/RP
         RPAr6fOWDl4o72+Rw0NOGUDEP6uUTS+A3N0KuBTdNl0AB6jGp0iDlslHe4FlftpIfH
         NLLzOiz7w2Gk5qPyRbh+EZQrBzwlIFDS53AkJ6dc=
Date:   Thu, 21 Nov 2019 12:52:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191121115232.GC427938@kroah.com>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:20:21PM +0900, Kusanagi Kouichi wrote:
> If DEBUG_FS=n, compile fails with the following error:
> 
> kernel/trace/trace.c: In function 'tracing_init_dentry':
> kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  8658 |         trace_automount, NULL);
>       |         ^~~~~~~~~~~~~~~
>       |         |
>       |         struct vfsmount * (*)(struct dentry *, void *)
> In file included from kernel/trace/trace.c:24:
> ./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
>   206 |      struct vfsmount *(*f)(void *),
>       |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> ---
>  include/linux/debugfs.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Has this always been a problem, or did it just show up due to some other
kernel change?

thanks,

greg k-h
