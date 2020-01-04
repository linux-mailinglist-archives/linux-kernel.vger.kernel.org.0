Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD413017D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgADIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 03:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgADIq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 03:46:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A277A222C4;
        Sat,  4 Jan 2020 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578127619;
        bh=5X3tciQat5bVeLfUv5zgi3ggJJ8ZS4+ZpZ10ftQnejs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVeBZfszLtbL1SrGl0FqryXGdOc3YWzreiQVMv0fK0jvETNtyLAhukYpYQTl09C7n
         a6qGEfuOQqblLEjoFLdDSLGJkX6HRcEvzxxYIG89uqCFFUxgrOEA1MsjSBYPS/kEbP
         kZzwNNV7E34FKIrsOo9pp8UnhBtVKgEomq+MiD14=
Date:   Sat, 4 Jan 2020 09:46:55 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Fw: usbcore missing parentheses in USE_NEW_SCHEME
Message-ID: <20200104084655.GA1248326@kroah.com>
References: <Pine.LNX.4.44L0.2001021018330.1546-100000@iolanthe.rowland.org>
 <SHQhnDsmKIpzyLJUY7lJlcdb9DLUPl8gGALB1h82ePlEPUQN9l5cHWxUWyqCcUaMRMGoq6dXRZA3e2gTvG4-HkJDxH994zTiHdeuaKJ6m-c=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHQhnDsmKIpzyLJUY7lJlcdb9DLUPl8gGALB1h82ePlEPUQN9l5cHWxUWyqCcUaMRMGoq6dXRZA3e2gTvG4-HkJDxH994zTiHdeuaKJ6m-c=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 03:24:04AM +0000, atmgnd wrote:
> Greg Kroah-Hartman:
> here is the new patch:
> 
> 
> >From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
> From: Qi.Zhou <atmgnd@outlook.com>
> Date: Wed, 1 Jan 2020 21:27:13 +0800
> Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME

Please send this as a stand-alone patch, the header here should not be
in the body of the email.

Also, I doubt your name has a "." in it, right?  :)

See the many many examples of patches on the mailing list for examples
of how this all should look, as well as read
Documentation/SubmittingPatches.

thanks,

greg k-h
