Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27024D2562
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfJJI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 04:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388520AbfJJI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:59:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F0D2190F;
        Thu, 10 Oct 2019 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697958;
        bh=CBsMU142wfX9FybWwG+uuFeTqNtLpXx3v2EZPchDETs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRZVyrNBrGhWLYx+dXPGzcSkHO5EWb2PWUxkCozfLTkecgnW2NQSIOMqAEsV6hrsK
         qsqityIn/xOoTRUyi8dLC9nLvBOLTp+fNbtv1SR/SM2HeidX+etktZ386rhw3Kw2yQ
         04ss6LkG6iXRyVRUJswRulPJUXjMx9xZyBl1frXA=
Date:   Thu, 10 Oct 2019 10:59:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: rtl8723bs: Remove comparisons to NULL in
 conditionals
Message-ID: <20191010085916.GA452879@kroah.com>
References: <cover.1570682635.git.wambui.karugax@gmail.com>
 <da71920fa80298badcced3519f2b84afbdd28a7e.1570682635.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da71920fa80298badcced3519f2b84afbdd28a7e.1570682635.git.wambui.karugax@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:49:05AM +0300, Wambui Karuga wrote:
> Remove most comparisons to NULL in conditionals in
> drivers/staging/rtl8723bs/core/rtw_mlme.c
> Issues reported by checkpatch.pl as:
> CHECK: Comparison to NULL could be written
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 46 +++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Due to lots of other changes in this file recently, this patch does not
apply, and so the rest of this series does not apply either.

Can you please rebase this against my staging-testing branch and resend?

thanks,

greg k-h
