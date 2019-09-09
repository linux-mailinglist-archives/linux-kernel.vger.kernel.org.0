Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCCADCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfIIQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 12:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfIIQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:09:56 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACEA2082C;
        Mon,  9 Sep 2019 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568045395;
        bh=nslVTONxqFVxi0hsm1QBWjVFX7rQyENOoz3iPe0MrJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQhLj28ynCVjtUk0tgq/f7uRkVaUrRCE2ktCMkkabT4aXN2AqLG55U5QPUXwnykzf
         5lklwzfx9118WAg9tFzxer/+Dw8zXJs3ugMZoAPi/5EMFCVm8TniYug6ac1n9HjSGy
         2zWD1mC/GmW1wnfqxmBJzCYSp7JgQxPm8Kh05sXQ=
Date:   Mon, 9 Sep 2019 17:09:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        elder@kernel.org, johan@kernel.org
Subject: Re: [PATCH v2] staging: greybus: loopback_test: Adding missing
 brackets into if..else block
Message-ID: <20190909160952.GA9971@kroah.com>
References: <20190909143244.371-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909143244.371-1-jcfaracco@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:32:44PM +0000, Julio Faracco wrote:
> Inside a block of if..else conditional, else structure does not contain
> brackets. This is not following regular policies of kernel coding style.
> All parts of this conditional blocks should respect brackets inclusion.
> This commit removes some blank spaces that are not following brackets
> policies too.

Whenever you say "too" or "also" that's a huge hint that you should
break the patch up into multiple patches.

Please do that here, only do "one logical thing" per patch.

thanks,

greg k-h
