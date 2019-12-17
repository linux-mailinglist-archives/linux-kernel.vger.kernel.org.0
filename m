Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29E1122D09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfLQNih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 08:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:38:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B438206B7;
        Tue, 17 Dec 2019 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589916;
        bh=WNkZjk1VwTkTHxwnzJkDUEB6bsaYihg2Y7a0M0jOK4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msUUD7HueBw95SrCbB87rW0kDcbGTENGbMoeUf+/mz0pWLlbYeLv9cFyTQXFBrfzz
         nrT+9FAdYE+y57dxUgyR/cJLCGVmVCtehaAixnKF4ut3YTnYJO5DruJTfLABSfCIFi
         GEpHMBsXcYVBTZSoaShKDlX03xA64/Ma99j+F6nA=
Date:   Tue, 17 Dec 2019 14:38:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217133834.GE3362771@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217132244.14768-2-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:22:44PM +0000, Dave Kim wrote:
> +/**
> + * PCI device ID table.  We use the driver_data field to hold an index into
> + * nfp_drvlist, so bear than in mind when editing either.
> + */
> +static struct pci_device_id nfp_pci_tbl[] = {
> +	{
> +		PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_21555,
> +		PCI_VENDOR_ID_NCIPHER, PCI_SUBSYSTEM_ID_NFAST_REV1, 0,
> +		0, /* Ignore class */
> +		0 /* Index into nfp_drvlist */

Please use the correct PCI_DEVICE() macros, that should work here,
right?

And you are grabbing an Intel PCI device id?

> +	},
> +	{
> +		PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_FREESCALE_T1022,
> +		PCI_VENDOR_ID_NCIPHER, PCI_SUBSYSTEM_ID_NFAST_REV1, 0,
> +		0, /* Ignore class */
> +		1 /* Index into nfp_drvlist */

Again, PCI_DEVICE() macros please.

And kerneldoc everywhere, your commenting format for all of the code is
a bit "odd".

thanks,

greg k-h
