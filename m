Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A059712B69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfECKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 06:23:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfECKXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:23:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5854374;
        Fri,  3 May 2019 03:23:21 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49C53F557;
        Fri,  3 May 2019 03:23:20 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] perf: Minor typo and style changes to perf_event.h
Date:   Fri,  3 May 2019 11:23:13 +0100
Message-Id: <20190503102315.5697-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes minor changes to perf_event.h to fix an incorrect
comment and to improve the readability of the annotations for the
optional callbacks.


Andrew Murray (2):
  perf: Fix incorrect comment for event_idx callback
  perf: Use consistent style of comments for optional callbacks

 include/linux/perf_event.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.21.0

