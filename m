Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D2A73F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfICTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 15:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfICTrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:47:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C81C21881;
        Tue,  3 Sep 2019 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540039;
        bh=u8oGsza9gJmw72Q+gBCjR4WxraGtmr0E2rtxlvf3ehc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsGlApp3fczlJAlN0YdyWIWKCWy9F6SSscBxVOOan8wHCg23Ij/rvzYlcqaMvALlL
         5W3aBF/VI3Kv+xxtmCODZUTCQTUfuDX4L1PDiz6TDva0DCHAdBnC5aESyE/aCaI8dD
         6ZnEaPNQBq7HWdz1ed9fLBfseSPlWgbcgkc2b94g=
Date:   Tue, 3 Sep 2019 21:46:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.4
Message-ID: <20190903194657.GA13390@kroah.com>
References: <CGME20190826025109epcas1p2add5354e4989028cd942b2121447dfd8@epcas1p2.samsung.com>
 <4c61ce13-69c7-f6ce-ae37-722f370371f4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c61ce13-69c7-f6ce-ae37-722f370371f4@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:55:13AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.4. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> 
> Detailed description for this pull request:
> 1. Clean up the and fix the minor issue of extcon provider driver
> - extcon-arizona/max77843 replace the helper function
>   with more correct helper function without operation changes.
> - extcon-fsa9480 supports the FSA880 variant by adding the compatible name.
> - extcon-arizona updates the dt-binding file for the readability.
> - extcon-gpio initializes the interrupt flags according to active-low state.
> - Clean up extcon-sm5502/axp288/adc-jack
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.4

Pulled and pushed out, thanks.

greg k-h
