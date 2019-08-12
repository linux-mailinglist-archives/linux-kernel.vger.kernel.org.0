Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF48A190
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHLOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfHLOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:52:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5E220679;
        Mon, 12 Aug 2019 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565621576;
        bh=2wzdlxz5QeUQ6p2p2n3PHhu14Nyn6vlOaWHj9KrxieU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/5PURFmQRx2E7l4tQS90a6mwykXP3K9msbqEmc+8PqMeP+eF+tlu4vcyP2ZD33iA
         rJ3yDmkw2dWulC0hvEteYfchdSX0fLG5XnH13+fjxRi3bZXZmQvXlMK7iX1LPqhwzn
         jeUfD/QjiHKcYBjJI9t3t7Z1NmTV2Za31sjKxVnM=
Date:   Mon, 12 Aug 2019 16:52:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.3-rc5
Message-ID: <20190812145254.GB22363@kroah.com>
References: <20190812061925.GA19050@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812061925.GA19050@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:19:25AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.3-rc5. It is a bit larger than
> what I would like at this stage but it contains four very important fixes
> when running on s390 architecture. With these fixes the driver has been
> validated as fully functional on s390 (which is BE).
> 

Ah, I always forget s390 is BE.  I also didn't realize that s390 took
PCIE cards.  Learned something new today...

Now all merged, thanks.

greg k-h
