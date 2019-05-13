Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C081B730
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfEMNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 09:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfEMNkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:40:13 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557754813;
        bh=rWm1npmDCQiZfGCj5p9nObj1h65ayLSshpiWhCZnxJQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i6I4z9cOE7jEoQdrxU6dKQncnLWoIZUqq54R/eNHCx64fP+neiqiznBvkUg+122uU
         8PNhV7mXCX6htKlawdWTn/aopsLFO0naF7xQkzyjjKvbCOzbxJsiiowZmWVlA/C+tj
         i+/T6UkCOAfSRNZyb6qaNak2fwkY0ztvue46cjJ0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513115328.GA12854@8bytes.org>
References: <20190513115328.GA12854@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513115328.GA12854@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.2
X-PR-Tracked-Commit-Id: b5531563e8a0b8fcc5344a38d1fad9217e08e09b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a13f0655503a4a89df67fdc7cac6a7810795d4b3
Message-Id: <155775481315.19061.13502173457976680281.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 13:40:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 13:53:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a13f0655503a4a89df67fdc7cac6a7810795d4b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
