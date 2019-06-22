Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF44F734
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFVQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 12:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:55:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561222506;
        bh=K2TDj7ajBE3jHhrThmYUIm3zVtzbSLQNT2J2KG5mZiU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DS6C9xMTECODTJvl8eIzFDgeVS25w5T8T29U2hcvk8XaJjsZnVpeRZ5xiVr7iAiuh
         MkHNnHowZL0Ata9ThSV/w49BjWWt3c73RttFhEyudEZ4Km9kg6IKIyLQQ8kS4W7CFM
         SpoDtn9b4Gks/TDDF2/B17e5sIP4ufUq7vmEtVGc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1561217509.3260.5.camel@HansenPartnership.com>
References: <1561217509.3260.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1561217509.3260.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 5589b08e5be47e426158f659a892153b4a831921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4102766463a66026bd4af6c30cbbd01f10e6c42
Message-Id: <156122250658.32167.9863795375132483783.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jun 2019 16:55:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jun 2019 08:31:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4102766463a66026bd4af6c30cbbd01f10e6c42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
