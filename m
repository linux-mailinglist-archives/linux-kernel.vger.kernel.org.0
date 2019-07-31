Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41D37C47B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfGaOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:12:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:44319 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaOMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:12:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 07:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="323744413"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2019 07:12:51 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 0/7] perf, intel: Add support for PEBS output to Intel PT
In-Reply-To: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
References: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
Date:   Wed, 31 Jul 2019 17:12:50 +0300
Message-ID: <87y30e2syl.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Peter,

No, please disregard this one, it has brainfarts.

Thanks,
--
Alex
