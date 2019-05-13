Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAD1BFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 00:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEMWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 18:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfEMWzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:55:16 -0400
Subject: Re: [GIT PULL] percpu changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557788115;
        bh=zoUDwhLvAd1vhaGU8kBKsxlklp/ynJ4RVpUUR8CYCX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KyFd5GNJcWCd8uLj33Y8/HURKSkaKNmVgzqUOGuiThMNJ7NFnfPjFWziVUxw8TUcz
         5QPVZ2GhLw5TMrqMA/l2b/qKr3/+eIBQM1UKW6Z6BCW9Rpfx55qGqH2sRjQ2bW63Zx
         SqsegLhcxqbDzDzUyRphYbsVO/L1NqRixMGDUFis=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513185241.GA74787@dennisz-mbp>
References: <20190513185241.GA74787@dennisz-mbp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513185241.GA74787@dennisz-mbp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.2
X-PR-Tracked-Commit-Id: 198790d9a3aeaef5792d33a560020861126edc22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aff5fac54d722f363eac7db94536bffb55ca43f
Message-Id: <155778811588.1812.12003345020716870482.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 22:55:15 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 14:52:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aff5fac54d722f363eac7db94536bffb55ca43f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
