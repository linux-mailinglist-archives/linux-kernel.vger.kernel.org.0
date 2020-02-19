Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1A1639CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBSCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:49773 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726595AbgBSCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id F41871802CCC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 22D24181D3025;
        Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:69:355:379:541:988:989:1260:1311:1314:1345:1437:1515:1538:1566:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:3866:3867:3870:3872:5007:6120:6261:10004:10848:11658:11914:12043:12291:12297:12679:12683:12895:13069:13311:13357:13869:13894:14110:14384:14721:21080:21627:30005:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fold38_80482e8b11150
X-Filterd-Recvd-Size: 991
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 02:04:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 0/2] trace: Move trace data to new section _ftrace_data
Date:   Tue, 18 Feb 2020 18:03:16 -0800
Message-Id: <cover.1582077698.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the trace data to a separate section to make it easier to
examine the amount of actual data in an object file.

Joe Perches (2):
  trace: Move data to new section _ftrace_data
  trace_events/trace_export: Use __section

 include/trace/trace_events.h | 36 +++++++++++++++++++++---------------
 kernel/trace/trace_export.c  | 13 ++++++++-----
 2 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.24.0

