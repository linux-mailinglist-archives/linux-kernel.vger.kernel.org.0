Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F111037B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLCRaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfLCRaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:30:17 -0500
Subject: Re: [GIT PULL] percpu changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575394217;
        bh=S1AC6DHO4Ie/BmP9+GiG9ToH9mrKGsjMm+IyEbcDYbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HBR96Wrd2LYOx5tBCL3knQ+ZGXuGXv+phHYPnxcZlCq4Z56dndZhaTxeFjQyl+YpS
         m+iMrPgFs+OdB1mcN5F9vexgIgfQPaPgjK1lYKeGiYKg8luz5tWNVhSwjAPGx5HkxO
         TYi7UU7DJodZKHnLovLJCX+VZiTS65LgGE8LiQeQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191202192643.GA19946@dennisz-mbp>
References: <20191202192643.GA19946@dennisz-mbp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191202192643.GA19946@dennisz-mbp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.5
X-PR-Tracked-Commit-Id: ba30e27405afa0b13b79532a345977b3e58ad501
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2352923c753f0d89a0e2fc85ac37cee858afe33e
Message-Id: <157539421735.1633.5613922089782827452.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 17:30:17 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Dec 2019 14:26:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2352923c753f0d89a0e2fc85ac37cee858afe33e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
