Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00295FE28B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKOQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 11:17:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:12461 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbfKOQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 08:17:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="199242713"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2019 08:17:34 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf: Fix the mlock accounting, again
In-Reply-To: <20191115160818.6480-1-alexander.shishkin@linux.intel.com>
References: <20191115160818.6480-1-alexander.shishkin@linux.intel.com>
Date:   Fri, 15 Nov 2019 18:17:34 +0200
Message-ID: <878sohdsgx.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Commit
>
>   5e6c3c7b1ec2 ("perf/aux: Fix tracking of auxiliary trace buffer allocation")
>
> tried to guess the correct combination of arithmetic operations that would
> undo the AUX buffer's mlock accounting, and failed, leaking the bottom part
> when an allocation needs to be changed partially to both user->locked_vm

s/changed/charged/
