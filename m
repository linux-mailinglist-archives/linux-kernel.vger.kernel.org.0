Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224B75B6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfGAIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 04:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfGAIlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:41:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638D620881;
        Mon,  1 Jul 2019 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561970490;
        bh=X9qC6JvprazpQj5bEN/NbXMtwRJ3QeHdrwnmEsreX5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avYhySKzVMYW2U++1T6pNY8C/CL2joBJz3nfLC3kdnkCYpDvaPoVi52/26J+5OS8g
         mJk+If8jemvz5EYgp2rFE/oP2CIHNiRFzgLt11FDZWe9le76a7P000XsM2TNO0yJQl
         /Zt6zos3tAeyXs64DhDBRqAUSzrph4JB4/e45Rok=
Date:   Mon, 1 Jul 2019 10:41:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabian Krueger <fabian.krueger@fau.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: kpc2000: add line breaks
Message-ID: <20190701084127.GA20457@kroah.com>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
 <20190626073531.8946-2-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626073531.8946-2-fabian.krueger@fau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:35:19AM +0200, Fabian Krueger wrote:
> To fix some checkpatch-warnings some lines of this module had to be
> shortened so that they do not exceed 80 characters per line.
> This refactoring makes the code more readable.
> 
> Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
> Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
> Cc: <linux-kernel@i4.cs.fau.de>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 34 +++++++++++++++++----------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Not all of these patches applied to my tree.  Please be sure to always
work against linux-next in order to create things that can actually be
applied.

thanks,

greg k-h
