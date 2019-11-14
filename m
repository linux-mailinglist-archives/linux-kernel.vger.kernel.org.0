Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5010AFCEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfKNTrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD3920725;
        Thu, 14 Nov 2019 19:47:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVL5e-0001vl-TW; Thu, 14 Nov 2019 14:47:38 -0500
Message-Id: <20191114194636.811109457@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 14:46:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 0/2] ftrace: Add modify_ftrace_direct()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with Alexei, here's a simple implementation of
modify_ftrace_direct() without the need for any architecture changes.

Steven Rostedt (VMware) (2):
      ftrace: Add modify_ftrace_direct()
      ftrace/samples: Add a sample module that implements modify_ftrace_direct()

----
 include/linux/ftrace.h                |  6 +++
 kernel/trace/ftrace.c                 | 78 +++++++++++++++++++++++++++++++
 samples/ftrace/Makefile               |  1 +
 samples/ftrace/ftrace-direct-modify.c | 88 +++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-modify.c
