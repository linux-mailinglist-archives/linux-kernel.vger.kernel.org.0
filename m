Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1CE173FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 19:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1Sdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 13:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1Sdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:33:42 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE59246A3;
        Fri, 28 Feb 2020 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582914822;
        bh=C93yJs8kjD5S8YZO6qQlXFmyxpgGub/hYaDwpVLiVTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VH5EIojxjz8vrCTyTnEYgUUdFRpORI3iaYCIwO1mi/6wAXH9ze8sZ8IXKUhKrWRcD
         eHxduIhYbDW5bwqgGlQZVMQqfeG3pMUb2TwyPNTalzDWQM9I+VFE5TwWn3b9Uxhee1
         KhZ2mNGah5+ueS7Zklwksa0Fp+JsSbLRS5GoCP6Q=
Date:   Fri, 28 Feb 2020 10:33:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200228103339.4f36d6ae@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <16889e77-31cf-58f6-c27e-5b8a6b3e604d@linaro.org>
References: <20200228165343.8272-1-elder@linaro.org>
        <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
        <16889e77-31cf-58f6-c27e-5b8a6b3e604d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 12:06:09 -0600 Alex Elder wrote:
> On 2/28/20 12:04 PM, Alex Elder wrote:
> > 
> > 
> > I find field_max() to be a good name for what I'm looking for.  
> 
> Sorry I wanted to add this but clicked "send" too fast.
> 
> Yes it's the same as field_mask(), but that name only *implies*
> it is the same as the maximum value.  I mean, they're the same,
> but the name I'm suggesting conveys its purpose better.

We got FIELD_FIT tho.. The comparison is part of the macro there, 
and it catches negative values if they manage to sneak in.
