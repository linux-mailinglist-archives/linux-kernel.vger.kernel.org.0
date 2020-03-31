Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1A19A2A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgCaXzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgCaXzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:12 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.7-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698912;
        bh=Ic+Zg2b85gzRC7NZ13TncC4v20pV6X7PQYKXZOcy8PU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q0T4HgU1yPLjvvlG2LTGrcCbfQKnIEMp/WNR8Lmiu6KmSbNxr+PSXHd5st5M4DC49
         23nvx2W+XnEV6qCFZCwIg04wdRg63R2sJ5Ib4M4+TwLgwaRp9Pj7NbOfb7QLMYUDFu
         0kWFxKy/NCmFbdkj2V+T2/1sl3ctEE/7hNWOHJrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331122139.GA3453702@smile.fi.intel.com>
References: <20200331122139.GA3453702@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331122139.GA3453702@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.7-1
X-PR-Tracked-Commit-Id: d878bdfba8ffda64265c921cf7497934a607f83a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dba43fc4ba2fed63e898867fa973c69c37623939
Message-Id: <158569891231.16027.13452491483212239297.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:12 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 15:21:39 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dba43fc4ba2fed63e898867fa973c69c37623939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
