Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F350468467
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfGOHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 03:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfGOHdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:33:02 -0400
Received: from localhost (static-196-86-100-159.thenetworkfactory.nl [159.100.86.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F7320C01;
        Mon, 15 Jul 2019 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563175981;
        bh=pXcv8tRUETD+IGFrx0NoHmet3NVSSX2OulI145NiVbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T775CSKhugQSJdgtzc0fNNnFjjTlDJ9MBAgyArR1A29UB6BzKOzP6IYnXWmMEbK2Q
         3fWHZBOnjk+OEKI1A9usQTKC++h8totqXmsPc6ulG0lFxSehtZ/PY64TxR0ZB0RQRF
         T9KswzmSaWwL/EKb2FCUoP1xljPz3efsDb6RDHyg=
Date:   Mon, 15 Jul 2019 09:32:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [v4] staging: most: remove redundant print statement when
 kfifo_alloc fails
Message-ID: <20190715073257.GB2100@kroah.com>
References: <20190714150546.31836-1-iamkeyur96@gmail.com>
 <06fc2495-dda5-61d2-17e8-0c385e02da1e@web.de>
 <20190714154737.GB32464@keyur-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714154737.GB32464@keyur-pc>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 11:47:37AM -0400, Keyur Patel wrote:
> I didn't get you. I stiil need to update changelog and send more 
> version or not. If you say so, I can send one more.

Please note that the person/bot you are responding to is on in my email
blacklist, and many others, so I wouldn't worry too much about the
responses.

I'll review this patch once 5.3-rc1 is out as I can't do anything with
it during the merge window.

thanks,

greg k-h
