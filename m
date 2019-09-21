Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB978B9F53
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfIUSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 14:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbfIUSP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:26 -0400
Subject: Re: [GIT PULL] UML updates for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089726;
        bh=ti+qmkfQ9p0whpjxawYmXFHbQHdzcbzIxQ1CN/5lKgE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vvNlErjJnBddxcWBmx5kwH/BudZAnGh33g2ofQeEyWEQhe3c58C4ETB+wtb0Tyw8b
         t8idsbdOTujH+8mkRtVYjwAOF0ecuoUqrGkdl8BMYTLx40S3Cc3KGXeLKEvQsCGqjy
         iqSXudSt/yLifqlMj5lmtdU69H4lIX6YfT/A4Jb4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
References: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.4-rc1
X-PR-Tracked-Commit-Id: 73625ed66389d4c620520058d828f43a93ab4d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dca3432ee063b70a4cfb3f0857d0aeef7b84fa8
Message-Id: <156908972643.32474.17755196014521384085.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:26 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:36:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dca3432ee063b70a4cfb3f0857d0aeef7b84fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
