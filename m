Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1074611D01F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfLLOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 09:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbfLLOpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:45:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FE521655;
        Thu, 12 Dec 2019 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576161901;
        bh=NAwMf3cjvdX5Di0bvRBolsXdWtk+PjPn2VPtYeOUmLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+w/s12W2DMLxoBQUjb1SCe9HqFlW7MdlIe99OOSJZm0Yq24fhuUKZZ/PnpD3S7ca
         r/eUteeLUgSzIYX3J1fB4mo/KpPTk9DytudyTrXBiKVUNlmLZKlKqEM5iRbIINvQDV
         G4b5im20mKr4UF78qZEHmtNCrroHHk+KXXGGtE9g=
Date:   Thu, 12 Dec 2019 15:44:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, bbrezillon@kernel.org, wsa@the-dreams.de,
        arnd@arndb.de, broonie@kernel.org
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20191212144459.GB1668196@kroah.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:37:33PM +0100, Vitor Soares wrote:
> +static int __init i3cdev_init(void)
> +{
> +	int res;
> +
> +	pr_info("i3c /dev entries driver\n");

Please remove debugging information, kernel code should be quiet unless
something goes wrong.

> +	/* Dynamically request unused major number */
> +	res = alloc_chrdev_region(&i3cdev_number, 0, N_I3C_MINORS, "i3c");

Do you really need a whole major, or will a few minors work?

thanks,

greg k-h
