Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5950D14CC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgA2Oie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgA2Oib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756042465B;
        Wed, 29 Jan 2020 14:38:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iwoU9-0019k4-B6; Wed, 29 Jan 2020 09:38:29 -0500
Message-Id: <20200129143802.971887038@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 09:38:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: A few more older patches pulled in for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab (1):
      docs: tracing: Fix a broken label

Tom Zanussi (4):
      tracing: Simplify assignment parsing for hist triggers
      tracing: Add hist trigger error messages for sort specification
      tracing: Add 'hist:' to hist trigger error log error string
      tracing: Add new testcases for hist trigger parsing errors

----
 Documentation/trace/kprobetrace.rst                |  1 +
 kernel/trace/trace_events_hist.c                   | 94 +++++++++++-----------
 .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++
 3 files changed, 79 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
