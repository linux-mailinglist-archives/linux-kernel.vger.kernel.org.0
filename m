Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EF8803D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437087AbfHIQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 12:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437328AbfHIQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:10 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368509;
        bh=9G0aXhvJqY5xiPO9mT5KoZGhNeafvb1dvF8/rxhngCE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DulcdwuhINLZ5ukHkar5ac80wg2J+6VL8YcglX2yRfvXZzvuujAWsYySTsPJrp3oE
         vgJcMu2//+calfTSzed+G2tHslfZkhFswLCoaMuy/dSLGjG+8UFyw+QYcx+Whv5THp
         vhEfY6ZMMr3I55spGWzkXYGdjW/rLLVkRWfKRBAM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809100149.7027-1-ulf.hansson@linaro.org>
References: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3
X-PR-Tracked-Commit-Id: b803974a86039913d5280add083d730b2b9ed8ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 461d2815ac9ec1b3f66fc243cc39bd2374facafa
Message-Id: <156536850939.6429.15936631477318963292.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:09 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Aug 2019 12:01:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/461d2815ac9ec1b3f66fc243cc39bd2374facafa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
