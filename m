Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949CD105D74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKUXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 18:55:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:11778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:55:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 15:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="219273102"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2019 15:55:49 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Thu, 21 Nov 2019 15:55:49 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVoA1uR0NpEjA1wUmtm7eAgTQzs6eVqSUAgAB0jYCAAAPEAIAAChQAgACPToD//3rs4IAAlEkA//+D1pA=
Date:   Thu, 21 Nov 2019 23:55:49 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4DC3BE@ORSMSX115.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
 <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
In-Reply-To: <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzFiMjk2MmUtOTBlMy00MTEzLTlkMmMtNTc3MjAyZjE2MDJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoienpGdTRZY3VRTytrbGFzSGpYSjJuQVp2cFZqaXpUUkVSUHR5aUxhQ3pLYXNNbWpzZGVBNDAwU2cyUDhHS1puViJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDb3VsZCB3ZSBwYXNzIGl0IHRocm91Z2ggaWYgdGhlIGhvc3QgaGFzIG5vIEhUPyAgRGVidWdn
aW5nIGlzICpzbyogbXVjaCBlYXNpZXIgaW4gYSBWTS4gIEFuZCBIVCBpcyBhIGJpdCBkdWJpb3Vz
IHRoZXNlIGRheXMgYW55d2F5Lg0KDQpTdXJlIC4uLiB3ZSBjYW4gbG9vayBhdCBkb2luZyB0aGF0
IGluIGEgZnV0dXJlIHNlcmllcyBvbmNlIHdlIGdldCB0byBhZ3JlZW1lbnQgb24gdGhlIGZvdW5k
YXRpb24gcGllY2VzLg0KDQotVG9ueQ0K
