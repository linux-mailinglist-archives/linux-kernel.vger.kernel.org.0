Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354F77DCC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfHANpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfHANpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:45:16 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667115;
        bh=irKBkTZOXA50lKhibKjnQGmncCQWkMm6qcsvotwYPEY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n5sUIyDfaDsFVZIMWm3S3HMidX1YApcCpcHh1whEKbUpG3goAfsfSkiWFlXBmuIht
         FJeUP6xM3KRKTIsNZfSmy32G4o2pWhnuzG3AKAS1UoY0AY4BvNC2qS81r2ejaFD+f5
         Q051fUj3sw7bF40fFgEipfp1dpccfGh7uquW5gSM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801104319.25247-1-ulf.hansson@linaro.org>
References: <20190801104319.25247-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801104319.25247-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1
X-PR-Tracked-Commit-Id: 3a6ffb3c8c3274a39dc8f2514526e645c5d21753
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e78030e5e5b2d8b0cad7136caf9cfab986a6bff
Message-Id: <156466711554.11650.9013736897239318826.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Aug 2019 13:45:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Aug 2019 12:43:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e78030e5e5b2d8b0cad7136caf9cfab986a6bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
