Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97DED8FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 07:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfKDG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 01:27:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:48425 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfKDG1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:27:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 22:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="226656839"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2019 22:27:32 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 2/7] intel_th: msu: Fix an uninitialized mutex
In-Reply-To: <20191102171431.GB484428@kroah.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com> <20191028070651.9770-3-alexander.shishkin@linux.intel.com> <20191102171431.GB484428@kroah.com>
Date:   Mon, 04 Nov 2019 08:27:32 +0200
Message-ID: <874kzkf963.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Oct 28, 2019 at 09:06:46AM +0200, Alexander Shishkin wrote:
>> Commit 615c164da0eb ("intel_th: msu: Introduce buffer interface") added a
>> mutex that it forgot to initialize, resulting in a lockdep splat.
>> 
>> Fix that by initializing the mutex statically.
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/hwtracing/intel_th/msu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Again, no fixes or stable?

Same as the other one: fixes makes sense, but cc: stable -- not so
much.

Thanks,
--
Alex
