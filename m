Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFF1522EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBDXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 18:16:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:43176 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:16:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="264021590"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 15:16:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2ED9C3003A2; Tue,  4 Feb 2020 15:16:28 -0800 (PST)
Date:   Tue, 4 Feb 2020 15:16:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: introduce deltatime option
Message-ID: <20200204231628.GF302770@tassilo.jf.intel.com>
References: <20200204173709.489161-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204173709.489161-1-hagen@jauu.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 06:37:09PM +0100, Hagen Paul Pfeifer wrote:
> For some kind of analysis a deltatime output is more human friendly and reduce
> the cognitive load for further analysis.
> 
> The following output demonstrate the new option "deltatime": calculate
> the time difference in relation to the previous event.
> 
> $ perf script --deltatime

It's already implemented as --reltime

-Andi
