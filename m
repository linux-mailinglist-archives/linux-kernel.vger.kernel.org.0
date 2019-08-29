Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CCEA185A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH2LYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 07:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfH2LYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:24:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AE62173E;
        Thu, 29 Aug 2019 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567077849;
        bh=VviOCQGy1ugPpcSf9o7vsYWDge6z7YIYYguD7ujxDEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcrE+CoKD42mDLkKeAjysUKmx2OniackjW03u17FMUmgoR4F3XFZGJ+C58J1FlHvY
         eQXZnQG6mcBkozeSKn6S8/ZBlvk1JTmwG4uGlCw0xKpENupGmusdvKhcgCX5K7z44l
         ixBfSL8FkKxi6RyGsryE/M1aVIuUHshzJXFX8TYc=
Date:   Thu, 29 Aug 2019 13:24:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hung-Te Lin <hungte@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allison Randal <allison@lohutok.net>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julius Werner <jwerner@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware: google: update vpd_decode from upstream
Message-ID: <20190829112407.GB23823@kroah.com>
References: <525c3cdd-ba15-5898-b9de-daaa42b4b87e@roeck-us.net>
 <20190829101949.36275-1-hungte@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101949.36275-1-hungte@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:19:45PM +0800, Hung-Te Lin wrote:
> The VPD implementation from Chromium Vital Product Data project used to
> parse data from untrusted input without checking if there is invalid
> data (for example the if the size becomes negative, or larger than whole
> input buffer), which may cause buffer overflow on corrupted data.
> 
> To fix that, the upstream driver 'vpd_decode' has changed size
> parameters to unsigned integer (u32), and refactored the parsing of
> entry header so the size is always checked properly.

"the upstream driver"?  That's the code you are touching here.

What do you mean by "upstream"?  Your subject and this paragraph does
not make much sense.

Please describe exactly what you are doing here, we don't care what
anyone else did with this code in any random repo that is not Linus's
tree.

thanks,

greg k-h
