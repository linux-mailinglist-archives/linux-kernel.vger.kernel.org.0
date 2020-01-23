Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6911464D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 10:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 04:50:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbgAWJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:50:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9mC5Q013055;
        Thu, 23 Jan 2020 10:50:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=VwFgZA3ENkr4wIyA31Obvdi/AAKtkni3+KY4rJlzHMs=;
 b=LVsT6ioG6OWPssN+/S4MezG3RsJ7evvEmpBY5yKBRmoyWM1WPp0X6TcfK9zov3b3S3lA
 SOLxChz8C4O/SGFFan4wZwx+LtdyBjvec4V1/j134J2UIDyK54ri6A+LuTJZ+xWQiTYM
 6R8sCHbiNbJHJjvc+kFtMKjyoY7w2TP0jwEfCT81TZA6Aq1R5OHUDz4akunIjVKu/xEO
 q5vO3vDpdZmRusqK9a/Evp81qCKpDEigTEBEpyCpqBt8o5nWLQHIzXr9AEkQIPH/Qey/
 8cgRFs/b7BFSZxPFlvirB6IHS6oHR0iVn3BxEmkjb+AnaIVOaLPrhu7YAhzq5gpjGguA ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1e9hdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:50:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E174C10002A;
        Thu, 23 Jan 2020 10:50:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFF1E210F62;
        Thu, 23 Jan 2020 10:50:15 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jan
 2020 10:50:15 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Thu, 23 Jan 2020 10:50:15 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: check crtc state before enabling LIE
Thread-Topic: [PATCH] drm/stm: ltdc: check crtc state before enabling LIE
Thread-Index: AQHV0EOHho8B9v26AUyqZ6ivXPGugqf387oA
Date:   Thu, 23 Jan 2020 09:50:15 +0000
Message-ID: <f925ddf5-3265-638b-14b9-71b549b5a9ad@st.com>
References: <1579601650-7055-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1579601650-7055-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <82F3CF1E33F8AD498EA79D13D2A5A156@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_01:2020-01-23,2020-01-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpBY2tlZC1ieTogUGhp
bGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCk9u
IDEvMjEvMjAgMTE6MTQgQU0sIFlhbm5pY2sgRmVydHJlIHdyb3RlOg0KPiBGb2xsb3dpbmcgaW52
ZXN0aWdhdGlvbnMgb2YgYSBoYXJkd2FyZSBidWcsIHRoZSBMSUUgaW50ZXJydXB0DQo+IGNhbiBv
Y2N1ciB3aGlsZSB0aGUgZGlzcGxheSBjb250cm9sbGVyIGlzIG5vdCBhY3RpdmF0ZWQuDQo+IExJ
RSBpbnRlcnJ1cHQgKHZibGFuaykgZG9uJ3QgaGF2ZSB0byBiZSBzZXQgaWYgdGhlIENSVEMgaXMg
bm90DQo+IGVuYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyZSA8eWFu
bmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMu
YyB8IDcgKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+IGluZGV4IGMyODE1ZTguLmVhNjU0YzcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zdG0vbHRkYy5jDQo+IEBAIC02NDgsOSArNjQ4LDE0IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZHJtX2NydGNfaGVscGVyX2Z1bmNzIGx0ZGNfY3J0Y19oZWxwZXJfZnVuY3MgPSB7DQo+
ICAgc3RhdGljIGludCBsdGRjX2NydGNfZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZHJtX2NydGMgKmNy
dGMpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbHRkY19kZXZpY2UgKmxkZXYgPSBjcnRjX3RvX2x0ZGMo
Y3J0Yyk7DQo+ICsJc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSA9IGNydGMtPnN0YXRlOw0K
PiAgIA0KPiAgIAlEUk1fREVCVUdfRFJJVkVSKCJcbiIpOw0KPiAtCXJlZ19zZXQobGRldi0+cmVn
cywgTFREQ19JRVIsIElFUl9MSUUpOw0KPiArDQo+ICsJaWYgKHN0YXRlLT5lbmFibGUpDQo+ICsJ
CXJlZ19zZXQobGRldi0+cmVncywgTFREQ19JRVIsIElFUl9MSUUpOw0KPiArCWVsc2UNCj4gKwkJ
cmV0dXJuIC1FUEVSTTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiA=
