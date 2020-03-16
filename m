Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5E18667B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgCPIa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 04:30:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22328 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730016AbgCPIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:30:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02G8T6YD013740;
        Mon, 16 Mar 2020 09:29:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=8nMlRxmN5baWZgzUmvsSZlYv+VfEDARb0wSFE+28hXU=;
 b=OJTG1tshh9X+qh0I42QrmP/eOuoAY7WEu3S/Em26m7zUIbuBJXRfUwjord8ZlyCJ3QiP
 4953+wA2MUib5c5GHQJ2uTaLXGMMU0JYA+2wkOyBq1seNlmdrf08eaNEFyW13/WlZNlb
 PSfRDzycorHVuRhwF/C5il1qIPb3NGDadLdXqjTaNJJvRhwc+2SNIhvrH/EGy1Az4mUW
 8iPOHrBaf0dSCKH0mgWntSZ/G7HHWK89GLq3l8nbsNhjmWZfxcxxVrjA1gnaw52XYyg8
 GpJde/IYPcqSkb5Emw6KGOuQSmG6lEPYuaYoMPWM1l9gdvNVakC++v1XePUsggCwpbPd Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yrqa9eg7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 09:29:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9951F100034;
        Mon, 16 Mar 2020 09:29:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8937221F69F;
        Mon, 16 Mar 2020 09:29:09 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Mar
 2020 09:29:09 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 16 Mar 2020 09:29:09 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "emil.l.velikov@gmail.com" <emil.l.velikov@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm: context: Clean up documentation
Thread-Topic: [PATCH v2] drm: context: Clean up documentation
Thread-Index: AQHV86IlY8aNA09sqkOaxF062PvymKg7VwuAgA+K2QA=
Date:   Mon, 16 Mar 2020 08:29:09 +0000
Message-ID: <047d1e59-3cfd-bc9f-c439-e7d1ed60a284@st.com>
References: <20200306102937.4932-1-benjamin.gaignard@st.com>
 <20200306102937.4932-4-benjamin.gaignard@st.com>
 <20200306110817.GZ2363188@phenom.ffwll.local>
In-Reply-To: <20200306110817.GZ2363188@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4E0238D45A9B843A29C43E93EA61EA8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_02:2020-03-12,2020-03-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvNi8yMCAxMjowOCBQTSwgRGFuaWVsIFZldHRlciB3cm90ZToNCj4gQWNrZWQtYnk6
IERhbmllbCBWZXR0ZXI8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4NClRoZSBzZXJpZXMgaGFzIGJl
ZW4gcHVzaGVkIG9uIGRybS1taXNjLW5leHQuDQoNClRoYW5rcywNCg0KQmVuamFtaW4NCg==
