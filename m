Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3540713452
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfECUKF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 May 2019 16:10:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:30440 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfECUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:10:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 13:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="147977325"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 13:10:04 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.144]) with mapi id 14.03.0415.000;
 Fri, 3 May 2019 13:10:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, lkp <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: RE: ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
Thread-Topic: ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
Thread-Index: AQHVAesiwXBVEEk8+0alg+2byGx5m6ZZ0/yw
Date:   Fri, 3 May 2019 20:10:03 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E91BA9B@ORSMSX104.amr.corp.intel.com>
References: <201905032019.tzlqufi0%lkp@intel.com>
 <4e48dcb2-6e82-4bbe-3920-e1c5fd5c265a@infradead.org>
In-Reply-To: <4e48dcb2-6e82-4bbe-3920-e1c5fd5c265a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTg3MzE1NjEtMmFmNi00ZGNkLWI4YzYtYzBjNjQxZjY5Y2FkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQVdwaHcrZndVR3IyNXBCeDNnS3BjU0pMYzVwVGFxOW1uTXR0ZFl5TG8yMEhzS05tRlBaT3F6ZkpMSWlTRFM2eiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap [mailto:rdunlap@infradead.org] 
>>    ERROR: "paddr_to_nid" [drivers/block/brd.ko] undefined!
>>    ERROR: "paddr_to_nid" [crypto/ccm.ko] undefined!
>> 
>
> ---
> Exporting paddr_to_nid() in arch/ia64/mm/numa.c fixes all of these build errors.
> Is there a problem with doing that?

I don't see a problem with exporting it.

-Tony
