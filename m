Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD3D67F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbfJNREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 13:04:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:1732 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbfJNREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:04:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 10:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="395253421"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2019 10:04:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C77FA300FAA; Mon, 14 Oct 2019 10:04:45 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:04:45 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@redhat.com>,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191014170445.GM9933@tassilo.jf.intel.com>
References: <20191007174120.12330-1-andi@firstfloor.org>
 <20191008115240.GE10009@krava>
 <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
 <20191014143256.GL19627@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014143256.GL19627@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not being able to reproduce here, without your patch I get things
> working:

Okay, looks like I had some stale libbabel* stuff in /usr/local/* 
Probably that caused it.

I still think the patch would be a good idea to handle such cases, but
it's not needed for the common case.

-Andi
