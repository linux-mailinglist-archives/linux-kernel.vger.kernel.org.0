Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05331650
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEaUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 16:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfEaUzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:55:02 -0400
Subject: Re: [GIT PULL] nfsd bugfix for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559336102;
        bh=hOWJaY8yysZrmHbu84fuOUV74anOlK996ZbSDhvpSHI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Kzrk2Yc2eFLPXHmNNG1PvhiWWuYLF0aiguPJTtfQLZPHIW9ybCbRxdOg3Sfzb1EtL
         i54riw+M1yF2+U343KVRh4gwt356OUYwwAfz8GUH6piDbEz7yQ7y1BtGnv+1sp/LBo
         4BwKb4PpKF7eZRxl8xzOFNRTpIAEp5FufYnkMExc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531203944.GB5334@fieldses.org>
References: <20190531203944.GB5334@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531203944.GB5334@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-1
X-PR-Tracked-Commit-Id: 141731d15d6eb2fd9aaefbf9b935ce86ae243074
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ab4436f688c2d2f221793953cd05435ca84261c
Message-Id: <155933610210.3628.13222773936955967586.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 20:55:02 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 16:39:44 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ab4436f688c2d2f221793953cd05435ca84261c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
