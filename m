Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A772710821
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 15:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEANI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 09:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:08:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82242085A;
        Wed,  1 May 2019 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556716108;
        bh=SRO4r3Co9WuqsnOgY0780Sz3PYGcGIFeiwKYqJlAa1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwxV1JApnL7suD71vDinkM0jGvS0+hYCIKzOOpZQ+cLL4DKg4uLQhOlf9Iw9/64uI
         sgNKvMXFb/67aOweL8suJZelhdO6on/R679WPfEK7kApoGiUChM8qKWITB52QjC0FX
         9mBiVNokfU5SZ7gDHgGhPLxhA329dOLLtwgprLw8=
Date:   Wed, 1 May 2019 15:08:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kobject: fix dereference before null check on kobj
Message-ID: <20190501130825.GA28441@kroah.com>
References: <20190501124317.1759-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501124317.1759-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 01:43:17PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The kobj pointer is being null-checked so potentially it could be null,
> however, the ktype declaration before the null check is dereferencing kobj
> hence we have a potential null pointer deference. Fix this by moving the
> assignment of ktype after kobj has been null checked.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: aa30f47cf666 ("kobject: Add support for default attribute groups to kobj_type")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  lib/kobject.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Nice catch, thanks, will go queue this up now.

greg k-h
