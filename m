Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A16138365
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 21:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgAKUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 15:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbgAKUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:01:49 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DCE2082E;
        Sat, 11 Jan 2020 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578772908;
        bh=5cQ3N/xRnFT6rIm/nGBRfofSS9aP6lkjO+HDHEkZnGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bynPxBRXW5sXd95VvECqw+6vC4DWlMAiSdCDiSW86hGjttZudYWnrvEQmqDkLN3uu
         qXjUz1wMI59w1Zbm0x74GoA4IaKNbgCe/oLQ8hMuVV256z5Ln3/gGypUNOH4q2k3wy
         bEYu1706F5V+Dom2Xiu8rVsLBWASfsK3se0kfSA0=
Date:   Sat, 11 Jan 2020 20:23:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
Message-ID: <20200111192353.GA435222@kroah.com>
References: <20200103084008.3579-3-kai.heng.feng@canonical.com>
 <20200110080211.22626-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110080211.22626-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:02:11PM +0800, Kai-Heng Feng wrote:
> Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> bus when bringing underlying ports from U3 to U0.
> 
> Disabling LPM on the hub during setting link state is not enough, so
> let's disable LPM completely for this hub.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)

What changed from v1?  Always put that below the --- line.

Also I only see 1 patch here, what happened to the first two?

Please resend the whole series, and properly document what went on, you
know this...

thanks,

greg k-h
