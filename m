Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A970063A12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 13:22:20 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:60544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfGIRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:22:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D220D180A68B6;
        Tue,  9 Jul 2019 17:22:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1538:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3876:3877:5007:6114:6642:10004:10400:10848:11658:11914:12297:12555:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21627,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: pin68_886ea01b22811
X-Filterd-Recvd-Size: 1239
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 17:22:17 +0000 (UTC)
Message-ID: <d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com>
Subject: [PATCH] ASoC: rt1308: Remove executable attribute from source files
From:   Joe Perches <joe@perches.com>
To:     Derek Fang <derek.fang@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jul 2019 10:22:16 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are source files not executable.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/rt1308.c | 0
 sound/soc/codecs/rt1308.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/rt1308.h b/sound/soc/codecs/rt1308.h
old mode 100755
new mode 100644

