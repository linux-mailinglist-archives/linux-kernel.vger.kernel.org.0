Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604ED892F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHKRuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 13:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHKRuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 13:50:08 -0400
Subject: Re: [GIT PULL] NTB bug fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565545807;
        bh=Rs+Ze9RGfHCINzSg9y8mBa3QLzUFZPvCtOCIK5Q5RiY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aVpcW7ddTGiHViJ2a+h9bfjg5lJkBbsLRDnwp/1ZbAS+Jh2diABCff9uCzPUUg7rW
         bDCVIKscj5WMuVJmEGAhs0BJAKP55CIPjqJur9s+5SDTWNlDCgFGMo+NiF+2mfFDnN
         9U/bnZ/46+Fl5TxiSblWEdSHlz7n8xtee3cTk/k8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190811141703.GA12153@graymalkin>
References: <20190811141703.GA12153@graymalkin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190811141703.GA12153@graymalkin>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.3-bugfixes
X-PR-Tracked-Commit-Id: 49da065f7b1f27be625de65d6d55bdd22ac6b5c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6192cb7429211bfaac1178c35607b0c989900b8
Message-Id: <156554580721.21169.6349916023834124246.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Aug 2019 17:50:07 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Aug 2019 10:17:03 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.3-bugfixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6192cb7429211bfaac1178c35607b0c989900b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
