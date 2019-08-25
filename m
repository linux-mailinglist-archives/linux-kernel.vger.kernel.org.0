Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCD9C291
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfHYI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 04:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfHYI20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 04:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3361720870;
        Sun, 25 Aug 2019 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566721705;
        bh=LyyuVacUgp0QI5+McQ246IhEd+pkcxaG0db7hV8Z3xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCw9OWnIGjaeTxR+9Xx5LnDUbjfhCIuB5F5w9FFfzf7SuOwbxMJ+4cVtc8wI7S20T
         SE5DNlPlCPNTNlIWUq2enwtwY657PeQaQ3WdZmv8nS3QGrG3LfvDIjqra5BizdLoT0
         nXqLqWTXPCfJDdbzEu081JoguF9/gZIHRaiJDkrU=
Date:   Sun, 25 Aug 2019 10:28:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Fix indentation
Message-ID: <20190825082823.GA4301@kroah.com>
References: <20190822175228.3419-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822175228.3419-1-stephen@brennan.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:52:28AM -0700, Stephen Brennan wrote:
> Checkpatch reports WARNING:SUSPECT_CODE_INDENT in several places. Fix
> this by aligning code properly with tabs.
> 
> Signed-off-by: Stephen Brennan <stephen@brennan.io>
> ---
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   2 +-
>  .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 112 +++++++++---------
>  .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  18 +--
>  .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   8 +-
>  drivers/staging/rtl8192u/r819xU_firmware.c    |   2 +-
>  5 files changed, 71 insertions(+), 71 deletions(-)

This patch does not apply to my tree.  Please redo it against the latest
staging-next branch of the staging.git tree and resend.

thanks,

greg k-h
