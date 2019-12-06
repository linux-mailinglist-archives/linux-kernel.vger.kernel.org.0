Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB5115094
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 07:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfLFMrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:47:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC8521835;
        Fri,  6 Dec 2019 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575636430;
        bh=og6KKe2K7dAFnSp325n/4O+Bt50cX/53Q+uN3903lDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7g5njdjGl+Prucau4q/Ic/m0l3VSaQp+6xQqxkilP7wmt3GG3idFy3hb3CjeJNMk
         Yq/GiVylp+lofW6vi+ek5oi0H6bIphA0irWdWI1C6iHAxrjZ/WSeKaq7AkR4pBBV2w
         TIe7ZVkrkM4g1a8VnfBcjSKnxgbCpNh+jaGOS/zg=
Date:   Fri, 6 Dec 2019 13:47:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/6] Documentation/ABI: add ABI documentation for
 /sys/kernel/fadump_*
Message-ID: <20191206124707.GC1360047@kroah.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206122434.29587-2-sourabhjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:54:29PM +0530, Sourabh Jain wrote:
> Add missing ABI documentation for existing FADump sysfs files.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-fadump_enabled     | 7 +++++++
>  Documentation/ABI/testing/sysfs-kernel-fadump_registered  | 8 ++++++++
>  Documentation/ABI/testing/sysfs-kernel-fadump_release_mem | 8 ++++++++
>  .../ABI/testing/sysfs-kernel-fadump_release_opalcore      | 7 +++++++
>  4 files changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_enabled
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_registered
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_enabled b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
> new file mode 100644
> index 000000000000..f73632b1c006
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
> @@ -0,0 +1,7 @@
> +What:		/sys/kernel/fadump_enabled

Ugh, no wonder no one wanted to document these, that would have been
noticed right away :(

greg k-h
