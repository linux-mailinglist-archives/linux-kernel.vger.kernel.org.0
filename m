Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D30FD808
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKOIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 03:38:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:39049 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOIiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:38:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 00:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="230391002"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2019 00:38:09 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Luwei Kang <luwei.kang@intel.com>, kvm-pmu@eclists.intel.com
Cc:     ak@linux.intel.com, kan.liang@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 0/4] Enable PEBS when only have PEBS via PT w/o DS
In-Reply-To: <1573672574-25247-1-git-send-email-luwei.kang@intel.com>
References: <1573672574-25247-1-git-send-email-luwei.kang@intel.com>
Date:   Fri, 15 Nov 2019 10:38:08 +0200
Message-ID: <87h835edqn.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to CC Peter and LKML.

Luwei Kang <luwei.kang@intel.com> writes:

> This patchset is purely perf event system changes that to enable the
> PEBS when the system only supports PEBS via Intel PT w/o DS. Currently,
> there don't have such hardware which only supports PEBS via PT w/o DS
> but it is possible in KVM guest. In Tremont Atom platforms, PEBS via
> PT is the only way to enabled PEBS in KVM guest.

I don't understand what this says. If PEBS-via-PT is available and DS is
not available, what happens and why?

Regards,
--
Alex
