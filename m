Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6115F18503E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCMUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:25:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.6-rc6 take2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131107;
        bh=qh59NKk5b/UE7bO+HoSw6wEWZNyF+IwN4tPCJCBfzf8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AQhS98z7eejlitvHDOnM6dvQ4tzkobq8tXXd7qAY6ikVPBuJ/Ad9kVFjNcKVgYFNO
         ePzZAiklxTeOZlQ13OMg3vt41IUcmqq/oVp51AydNhmpU9nu6At1K7goRQNq2ZfOXv
         5jy5KitdtiSkd8mApRc/E5XBZttkbhuoU03y87mE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200313123202.23685-1-ulf.hansson@linaro.org>
References: <20200313123202.23685-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200313123202.23685-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
 tags/mmc-v5.6-rc1-2
X-PR-Tracked-Commit-Id: 18d200460cd73636d4f20674085c39e32b4e0097
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d36561296bb510bf339750ea22efaa660277642e
Message-Id: <158413110734.9951.15489734490072348773.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 20:25:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 13:32:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d36561296bb510bf339750ea22efaa660277642e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
