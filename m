Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EDF12E590
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgABLQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 06:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgABLQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:16:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AD4217F4;
        Thu,  2 Jan 2020 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577963778;
        bh=VbXY3qciAWXla757PU4VUF9Vb8tPuOTZaUsueB87sq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxCgx9BasLnhNWy2cLieg3itEyZ78R6nd4nR8J4VlSRjOGh1MBAi6stdvsbFHJxOj
         PFD/Nr0S92r1om0zDbsrxW2kTdexdPiZUadPsrDMmWN/VasxTJP1+9HOraaUq/ywvj
         f6KX9HR/gE/ExOhqsjMkABI1ZY2AYfR9kLUb+2/Q=
Date:   Thu, 2 Jan 2020 12:16:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrita Patole <longlivelinux@yahoo.com>
Cc:     madhumithabiw@gmail.com, bhanusreemahesh@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed coding style with minor changes. Signed-off-by:
 Amrita Patole <amritapatole@gmail.com>
Message-ID: <20200102111616.GA3961630@kroah.com>
References: <20200102105718.5669-1-longlivelinux.ref@yahoo.com>
 <20200102105718.5669-1-longlivelinux@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102105718.5669-1-longlivelinux@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:27:18PM +0530, Amrita Patole wrote:
> ---
>  drivers/staging/fwserial/fwserial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Something went wrong with your subject line :(

