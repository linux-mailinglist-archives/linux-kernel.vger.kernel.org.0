Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4956D16B168
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBXVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 16:03:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:33705 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgBXVDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:03:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 13:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="231243317"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 13:03:08 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9004A3015F3; Mon, 24 Feb 2020 13:03:08 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:03:08 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/5] perf expr: Increase EXPR_MAX_OTHER
Message-ID: <20200224210308.GQ160988@tassilo.jf.intel.com>
References: <20200224082918.58489-1-jolsa@kernel.org>
 <20200224082918.58489-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224082918.58489-4-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:29:16AM +0100, Jiri Olsa wrote:
> There's no need to be greedy on allowed variables, also
> when some of the metrics define more than 15 variables,
> like Branch_Misprediction_Cost.
> 
> Increasing the maximum to 100.

FWIW some of the algorithms (e.g. already_seen) have O(n^2) complexity.

If you really want that many probably would need to add some hash tables.

-Andi
