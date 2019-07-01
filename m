Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4417FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfEHSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfEHSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:30:18 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557340218;
        bh=qrh0Uj2MAbqfEGrPCuCN4DYqvKRnDO2lCpEiVaCL4pY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W3SSHQ/zJJlb2Y/DTA13ahdxLiUZGNvqKMwSApgMMyswpLb60isKFUafLUcDOd05N
         FsVHOuzExsQII2K3Z3O6oBCA2LcckwHYXUPB+I50mMY2cY7UAIJWLHCniBwNBGQyBl
         Yg4TBoGn/y8VePLJBaoaAUBJLB9DMKPFLCEb2jXI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508161732.GG16145@minyard.net>
References: <20190508161732.GG16145@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508161732.GG16145@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.2
X-PR-Tracked-Commit-Id: ed6c3a6d8996659e3bbf4214ba26b5e5a7440b26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85c1a25494837ff33fdfebe98b2e4cf5b0c78475
Message-Id: <155734021842.8790.10159085448360926528.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 18:30:18 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 11:17:32 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85c1a25494837ff33fdfebe98b2e4cf5b0c78475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
