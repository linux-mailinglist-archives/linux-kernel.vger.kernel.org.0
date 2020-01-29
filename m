Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2EB14C427
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 01:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgA2AtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 19:49:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:19474 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgA2AtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:49:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 16:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="312141985"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2020 16:48:59 -0800
Date:   Tue, 28 Jan 2020 16:59:22 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: fix redundant task movement
Message-ID: <20200129005922.GA74965@romley-ivt3.sc.intel.com>
References: <20200129002222.213154-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129002222.213154-1-shakeelb@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:22:22PM -0800, Shakeel Butt wrote:
> Currently a task can be moved to a rdtgroup multiple times or between
> resource or monitoring groups. This can cause multiple task works are
> added, waste memory and degrade performance.
> 
> To fix the issue, only move the task to a rdtgroup when the task
> is not in the rdgroup. Don't try to move the task to the rdtgroup
> again when the task is already in the rdtgroup.

Hi, Shakeel,

Acutally we are working on replacing the callback by a synchronous way
to update closid and rmid when moving a task to a resource group. The
reason is the task may use old (even invalid) closid and rmid before
they are updated.

With the new way to update closid and rmid, the issues related to
the callbacks will be fixed as well.

We will release the new patches soon.

Thanks.

-Fenghua

