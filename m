Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF98A999
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfHLVrl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Aug 2019 17:47:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:39777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHLVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 14:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="376091205"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 14:47:40 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 12 Aug 2019 14:47:40 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.172]) with mapi id 14.03.0439.000;
 Mon, 12 Aug 2019 14:47:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: fix misc compiler warnings in the ia64 build
Thread-Topic: fix misc compiler warnings in the ia64 build
Thread-Index: AQHVUNrz3tU7jFJdt02i8ElKmhqo3ab4DOPA
Date:   Mon, 12 Aug 2019 21:47:40 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F41C3D7@ORSMSX115.amr.corp.intel.com>
References: <20190812065524.19959-1-hch@lst.de>
In-Reply-To: <20190812065524.19959-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjUwZjFhYjgtN2FmZS00MTRiLWJlZTQtODk3OWViMDUxYWZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicnNRS202Q0VRSnFFZjVmV2dLcCtOY2U2QXZkZVNwUjhWaVpINkl0dmo5YlZNenVLMTFiODNkc25DaWM0MktmRSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> this little series fixes various warnings I see in ia64 builds.

Applied. Thanks.

[I assume you are using some up-to-date version of gcc that generates these
 warnings ... I'm not seeing them, but I'm still using a compiler from the stone
 age]

-Tony
