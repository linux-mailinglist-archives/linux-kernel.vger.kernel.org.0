Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C69F26B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfH0SfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 14:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbfH0SfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:35:10 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566930909;
        bh=UQvfCfslgKI6KGwq1NuzPs5JFEEerBNEwq2k98iCcyU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MGUVFBkdV0mMKYAPNuklz5X8GLtERPAHrOfxOECx+VCKpLNDfKZpimbC6lRXZKkqA
         XHIKNOq7heeUKFTi6mt4lHGab8IQzPiV3cUR+s31bznqyrQBI9V5yqP6Y6w4XliDDi
         0UEvay5y8U26JVNUafAaOHza0usj3OEchhCCWQ2Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190827132149.GF4804@dell>
References: <20190827132149.GF4804@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190827132149.GF4804@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.3
X-PR-Tracked-Commit-Id: 4d82fa67dd6b0e2635ae9dad44fbf3d747eca9ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d6454083d463a44097566616b473c7e6d4bdf02
Message-Id: <156693090932.10894.13702787196815270634.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Aug 2019 18:35:09 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Aug 2019 14:21:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d6454083d463a44097566616b473c7e6d4bdf02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
