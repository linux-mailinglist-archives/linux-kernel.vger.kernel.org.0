Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B63376E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFCSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFCSC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F8F255A2;
        Mon,  3 Jun 2019 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559584977;
        bh=E1ND2nKG/0VMEVLJhyvZL/8aBO7uvsfPiWlFj4RxYFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWvTncjVGKjHn3WHUfUPWelndlKFhcSd142wdYBNYIYvBSeSVxznInWL5ZCDjjOUA
         Eiy92nj+uzOKPdvPAYQL2d5d6bahdemTwQ7IiFy3N4MbpdrFlJiPalmB22zM1NV2gL
         7FBkGM9zIgbBvTfaoxsRdME1OT1scCPxDtDLjwNg=
Date:   Mon, 3 Jun 2019 20:02:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: A potential broken at platform driver?
Message-ID: <20190603180255.GA18054@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:57:18AM -0500, Richard Gong wrote:
> 
> Hi Greg,
> 
> Following your suggestion, I replaced devm_device_add_groups() with .group =
> rus_groups in my version #4 submission. But I found out that RSU driver
> outputs the garbage data if I use .group = rsu_groups.

What is "garbage"?

> To make RSU driver work properly, I have to revert the change at version #4
> and use devm_device_add_groups() again. Sorry, I didn't catch this problem
> early.
> 
> I did some debug & below are captured log, you can see priv pointer get
> messed at current_image_show(). I am not sure if something related to
> platform driver work properly. I attach my debug patch in this mail.
> 
> 1. Using .groups = rsu_groups,
> 
> [    1.191115] *** rsu_status_callback:
> [    1.194782] res->a1=2000000
> [    1.197588] res->a1=0
> [    1.199865] res->a2=0
> [    1.202150] res->a3=0
> [    1.204433] priv=0xffff80007aa28e80
> [    1.207933] version=0, state=0, current_image=2000000, fail_image=0,
> error_location=0, error_details=0
> [    1.217249] *** stratix10_rsu_probe: priv=0xffff80007aa28e80
> root@stratix10:/sys/bus/platform/drivers/stratix10-rsu# cat current_image
> [   38.849341] *** current_image_show: priv=0xffff80007aa28d00
> ... output garbage data
> priv pointer got changed

I don't understand this, sorry.  Are you sure you are actually using the
correct pointer to your device?

> @@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
>  	.remove = stratix10_rsu_remove,
>  	.driver = {
>  		.name = "stratix10-rsu",
> -		.groups = rsu_groups,
> +//		.groups = rsu_groups,

Are you sure this is the correct pointer?  I think that might be
pointing to the driver's attributes, not the device's attributes.

If platform drivers do not have a way to register groups properly, then
that really needs to be fixed, as trying to register it by yourself as
you are doing, is ripe for racing with userspace.

thanks,

greg k-h
