Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC03E5E63
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfJZSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfJZSFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:05:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AAA20663;
        Sat, 26 Oct 2019 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113108;
        bh=etgcI5LiCF7KlUXG0QY0IU1mwTAKTY2Jmd+J7FcUmyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqiciS92jKolql4n2q58VrGwsm+3GDw8gVT2LTI4Mforb8M1tkRxuw69b2Y0JiOUD
         y9xQLz4jfc64Ycj1ojLTrvjo8DeMtaWSFRd1kzzsEGeox9s3e4BnDd5JdQ9mJXwkKI
         bKp8zcYiz9Tzu9/YxwoG8JIymIDXELCxlgvcSw8k=
Date:   Sat, 26 Oct 2019 20:05:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RESEND PATCH 2/2] staging: rtl8712: Remove lines before a close
 brace
Message-ID: <20191026180506.GC645771@kroah.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
 <0bd6b897a5af322cf54d53bb68752d3667a7acb6.1572051351.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd6b897a5af322cf54d53bb68752d3667a7acb6.1572051351.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:10:04PM -0300, Cristiane Naves wrote:
> Fix Blank lines aren't necessary before a close brace '}'. Issue found
> by checkpatch.
> 
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 2 --
>  1 file changed, 2 deletions(-)

What changed from the previous version?  This isn't a "RESEND" it is a
new version, right?  Please properly document that and resend the whole
series.

thanks,

greg k-h
