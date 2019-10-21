Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9007DE4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 08:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJUGhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 02:37:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:60864 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJUGhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:37:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 23:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="397231878"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.57])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2019 23:37:31 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Jan Stancek <jstancek@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel/pt: Fix base for single entry topa
In-Reply-To: <20191019220726.12213-1-jolsa@kernel.org>
References: <20191019220726.12213-1-jolsa@kernel.org>
Date:   Mon, 21 Oct 2019 09:37:30 +0300
Message-ID: <87v9si4n9x.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <jolsa@kernel.org> writes:

> Jan reported failing ltp test for pt. It looks like the reason
> is commit 38bb8d77d0b9, that did not keep the TOPA_SHIFT for
> entry base, adding it back.

Thanks for taking care of that so quickly!

Regards,
--
Alex
