Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1236103ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfKTPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 10:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfKTPg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:36:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D1A20709;
        Wed, 20 Nov 2019 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574264188;
        bh=P8EGesrpH/uImOrrL+/RdkGKOxCuNxZ78Yspbo+u+EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQLu82mZ95uMEgE5WA6MYB0/YllLETrWr92sxgPg/hbJLuLM3s2y0vZtqPUR9ZLlR
         Fg44tMvxARlO+7LGnxwdLXUVpEPXQSqFai0ffwvaj5wDEXkGXZqYMJVSPkbPBigKDH
         fKTDKWRcOx3VTWp+Ou7y67z3/+W94YLO8/iiFzXo=
Date:   Wed, 20 Nov 2019 16:36:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: Fix the semantics of of_is_ancestor_of()
Message-ID: <20191120153625.GA2981769@kroah.com>
References: <20191120080230.16007-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120080230.16007-1-saravanak@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:02:29AM -0800, Saravana Kannan wrote:
> The of_is_ancestor_of() function was renamed from of_link_is_valid()
> based on review feedback. The rename meant the semantics of the function
> had to be inverted, but this was missed in the earlier patch.
> 
> So, fix the semantics of of_is_ancestor_of() and invert the conditional
> expressions where it is used.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

What git commit does this patch fix?

thanks,

greg k-h
