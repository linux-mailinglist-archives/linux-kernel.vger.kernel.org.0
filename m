Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34A90019
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfHPKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 06:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfHPKhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F57206C2;
        Fri, 16 Aug 2019 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565951834;
        bh=9emNeGo6hLV8aIOpirPl/lIwJ9cslOuODXUDs0WL2Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdduGeCw1ucfuENsGseUGlrGs860qVAitOSzn3M6pPRIUwhxK5bUbL1t6GkbFZMS7
         a7n3vfLlrwzDMLYe7OGfa0CBiQJ6Qsm4TJfQwtYef2eiBmXLeWq8O4FoPrCd16zMJF
         eWgeVUgn2q8Db7F/oNgP6oKkLM7u7dhcVT3ajuDo=
Date:   Fri, 16 Aug 2019 12:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire fixes for v5.4-rc5
Message-ID: <20190816103711.GA1419@kroah.com>
References: <20190816095709.GC12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816095709.GC12733@vkoul-mobl.Dlink>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 03:27:09PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> We have couple of fixes queued up, please pull. Some more are in review,
> will send them later.
> These fixes are in linux-next as well.
> 
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.3-rc5

Pulled and pushed out, thanks.

greg k-h
