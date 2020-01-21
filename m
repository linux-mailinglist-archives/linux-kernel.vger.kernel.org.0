Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45214454C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAUTmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 14:42:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:34985 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:42:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 11:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="215650255"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 11:42:18 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8A9AC3003A3; Tue, 21 Jan 2020 11:42:18 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:42:18 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org
Subject: Re: [RFC 5/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200121194218.GT302770@tassilo.jf.intel.com>
References: <20200117124620.26094-1-kjain@linux.ibm.com>
 <20200117124620.26094-6-kjain@linux.ibm.com>
 <20200117162807.GL302770@tassilo.jf.intel.com>
 <b6e3ae17-ce41-2709-1a87-dcd9bd1f365a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e3ae17-ce41-2709-1a87-dcd9bd1f365a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here, '?' will be replaced with a runtime value and metric expression will
> be replicated.

Okay seems reasonable to me.

Thanks,

-Andi
