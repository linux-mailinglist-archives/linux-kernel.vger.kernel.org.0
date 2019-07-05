Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E225602D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfGEJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 05:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfGEJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:04:33 -0400
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E51218C5;
        Fri,  5 Jul 2019 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562317472;
        bh=VQbkOn7IFuvTzmG2wEcraG9t0ivU+flYsDDf5txco0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2vgdcD1xE0NEdTC7ImGhLkeVwGZbKhLqdMC7aUXUuQfEo3J/FmSq5/zy8TWO4m6h
         l2TSf59Mjzs9RjEcClaIIp0nxtR3PGx5E6sQJTvOTh4T0pUjsSoT5fHdYuilQQYpZw
         wtyBLhlESTIZ31TlrG0p0718GYWegFB/f4MfOePE=
Date:   Fri, 5 Jul 2019 11:04:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190705090422.GA32289@kroah.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705083349.44047-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 4 deletions(-)

What changed from the previous versions?

Always put that below the --- line.

Please fix up and send a v4 with that information.

thanks,

greg k-h
