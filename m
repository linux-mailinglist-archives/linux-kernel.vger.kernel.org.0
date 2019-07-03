Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BCF5E858
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGCQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:03:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:31664 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:03:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 09:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="166027131"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2019 09:03:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on arm64 platform
In-Reply-To: <20190703155849.GA19567@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com> <20190627125152.54905-2-alexander.shishkin@linux.intel.com> <20190703154551.GA19371@kroah.com> <87muhvt8pu.fsf@ashishki-desk.ger.corp.intel.com> <20190703155849.GA19567@kroah.com>
Date:   Wed, 03 Jul 2019 19:03:07 +0300
Message-ID: <87k1czt8as.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> > Does not apply to my tree :(
>> 
>> It's the same one as the one in the fixes series. I just put it here for
>> completeness.
>
> to be extra sure it was really applied?  that's funny...

It's also a pull request based on 5.2-rc1. I don't know any other ways
to do it. Oh, yes, it's also explicitly mentioned in the cover letter.

Thanks,
--
Alex
