Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27F1124180
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRIVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:21:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F7F218AC;
        Wed, 18 Dec 2019 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576657292;
        bh=6mM0BijGEYoRur7oz2no9UlWZYwRVBky5TH7mMCeIxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tcp4LQtfB+4tdXiG79mBYrBNTTf1346q5a9PS+pIgmKhKxCdQZO1otq9Tl29xMDW6
         cA1HQLzQsqx+PGh+2yh3mVTzShwelGn9omQW1BnPlv3NcMWOmYSryy+4zlBbzyRxJS
         TVwiw2nQQus4kuJEKuRmF7hqM+YDD/xmAPz8MQuc=
Date:   Wed, 18 Dec 2019 09:21:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org
Subject: Re: [<PATCH v1> 0/9] SD card bug fixes
Message-ID: <20191218082130.GA1554871@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:50:33PM -0800, Bao D. Nguyen wrote:
> These patches include SD card genernal bug fixes.
> 
> Bao D. Nguyen (2):
>   mmc: core: Add a cap to use long discard size
>   mmc: sd: Fix trivial SD card issues

<snip>

Odd use of "<" and ">" in your subject lines, how did git create such a
thing?

thanks,

greg k-h
