Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBED7CEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfGaUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfGaUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:35:16 -0400
Subject: Re: [GIT PULL] More IPMI bug fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564605315;
        bh=luWpGi6SOkRe1PfOcwVjSclhCcHbzRMitcY4oycD1lY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N3k6KW5ifNycwogBNWlWZuh+2Ky2C3fIg7GcylyHHmbdf+WeL2InuMx4JtcFq1xjs
         0lmGm3+GCazXifxihSmLKpR4Dde1j3qHWHfOCHmzSFljHuL9oEUyhwi5yn09j1PTHv
         Xu+2o7F6YACaVu90viZvqB3O5wC5kg13i2cSooic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190731150046.GB5001@minyard.net>
References: <20190731150046.GB5001@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190731150046.GB5001@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.3-2
X-PR-Tracked-Commit-Id: 71be7b0e7d4069822c89146daed800686db8f147
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52fde4348ccc317e7ad091a3280f5d4ae19f91ef
Message-Id: <156460531565.15680.4685333902719969187.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Jul 2019 20:35:15 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 31 Jul 2019 10:00:46 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52fde4348ccc317e7ad091a3280f5d4ae19f91ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
