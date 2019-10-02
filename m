Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7470DC8F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfJBQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 12:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfJBQ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:58:11 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440B121920;
        Wed,  2 Oct 2019 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570035491;
        bh=jsLGFhojAf5G90SbKlaQUvingcgW1RLoooHEW/5ICFs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bV6h8eaEp+C/efwcIjsoc7wK2epRJYTs54gYajN7qwwmBANeeOOYeg7I8mxCShr5N
         pPDLsNaPQt+gGbMSi6QbcREqb6qtxEQWCjjmYMuI+QLsoOZtYFonWfzlIBEh7hh7NO
         mJ2jvPHSN3YNq7J5LneXWHfrUY1Vz260LjBT7DRY=
Date:   Wed, 2 Oct 2019 09:58:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add me for Linux Kernel memory consistency
 model (LKMM)
Message-ID: <20191002165810.GD2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191002152837.97191-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002152837.97191-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:28:37AM -0400, Joel Fernandes (Google) wrote:
> Quite interested in the LKMM, I have submitted patches before and used
> it a lot. I would like to be a part of the maintainers for this project.
> 
> Cc: Paul McKenney <paulmck@kernel.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..ecf6d265a88d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9473,6 +9473,7 @@ M:	David Howells <dhowells@redhat.com>
>  M:	Jade Alglave <j.alglave@ucl.ac.uk>
>  M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
> +M:	Joel Fernandes <joel@joelfernandes.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
