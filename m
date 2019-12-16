Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342CE1200A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLPJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 04:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLPJNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:13:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8E8207FF;
        Mon, 16 Dec 2019 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576487614;
        bh=cgHM6DQAmErnkkVt7OBcXZu3FlYGXPlMp7gPv2Cv7Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkFDo1N4BBIRfy0hdsT9UtcNmFs0mM8qPONCVseTjC8+IGqpKrYVttb30MExvlXRw
         aGkn1StenW2puws/d7ZECFjSzooA5BCQZXfyecv3kOrc33KWBBaQjYr2aNJAsWLB+6
         KWWV1gGMhzO4EprautC845H4GYhJg7yffMLATqwE=
Date:   Mon, 16 Dec 2019 10:13:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.5-rc2/3
Message-ID: <20191216091332.GA1164705@kroah.com>
References: <20191214133154.GA8663@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214133154.GA8663@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 03:31:54PM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.5-rc2/3.
> It contains two minor fixes, nothing too exciting.
> 
> Thanks,
> Oded
> 
> The following changes since commit 16981742717b04644a41052570fb502682a315d2:
> 
>   binder: fix incorrect calculation for num_valid (2019-12-14 09:10:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-12-14

Pulled and pushed out,t hanks.

greg k-h
