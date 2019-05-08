Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1820817031
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 06:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEHEzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 00:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfEHEzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:19 -0400
Subject: Re: [GIT PULL] random changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291318;
        bh=FhwotkGj/oJnoKlGvzcHOerw5n4pdnf+7aZuQU7d7yw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RhmxHzK9glxQVtKras8n4w+k8aD1fIILAb5+/9VaybMphz1dhGBh5fU/EYtv3xL6W
         HdxUxEzNgxrE6pryydu5cPAlaNMTHCDPPAFXzXI1/uAkczZnU0Izd2wwyMV/YhWIYZ
         wAoyhaqvImtyzCdyIl16Cr0zsClEJXtB25eCXEsA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507233208.GA28817@mit.edu>
References: <20190507233208.GA28817@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507233208.GA28817@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git
 tags/random_for_linus
X-PR-Tracked-Commit-Id: b7d5dc21072cda7124d13eae2aefb7343ef94197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd5001e21a991b731d659857cd07acc7a13e6789
Message-Id: <155729131875.10324.4695080099688266378.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:18 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 19:32:08 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd5001e21a991b731d659857cd07acc7a13e6789

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
