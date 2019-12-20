Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C00128200
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLTSPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 13:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfLTSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:12 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576865711;
        bh=23AzVZm23NrI25LQM7jLV8s1KMGZBy6PExwIUbBJdfA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XSnjcgKtxLUXYfFSDyB6/2VRc7nH8WRSHDFpdePkR+jnhYLPFAu9hRmzFqy9aEQVP
         QIGkHInskNX+PEQFEL9yOcnJ3XT/xr2P6aEZvsURO8Oaml2DOz0TbHoImCUbcdU9+F
         t3QSN2sDBuNjH5Z02pSJ/L03IjKsU8K/RxtvROuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220070747.GA2190169@kroah.com>
References: <20191220070747.GA2190169@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220070747.GA2190169@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc3
X-PR-Tracked-Commit-Id: cb47b9f8630ae3fa3f5fbd0c7003faba7abdf711
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a4ee8673a775faf4164e66e03b2bcb0cc915d5d
Message-Id: <157686571148.29164.8923185745210031796.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:15:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 08:07:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a4ee8673a775faf4164e66e03b2bcb0cc915d5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
