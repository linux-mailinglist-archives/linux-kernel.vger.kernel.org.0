Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E62159519
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgBKQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBKQjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:39:07 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAB020714;
        Tue, 11 Feb 2020 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581439147;
        bh=NW/bcpN6ZnsfYRq2jo8jxNsipGcsVCTdc1+KVQ9x/SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv+cyubVgV2EUiQrE8FT7xZhjecXwETyk8BmRhwovgnYUH1YQ0xBznD/lao9Xt/4f
         jbak4ey7QsVm04i1asbsi2il1654Al7GZ2YbhQOU+RlF9FBrDJCR9C8ip7M40+bolk
         8WgTvNi7EKoIFTdbaJuv6mtt301o+l1ZoRGVFItI=
Date:   Tue, 11 Feb 2020 08:39:06 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [PATCH 1/1] usb: Add MA USB Host driver
Message-ID: <20200211163906.GA1931506@kroah.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
>   39 files changed, 8668 insertions(+)

This is a bit hard, if not impossible, to review all in one huge patch.

Can you resend this as a patch series, breaking it down into logical
chunks, like all other kernel patches have?

Also, why so many individual files?  For only 8k lines, 39 files seems
like a huge number.

thanks,

greg k-h
