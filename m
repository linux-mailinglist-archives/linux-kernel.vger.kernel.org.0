Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC09A216
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393343AbfHVVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbfHVVSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:18:48 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343D8233FC;
        Thu, 22 Aug 2019 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566508728;
        bh=e7wF8XByrqivOz+Mbfv1EaeOlb7dr+fT7iqoMgG6VLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogckbnXJ9mcQ86e8TXy5jK6VTFYZ3tyenmASlD/dFBRv73+fMYWWOlS4eP0k+aYXu
         6oqQ8n0reUPptt97CTiSiwZ+3FB2ewUjlJVqw1d31k4HcUSRhAWBuk/LFor8n68sml
         gaP8Y1Vv2yESRw5Y9OCJBH2gpAQtWs4s3v+PjAfM=
Date:   Thu, 22 Aug 2019 14:18:47 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org,
        Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCHv4] tty: n_gsm: add ioctl to map serial device to mux'ed
 tty
Message-ID: <20190822211847.GA3287@kroah.com>
References: <20190812211243.98686-1-martin@geanix.com>
 <a67bba41-a92a-1b8f-c8f8-25efe3687695@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a67bba41-a92a-1b8f-c8f8-25efe3687695@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 09:28:07PM +0200, Martin Hundebøll wrote:
> Hi Greg,
> 
> Just a friendly "ping" on this patch.

Sorry for the delay, given that no one else has objected to it, I'll go
queue it up now.

thanks,

greg k-h
