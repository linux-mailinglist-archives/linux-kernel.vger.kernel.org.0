Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8590EFAEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKMKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfKMKoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:44:44 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4F722459;
        Wed, 13 Nov 2019 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641882;
        bh=/NkcDZWOExrOpzbO57Ga6Z3v4XtktUzcRptRIXfdrr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdtT5MU5b3/MJtiVNqK7vr6wvLymC7utHCZrmHYW20gYcpgD/jSWN6ByYTgpuyD5h
         a6xMy1MrZSrS0RVXqKd+TYTYHa2tMusr+0m/uURWOVVSBA0wbSlwi6sAYqnXE/m1kE
         VVdYTAUKrc1VmOWTFsjVfikVcM6nXIvs5II1Lu7I=
Date:   Wed, 13 Nov 2019 11:44:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Javier F. Arias" <jarias.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: rtl8723bs: Remove unnecessary
 conditional block
Message-ID: <20191113104440.GB2068945@kroah.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
 <b870c2b43c12b7a4c98413735d9c7b1d4ff8e5c5.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b870c2b43c12b7a4c98413735d9c7b1d4ff8e5c5.1573605920.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:36:53PM -0500, Javier F. Arias wrote:
> This patch removes a conditional block that had no effect.
> It also reformat the affected lines to set the right indentation
> after the removal.
> Issue found by Coccinelle.
> 
> Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> ---
> Changes in V2:
> 	- No changes.
> 
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Please use scripts/get_maintainer.pl on your patches to send them to the
proper mailing lists and developers.  Right now you are only cc: me and
lkml and sometimes the outreachy list, which is odd.

Please fix this up and redo the series.

thanks,

greg k-h
