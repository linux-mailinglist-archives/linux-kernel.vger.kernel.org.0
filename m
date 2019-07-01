Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30501F042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfEOLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbfEOLmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:42:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E642053B;
        Wed, 15 May 2019 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920526;
        bh=CJglLWpl75ZYj9k7YBK3dEW3AsldyHrTYFhuxMMNwbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxyVJ60wBaB/9nci8DZDtaxj9O8RMS1fA/MALjXQQOwVdpFmE58SeyqzfTO180JW/
         rsp7spefQKf5h15vj0xNDBKddxCf48TxaVMQYqZbhhQLYVYo3SlNCxT6qHRUxr7+Gs
         DGAR+c9H7gK9L8HyPmiP396d8CSaP1Gj31gwyfoE=
Date:   Wed, 15 May 2019 13:40:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
Message-ID: <20190515114022.GA18824@kroah.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515112401.15373-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
> The rtl8821ce can be found on many HP and Lenovo laptops.
> Users have been using out-of-tree module for a while,
> 
> The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
> later.

Where is that driver, and why is it going to take so long to get merged?

>  296 files changed, 206166 insertions(+)

Ugh, why do we keep having to add the whole mess for every single one of
these devices?

Why can't we just have a real driver now?

thanks,

greg k-h
