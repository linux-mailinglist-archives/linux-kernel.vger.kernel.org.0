Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB32F28C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 09:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfKGIIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 03:08:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:58575 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKGIIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:08:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 00:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="233179404"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 00:08:33 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf: Fix the aux_output group inheritance fix
In-Reply-To: <20191101151248.47327-1-alexander.shishkin@linux.intel.com>
References: <20191101151248.47327-1-alexander.shishkin@linux.intel.com>
Date:   Thu, 07 Nov 2019 10:08:32 +0200
Message-ID: <87r22kds73.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Commit
>
>   f733c6b508bc ("perf/core: Fix inheritance of aux_output groups")

In case this one is falling through the cracks.

Regards,
--
Alex
