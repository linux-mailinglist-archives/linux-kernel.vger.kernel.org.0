Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725BB713D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbfGWIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbfGWIV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:21:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0700223A0;
        Tue, 23 Jul 2019 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563870117;
        bh=pyOa9TqEwFtti51PIZiuM9K7DuVRk4BvUe36Z4t9y1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1tC8wsWH6/wSsEwis15mHMDmbd1B2HAKJNBqUpVzEbyB0l6ap12Ftv3KljfO9XpL
         2xT9pv4k8v7M6+iWeioCWfxYKF1BODMmJSepaUmU4GLgIj3csVGABPGU0Gedy8I5iF
         5FZU0l8wwFvh0nqPcgyJOhtkT6Y+yn804aLwnZ+E=
Date:   Tue, 23 Jul 2019 10:21:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Rossi <issor.oruam@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: Fix missing inline
Message-ID: <20190723082154.GA10198@kroah.com>
References: <20190723081159.22624-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723081159.22624-1-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:11:59AM +0200, Takashi Iwai wrote:
> I mistakenly dropped the inline while resolving the patch conflicts in
> the previous fix patch.  Without inline, we get compiler warnings wrt
> unused functions.
> 
> Note that Mauro's original patch contained the correct changes; it's
> all my fault to submit a patch before a morning coffee.
> 
> Fixes: c8917b8ff09e ("firmware: fix build errors in paged buffer handling code")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/base/firmware_loader/firmware.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, now queued up.

greg k-h
