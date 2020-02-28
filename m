Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43A1732F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 09:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1Id5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 03:33:57 -0500
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:39379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1Id4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:33:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3107E180265A6;
        Fri, 28 Feb 2020 08:33:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:4250:4605:5007:6261:10004:10848:11658:11914:12043:12296:12297:12679:12683:12895:13069:13311:13357:13894:14096:14384:14394:14721:21080:21222:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: power64_796178c799809
X-Filterd-Recvd-Size: 2097
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:33:54 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-parisc@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] parport: Use generic kernel logging styles
Date:   Fri, 28 Feb 2020 00:32:11 -0800
Message-Id: <cover.1582878393.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
References: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if the parport logging is getting some generic fixing,
here's some more generic logging fixing...

Joe Perches (7):
  parport: Convert printk(KERN_<LEVEL> to pr_<level>(
  parport: Use more comon logging styles
  parport: daisy: Convert DPRINTK to pr_debug
  parport_amiga: Convert DPRINTK to pr_debug
  parport_mfc3: Convert DPRINTK to pr_debug
  parport_pc: Convert DPRINTK to pr_debug
  parport: Standardize use of printmode

 drivers/parport/daisy.c          |  29 +---
 drivers/parport/ieee1284.c       |   4 +-
 drivers/parport/ieee1284_ops.c   |   3 +-
 drivers/parport/parport_amiga.c  |  22 +--
 drivers/parport/parport_atari.c  |   2 +-
 drivers/parport/parport_cs.c     |   6 +-
 drivers/parport/parport_gsc.c    |  25 +--
 drivers/parport/parport_gsc.h    |  21 ++-
 drivers/parport/parport_ip32.c   | 117 +++++++-------
 drivers/parport/parport_mfc3.c   |  21 +--
 drivers/parport/parport_pc.c     | 263 +++++++++++++------------------
 drivers/parport/parport_sunbpp.c |   2 +-
 drivers/parport/probe.c          |  34 ++--
 drivers/parport/procfs.c         |   6 +-
 drivers/parport/share.c          |  37 +++--
 15 files changed, 261 insertions(+), 331 deletions(-)

-- 
2.24.0

