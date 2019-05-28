Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07282BF91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfE1Gtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 02:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1Gtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:49:52 -0400
Received: from localhost (unknown [77.241.229.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992552070D;
        Tue, 28 May 2019 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559026192;
        bh=w8wEyswIoAanFRoTC6ZEDsAAUBLLUnBhh9Z4d5GQpX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMBmOVGH7ifB0y0fPJxFk1t08VJn9LvzJkLyKYFrE2+8a4a5OxzcmHHQhd2/KzL3N
         KfzEIPE8kM+00dYlJlZa8B49O0r8KN0Jjl3l0SZYYberERwIzi9tUNBaadkcL2Ue9W
         PGhO3TQP1MxJ0SVPxmiXR3NlnzXP51+8/SE/WAUs=
Date:   Tue, 28 May 2019 08:49:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question: devm_kfree] When should devm_kfree() be used?
Message-ID: <20190528064949.GC2428@kroah.com>
References: <20190528003257.GA12065@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528003257.GA12065@zhanggen-UX430UQ>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:32:57AM +0800, Gen Zhang wrote:
> devm_kmalloc() is used to allocate memory for a driver dev. Comments
> above the definition and doc 
> (https://www.kernel.org/doc/Documentation/driver-model/devres.txt) all
> imply that allocated the memory is automatically freed on driver attach,
> no matter allocation fail or not. However, I examined the code, and
> there are many sites that devm_kfree() is used to free devm_kmalloc().
> e.g. hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c.
> So I am totally confused about this issue. Can anybody give me some
> guidance? When should we use devm_kfree()?

If you "know" you need to free the memory now, call devm_kfree().  If
you want to wait for it to be cleaned up latter, like normal, then do
not call it.

Do you have a driver that you think uses it incorrectly?

thanks,

greg k-h
