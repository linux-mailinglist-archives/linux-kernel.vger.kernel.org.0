Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D22374CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfFFNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfFFNC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:02:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD8020872;
        Thu,  6 Jun 2019 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826175;
        bh=ZMEpYSkZA0Q0/VcvnwOoovQKU7Ziw+6pF1UaPZVwQAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0JE+X1PLsBLOR56AmukxAbdTkEoMFaf3p8OY61fXd0Ep2nz2hDA6Qti6r9NxSncX
         Hms64YiJUI6Z/L8wXeKvidGPtIrqexWEetKYjTrLwmQadIYhe/5syePhmtoUANc3Jj
         xv7ezCUg+O30LYeMgYbAEIm3rKrk0zC62LrnuJac=
Date:   Thu, 6 Jun 2019 15:02:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: CleanUp to remove the error reported
 by checkpatch
Message-ID: <20190606130253.GE1140@kroah.com>
References: <20190606015949.GA2275@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606015949.GA2275@t-1000>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 06:59:52PM -0700, Shobhit Kukreti wrote:
> Cleaned up the code to remove the error "(foo*)" should be "(foo *)"
> reported by checkpatch from the file rtl8723bs/os_dep/ioctl_linux.c

Your subject line shoudl give a hint as to what the error you are fixing
is.

Also, no need for "CleanUp" in it, that's not a real word :)

thanks,

greg k-h
