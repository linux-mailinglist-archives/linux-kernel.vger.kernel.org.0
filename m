Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A2105A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEAGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 02:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAGxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:53:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845D82081C;
        Wed,  1 May 2019 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556693596;
        bh=PduymaNULleI3+rM/Kqu6TZyeDN3bnvLgbkS1YjZ5uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahachlGdeHlkWbny9eJPH2gNA/wJctMWyYiTY/uZ1ZIFisO0I4tb5EHU4VrSURglf
         oVNXaEiCVqOHB3QlJ7p4Oyvi48dAoXXg/PZ6oeVSz2NTkV7LJVXEJJFa2O4cdXFTOU
         ibJj1g4BJMkMwskrZGIdk53izOCoTCSoghnpoUzk=
Date:   Wed, 1 May 2019 08:53:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     rafael@kernel.org, sramana@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drivers: core: Remove glue dirs early only when
 refcount is 1
Message-ID: <20190501065313.GA30616@kroah.com>
References: <1556632540-17382-1-git-send-email-prsood@codeaurora.org>
 <1556684567-26710-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556684567-26710-1-git-send-email-prsood@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:52:47AM +0530, Prateek Sood wrote:
> While loading firmware blobs parallely in different threads, it is possible
> to free sysfs node of glue_dirs in device_del() from a thread while another
> thread is trying to add subdir from device_add() in glue_dirs sysfs node.
> 
>     CPU1                                           CPU2
> fw_load_sysfs_fallback()
>   device_add()
>     get_device_parent()
>       class_dir_create_and_add()
>         kobject_add_internal()
>           create_dir() // glue_dir
> 
>                                            fw_load_sysfs_fallback()
>                                              device_add()
>                                                get_device_parent()
>                                                  kobject_get() //glue_dir
> 
>   device_del()
>     cleanup_glue_dir()
>       kobject_del()
> 
>                                                kobject_add()
>                                                  kobject_add_internal()
>                                                    create_dir() // in glue_dir
>                                                      kernfs_create_dir_ns()
> 
>        sysfs_remove_dir() //glue_dir->sd=NULL
>        sysfs_put() // free glue_dir->sd
> 
>                                                        kernfs_new_node()
>                                                          kernfs_get(glue_dir)
> 
> Fix this race by making sure that kernfs_node for glue_dir is released only
> when refcount for glue_dir kobj is 1.
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>  drivers/base/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

What changed from v1?  That always has to go below the --- line.

v3 please.
