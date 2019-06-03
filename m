Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746CC32B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFCIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 04:54:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbfFCIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:54:02 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x538kj0E023720;
        Mon, 3 Jun 2019 10:53:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LyyPhatReqGLKi/PCcSu5O/YhgiZr9Sz+nDbhbM+rK4=;
 b=VCTVczIJvcH/pWgjk03S45OQQNhb9hXvPXHOgm6XdHIvyE8ELFeE7RyiOAPBd+A4HJLZ
 xuG6bOLmOo6uiJcU4ZSNzG14BM9kdEefc6ujNMzeW1cB7uNJOzu4p+X9MXEl0J2FOqug
 ejMMvkVYynDIN0CZYqZTTMnOVVKvyOsVtSszxjUn5LcFVeUnH3JOm95FhTpWPv+BUUg7
 MzugWFyiBb14ZLExqUu1s2zpk4Yj27kvg/PDlFFKxXuB+oON99GJCGGNg/1INqqN+x6X
 GUjPEadQ+NupgzPwm+Q9Wnvxgfnikff5iPH762cIpTJ+qwduHEt3t2UpuEbL0KJ408nz 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundrsatg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 10:53:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36DAD41;
        Mon,  3 Jun 2019 08:53:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C09824E0;
        Mon,  3 Jun 2019 08:53:38 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Jun
 2019 10:53:37 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 3 Jun 2019 10:53:37 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] usb: host: ohci-st: Remove set but not used
 variable 'ohci'
Thread-Topic: [PATCH -next] usb: host: ohci-st: Remove set but not used
 variable 'ohci'
Thread-Index: AQHVFVrzjV/9bR1gikG80K9mZOB/gaaJh2sA
Date:   Mon, 3 Jun 2019 08:53:37 +0000
Message-ID: <0a4ed9eb-6da2-60c7-cf70-192b8ab64286@st.com>
References: <20190528133849.22156-1-yuehaibing@huawei.com>
In-Reply-To: <20190528133849.22156-1-yuehaibing@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0889EC2D451D0848B3C9D310BE562DEB@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gNS8yOC8xOSAzOjM4IFBNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBGaXhlcyBnY2Mg
Jy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL3VzYi9o
b3N0L29oY2ktc3QuYzogSW4gZnVuY3Rpb24gc3Rfb2hjaV9wbGF0Zm9ybV9wcm9iZToNCj4gZHJp
dmVycy91c2IvaG9zdC9vaGNpLXN0LmM6MTM1OjE5OiB3YXJuaW5nOiB2YXJpYWJsZSBvaGNpIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBJdCdzIG5l
dmVyIHVzZWQsIHNvIGNhbiBiZSByZW1vdmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFp
YmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3Qv
b2hjaS1zdC5jIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9vaGNpLXN0LmMgYi9kcml2ZXJzL3VzYi9o
b3N0L29oY2ktc3QuYw0KPiBpbmRleCA5OTI4MDdjOTg1MGEuLjYzOGE5MmJkMmNkYyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9vaGNpLXN0LmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
aG9zdC9vaGNpLXN0LmMNCj4gQEAgLTEzMiw3ICsxMzIsNiBAQCBzdGF0aWMgaW50IHN0X29oY2lf
cGxhdGZvcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBy
ZXNvdXJjZSAqcmVzX21lbTsNCj4gIAlzdHJ1Y3QgdXNiX29oY2lfcGRhdGEgKnBkYXRhID0gJm9o
Y2lfcGxhdGZvcm1fZGVmYXVsdHM7DQo+ICAJc3RydWN0IHN0X29oY2lfcGxhdGZvcm1fcHJpdiAq
cHJpdjsNCj4gLQlzdHJ1Y3Qgb2hjaV9oY2QgKm9oY2k7DQo+ICAJaW50IGVyciwgaXJxLCBjbGsg
PSAwOw0KPiAgDQo+ICAJaWYgKHVzYl9kaXNhYmxlZCgpKQ0KPiBAQCAtMTU4LDcgKzE1Nyw2IEBA
IHN0YXRpYyBpbnQgc3Rfb2hjaV9wbGF0Zm9ybV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpkZXYpDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEoZGV2LCBoY2QpOw0KPiAgCWRldi0+ZGV2
LnBsYXRmb3JtX2RhdGEgPSBwZGF0YTsNCj4gIAlwcml2ID0gaGNkX3RvX29oY2lfcHJpdihoY2Qp
Ow0KPiAtCW9oY2kgPSBoY2RfdG9fb2hjaShoY2QpOw0KPiAgDQo+ICAJcHJpdi0+cGh5ID0gZGV2
bV9waHlfZ2V0KCZkZXYtPmRldiwgInVzYiIpOw0KPiAgCWlmIChJU19FUlIocHJpdi0+cGh5KSkg
ew0KPiANCg0KQWNrZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNv
bT4NCg0KVGhhbmtz
