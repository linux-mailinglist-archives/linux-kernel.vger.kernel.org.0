Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB92164DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 19:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 13:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:47:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90853206DB;
        Wed, 19 Feb 2020 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582138064;
        bh=b+v2qMnCelv8wE+6aYkJtGvCkTQpcxJ6FRzLnIxCz3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9SqhD3cfVIhc9cx2V2+rQtrHsh/uZ4ReAPLA0lVXeiK4RocD/0bxCl54w3lG1zVR
         fr7m3GkIzFahdsHqw9NHQNCdlUr+FJskc6QjEKvWY/wqllcSB7pv1TtwIcS8knZACt
         Izyk8Ol7gMz26GNvVx+lscqGn5iVCDjKH1T1708I=
Date:   Wed, 19 Feb 2020 19:47:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: change CamelCase to CAPS
Message-ID: <20200219184741.GB2854654@kroah.com>
References: <20200219174646.GA27559@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219174646.GA27559@kaaira-HP-Pavilion-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:16:46PM +0530, Kaaira Gupta wrote:
> fix checkpatch.pl check of 'Avoid CamelCase' by changing NI_CtrSource to
> NI_CTRSOURCE in all the files. Change it to CAPS because it is a MICRO
> 
> Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> ---
>  drivers/staging/comedi/comedi.h               |   4 +-
>  .../staging/comedi/drivers/ni_routing/README  |   4 +-

As proof of what I said in my previous email, see the changelog message
for this README file, and read it to see whre the names came from.

thanks,

greg k-h
