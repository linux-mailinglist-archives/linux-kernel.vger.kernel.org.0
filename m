Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF3963E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHTPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:14:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:16415 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfHTPOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:14:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 08:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="180727123"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2019 08:14:23 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 3/4] intel_th: pci: Add support for another Lewisburg PCH
In-Reply-To: <20190820114426.GB15112@kroah.com>
References: <20190820101653.74738-1-alexander.shishkin@linux.intel.com> <20190820101653.74738-4-alexander.shishkin@linux.intel.com> <20190820114426.GB15112@kroah.com>
Date:   Tue, 20 Aug 2019 18:14:22 +0300
Message-ID: <877e773m41.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Aug 20, 2019 at 01:16:52PM +0300, Alexander Shishkin wrote:
>> Add support for the Trace Hub in another Lewisburg PCH.
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>>  drivers/hwtracing/intel_th/pci.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> same here, ok for stable?

Yes for both. Should I resend?

Regards,
--
Alex
