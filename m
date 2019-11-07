Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A747F315D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfKGO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfKGO0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:26:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7D1207FA;
        Thu,  7 Nov 2019 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573136792;
        bh=e4/v4/FLGv4nTDoc1h6jNNLX26thNYOaHpPtD3GCI6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz4XVPVgYVqe9csIewQrqxWFk+qHfABa3s8qW2dXLnoO/AOP6x6HiZENcYfpKIJHn
         FGbDRF+rafW+5XgVjeFCrGaoHSFUHjRoiuQqw4henv1Yl9c8TGDaEpr12aHgp7CLn8
         e/ekMNtIolOJBr1XXcxWAIVoCTAEW0QDOxsel84g=
Date:   Thu, 7 Nov 2019 15:25:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt changes for v5.5
Message-ID: <20191107142556.GA129785@kroah.com>
References: <20191107131843.GL2552@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107131843.GL2552@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:18:43PM +0200, Mika Westerberg wrote:
> Hi Greg,
> 
> Please pull Thunderbolt changes for v5.5 merge window. I needed to merge
> my fixes branch here because there is dependency between some of the
> commits. The fixes branch is already included in your char-misc-linus
> branch.

None of the USB4 stuff yet?  Awe, I wanted to see that happen...

Anyway, pulled and pushed out, thanks.

greg k-h
