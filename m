Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A876F108F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEAOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfEAOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:23:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056A8205F4;
        Wed,  1 May 2019 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556720614;
        bh=ASWXJFG8Rr6YiVpfdUBQnbhh2cFe8b4RwZTn64sHBYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yAT6sgfndzqG9OSc8+8PEvHzxcGbLQSw5xuS2iEB6rnhfTnuCaGGlvvbqZ/FamZgW
         qe+5t4cE8gQl2zsDFDFifTfk174WnBcDcaTl2K0aBi20ZgKwSzthGkKjeO/ZUaJv/8
         +Ld3guLJcUiz3O+Elu9WmxZpnMcs5grKP77IqbXs=
Date:   Wed, 1 May 2019 16:23:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
Message-ID: <20190501142332.GA13008@kroah.com>
References: <20190501140624.6931-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501140624.6931-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:06:24AM -0400, Sven Van Asbroeck wrote:
> The following changes since commit a4965d98b4d1ffa5b22f2039bc9e87898aff4976:
> 
>   staging: comedi: comedi_isadma: Use a non-NULL device for DMA API (2019-04-27 15:00:35 +0200)
> 
> are available in the Git repository at:
> 
>   git@gitlab.com:TheSven73/linux.git tags/fieldbus-dev-for-5.2

I don't "trust" the gitlab infrastructure, sorry, and I don't think I
have a valid gpg signature from you anywhere :(

Can you just send these as patches?  I can easily queue them up that
way.

thanks,

greg k-h
