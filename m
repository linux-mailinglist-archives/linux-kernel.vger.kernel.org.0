Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5B9A25D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393630AbfHVVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:50:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:48460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfHVVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:50:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 14:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="181526415"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 14:50:11 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 14:50:11 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.103]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.225]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 14:50:11 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Further sanitize INTEL_FAM6 naming
Thread-Topic: [PATCH 0/5] Further sanitize INTEL_FAM6 naming
Thread-Index: AQHVWNVV+ILlzV0Ku0+4gYvgDDuk2acHpY4AgAAMatA=
Date:   Thu, 22 Aug 2019 21:50:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F436273@ORSMSX115.amr.corp.intel.com>
References: <20190822102306.109718810@infradead.org>
 <20190822205312.GA10757@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20190822205312.GA10757@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODc5NWRjNjQtOTZiZC00YzEyLTk1MzctODk2ZWFlM2Y1MjIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieThiWGFQMFY5MnZxWTZldU1JZlFiRGpHM2s5NnlPYXdkNWpQOHprT3BGNmZTb3VFeHRGbXNSek5GbWYwNVl5NiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMb29rcyBsaWtlIHlvdXIgc2NyaXB0cyBkaWRuJ3QgYW50aWNpcGF0ZSB0aGUgQ1BQIGd5bW5h
c3RpY3MgbGlrZToNCj4NCj4gI2RlZmluZSBWVUxOV0xfSU5URUwobW9kZWwsIHdoaXRlbGlzdCkg
ICAgICAgICAgXA0KPiAgICAgICAgVlVMTldMKElOVEVMLCA2LCBJTlRFTF9GQU02XyMjbW9kZWws
IHdoaXRlbGlzdCkNCg0KQWxzbyBJTlRFTF9DUFVfRkFNNigpIG1hY3JvDQoNCi1Ub255DQo=
