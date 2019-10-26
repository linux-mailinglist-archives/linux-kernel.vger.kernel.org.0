Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67655E5F94
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfJZUpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 16:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfJZUpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:07 -0400
Subject: Re: [GIT PULL] Driver core fix for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122707;
        bh=5v2AsrrvLdbsEM5/djLkWhOooV+n28841rDeBzS/gmM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cSdxHbOeWycmE5DlTT+E+kzNX/KsUfd++vMCMTWs5ZBXhXAk4c7CDLivdZARhLjI+
         HwW65VPflJsb4yv2ep0BFgv+wLsjPHNAuqQNycLipMSYCgTNSAjlwN8Wo6gX6y8Xsl
         ZGSLP+TlF1E5ofJheS9ArptNQELonhBjZNiZh2Jg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026181815.GA649015@kroah.com>
References: <20191026181815.GA649015@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026181815.GA649015@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.4-rc5
X-PR-Tracked-Commit-Id: 82af5b6609673f1cc7d3453d0be3d292dfffc813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13fa692e3f86deed6c0d56b3004b694f0ccad3d4
Message-Id: <157212270699.6077.7209485968910207010.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 20:18:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13fa692e3f86deed6c0d56b3004b694f0ccad3d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
