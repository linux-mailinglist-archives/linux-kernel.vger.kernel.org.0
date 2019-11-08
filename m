Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3067DF50F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKHQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfKHQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:22:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91B07B353;
        Fri,  8 Nov 2019 16:22:20 +0000 (UTC)
Message-ID: <1573230479.5838.7.camel@suse.cz>
Subject: Re: [PATCH] checkpatch: remove "ipc" from list of expected toplevel
 directories
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Nov 2019 17:27:59 +0100
In-Reply-To: <20191108160428.9632-1-ggherdovich@suse.cz>
References: <20191108160428.9632-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 17:04 +0100, Giovanni Gherdovich wrote:
> checkpatch.pl uses a list of expected directory names to understand if it's
> being run from the top of a kernel tree. Commit 76128326f97c ("toplevel:
> Move ipc/ to kernel/ipc/: move the files") removed a toplevel directory, so
> checkpatch.pl need to update its list.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6fcc66afb088..93b8fd1eea57 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1099,7 +1099,7 @@ sub top_of_kernel_tree {
>  	my @tree_check = (
>  		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
>  		"README", "Documentation", "arch", "include", "drivers",
> -		"fs", "init", "ipc", "kernel", "lib", "scripts",
> +		"fs", "init", "kernel", "lib", "scripts",
>  	);
>  
>  	foreach my $check (@tree_check) {

Nope, this was already fixed by Yunfeng Ye with
https://lore.kernel.org/lkml/bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com/
plus the ipc/ directory is now back in its place.

Sorry for the noise,
Giovanni
