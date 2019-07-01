Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAE374ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfFFNOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfFFNOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D1420684;
        Thu,  6 Jun 2019 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826871;
        bh=N5irwB8idoFm9oQxjxPOGswBU09T2RFgTWN5O7AoJvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjOaJcJezK8t0TRJMV1Yx7+OrRMo0Tri2M+dNgZOnbwxL+Fzx3+HKWWYXOyEvmOYZ
         Aci1cF5CUkGFfK8dEkz9zWNyq/2YyHMnpdKhfHPFAjSnu9vMn6VVHOGBIn7lXNX+u9
         8XygBoTDycX4IRpFV6cTfvCFklm+xPEKmj+SvmZs=
Date:   Thu, 6 Jun 2019 15:14:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.2-rc4/5
Message-ID: <20190606131423.GA19251@kroah.com>
References: <20190606073216.GA31142@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606073216.GA31142@ogabbay-VM>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:32:16AM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is a pull request containing fixes to be merged to 5.2-rc4/5.
> 
> It contains 3 bug fixes. See the tag comment for more details.
> 
> Thanks,
> Oded
> 
> The following changes since commit 8aa75b72e3e6f0f566cd963606ec5da11b195c0b:
> 
>   Merge tag 'misc-habanalabs-fixes-2019-05-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2019-05-31 09:19:42 -0700)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-06-06

Pulled and pushed out, thanks.

greg k-h
