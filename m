Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0575F88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfGZHQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:16:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8B521852;
        Fri, 26 Jul 2019 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564125362;
        bh=zJWJBjkRpcLJu+URN3e9D3pBiEBb1jjOl6ikK2TAeGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3pIMDcpOMcXWIL1OzO19BJu1NcKbbSZ85bfX8RThqQJaDkq/xkGBBfnsoPenarFI
         0LnqXoLp/D7c1LF3NQN1t/mO1YyDNBtnvxd1zUMCuQUVe5LVdaUVPDBvQr3SNdivtZ
         EM9AWb2nGSBGRz7pH7jFQEVkWmXoYcGz3aZnwhTE=
Date:   Fri, 26 Jul 2019 09:16:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190726071600.GA12610@kroah.com>
References: <20190726024046.5873-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726024046.5873-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:40:46AM +0800, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>

You messed up the From: and signed-off-by: lines this time :(

v4 had it "correct", please fix up and send v6.

thanks,

greg k-h
