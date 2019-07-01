Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2502211FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEBQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 12:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEBQPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:15:04 -0400
Subject: Re: [GIT PULL] MTD fixes for 5.1 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556813703;
        bh=48dOdRmMVPXBsowhpGEfeSxCWlng0Hchxv8f1hORoPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RPWNbSbD56omBBiQaXhuzBNOZAriW3Ly/T7knVtPG4xedUyC88Eg2S9RQRZHCIvnI
         kOaS5uj/1RIw4CSLzyFHgXKtFuyaEpW1NqboAESo+ZG+VHdtNLG8bzKRgrgXG53rje
         Uw99MA7DDkKFzMsg1cEcv40WX3uA/ylfWAQ38qGs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1906022472.41848.1556787246765.JavaMail.zimbra@nod.at>
References: <1906022472.41848.1556787246765.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1906022472.41848.1556787246765.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.1-rc6
X-PR-Tracked-Commit-Id: 9a8f612ca0d6a436e6471c9bed516d34a2cc626f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2a4b102d48be7f6055e0e70696ab243ee791e51
Message-Id: <155681370345.16515.15182479020110698359.pr-tracker-bot@kernel.org>
Date:   Thu, 02 May 2019 16:15:03 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds@linux-foundation.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 May 2019 10:54:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2a4b102d48be7f6055e0e70696ab243ee791e51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
