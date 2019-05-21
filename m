Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE922518F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfEUOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfEUOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE742173C;
        Tue, 21 May 2019 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447806;
        bh=gzdEhfVedqKQ0FCIkuxWhCCMI89FNeLAbYZkE8ccCFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZU/hID3dDaMhUGiAt62g1blSGcVOUmx3jcJAuYLw1kB4wEv0vuQpTbpQd4FyDVpw
         CKvGyYJ9BdY8RETE+S+21a1zdOXkuOoeLd19Vpxfl7AUIA8SYPT3rgxtxnX94NK9ky
         Z75+exQf1N35Z6mSQybM15tz1Okx68z52QkC43Uc=
Date:   Tue, 21 May 2019 16:10:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianzheng Li <ltz0302@gmail.com>
Cc:     rspringer@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, benchan@chromium.org,
        toddpoynor@google.com, linux-kernel@i4.cs.fau.de,
        zhangjie.cnde@gmail.com
Subject: Re: [PATCH] staging/gasket: Fix string split
Message-ID: <20190521141003.GA24684@kroah.com>
References: <20190521135012.24887-1-ltz0302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521135012.24887-1-ltz0302@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:50:12PM +0200, Tianzheng Li wrote:
> This patch removes unnecessary quoted string splits.
> Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
> Signed-off-by: Jie Zhang <zhangjie.cnde@gmail.com>

We need a blank line before the signed-off-by line.

Care to fix this up and resend?

thanks,

greg k-h
