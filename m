Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF4BFA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfIZUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 16:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfIZUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:28 -0400
Subject: Re: [GIT PULL] xen: features for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528627;
        bh=rGDoo2MYW+dR1gVcq1CSyeMAXd+itqo1MMRtZrRXBxM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UBRrtMvHwgwNhd1qSCDhKeXHcmYDvz26Pe18uZl+WIkMEdg8efJteSoZQT/f1Ripq
         0eel7llD7EUrownzTeNY4+O6cV8Vq4ZuutevJXsdvtih0zU9D07J6RJU11fXUP2pVE
         YUbTh/KEiFyvuPKgcCrnFpdenesCntEFau6nf6M0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926141743.25426-1-jgross@suse.com>
References: <20190926141743.25426-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926141743.25426-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.4-rc1-tag
X-PR-Tracked-Commit-Id: a4098bc6eed5e31e0391bcc068e61804c98138df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec56103e18c7590303c69329dd4aaadf8a898c19
Message-Id: <156952862779.24871.12479839643612044427.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:27 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 16:17:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec56103e18c7590303c69329dd4aaadf8a898c19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
