Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290404998F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfFRG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFRG5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:57:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E069C20863;
        Tue, 18 Jun 2019 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560836521;
        bh=+QRebg6toQEXk2xt0KfLP2gEAhm9ZZ14Nl8WNSxXxVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S03fz8RyICJEbA23G+syKb/UQ6INJlvQIhsYIdMJbm/ohR8isujjpXGMw+ffSPkpc
         3jrEooBnvIdpTh4wF2XMUIaaXB72foaiczdVOCGkdL11jpaWK+LqcsUHYAQmtEFX7+
         XPvWrK5y8IRFC39MMv4XBbASVs1bbjt+T2L91GNQ=
Date:   Tue, 18 Jun 2019 07:41:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
Message-ID: <20190618054158.GA3713@kroah.com>
References: <20190618053227.31678-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618053227.31678-1-puranjay12@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:
> This converts the plain text documentation to reStructuredText format.
> No essential content change.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  Documentation/platform/x86-laptop-drivers.rst | 23 +++++++++++++++++++
>  Documentation/platform/x86-laptop-drivers.txt | 18 ---------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/platform/x86-laptop-drivers.rst
>  delete mode 100644 Documentation/platform/x86-laptop-drivers.txt

Don't you also need to hook it up to the documentation build process
when doing this?

thanks,

greg k-h
