Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314341167F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLIIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 03:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIIKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:10:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7C8205ED;
        Mon,  9 Dec 2019 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575879025;
        bh=iTTgNq9RENesPj9dq9RXmXWCptL56RAD7KSlfOxJCCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4PAq+1v4SGp/ZC4mYVV7bkWkkmkMeSJN+xHAOiJzVl2h/doEl1GKjIvH5q+6RYhq
         gMLOvR7IoUhVnPu8dES0A6xwdvMRlcUpogiTH7lyvohxD6WvV+UK1kZu1e5Q/qMsZJ
         T6v3PF7wMHVW2NSsTGCJpMFoQKJcGMMPH7delpuo=
Date:   Mon, 9 Dec 2019 09:10:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
Message-ID: <20191209081023.GC706232@kroah.com>
References: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
 <20191209045826.30076-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209045826.30076-4-sourabhjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:28:23AM +0530, Sourabh Jain wrote:
> +#define CREATE_SYMLINK(target, symlink_name) do {\
> +	rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, fadump_kobj, \
> +						  target, symlink_name); \
> +	if (rc) \
> +		pr_err("unable to create %s symlink (%d)", symlink_name, rc); \
> +} while (0)


No need for a macro, just spell it all out.  And properly clean up if an
error happens, you are just printing it out and moving on, which is
probably NOT what you want to do, right?

> +static struct attribute_group fadump_group = {
> +	.attrs = fadump_attrs,
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
