Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4504E153642
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBERWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 12:22:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:7727 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgBERWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:22:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 09:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="254826270"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2020 09:22:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AF2C63003A2; Wed,  5 Feb 2020 09:22:15 -0800 (PST)
Date:   Wed, 5 Feb 2020 09:22:15 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: introduce deltatime option
Message-ID: <20200205172215.GG302770@tassilo.jf.intel.com>
References: <20200204173709.489161-1-hagen@jauu.net>
 <20200204231628.GF302770@tassilo.jf.intel.com>
 <20200205091414.GB495987@virgo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205091414.GB495987@virgo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> reltime is relative to the *first event* in the record - deltatime is relative
> to the *previous* event.

Ah ok.

I think it's useful, but you should rather implement it as a new field instead
of as an option. There might be use cases where you want both.

delta time is easier for reading, but absolute time is often important 
to find something in a trace.

-Andi
