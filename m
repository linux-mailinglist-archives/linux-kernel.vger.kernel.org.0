Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C289DA2138
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfH2QpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfH2QpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:45:07 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567097106;
        bh=qihyy7S1W4r7GXG2gcMAKEgrqcDz1i+xZRSpyUxJicw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O5n2/70wObdWeANZHvsrlOVWQL81xBPhw8e2XqRynKDCUwCPXzemdkccLsTzE/YRG
         4HtzAijlyJUntjqhiGymig+ZxGgcPpHHg0ueozv3TY3WKkSUoiofk5Io4MfTeXQdN1
         pWNNr45gLN6NUnxhT3mYRHaYL0Fax3ASE63GJNy4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190829161639.GA18147@embeddedor>
References: <20190829161639.GA18147@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190829161639.GA18147@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.3-rc7
X-PR-Tracked-Commit-Id: 7c9eb2dbd770b7c9980d5839dd305a70fbc5df67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a64489cf8e21a17fd6dd88935818ba7307ba996
Message-Id: <156709710665.30085.5726463718274551620.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Aug 2019 16:45:06 +0000
To:     "Gustavo A. R. Silva" <gustavo@linux.embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Aug 2019 11:16:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a64489cf8e21a17fd6dd88935818ba7307ba996

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
