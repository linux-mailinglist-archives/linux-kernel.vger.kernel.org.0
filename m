Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417C01B25D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 11:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfEMJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 05:08:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36564 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbfEMJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:08:42 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D91WUA018957;
        Mon, 13 May 2019 11:08:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=7JfNU5hJZeQI2Z2irz+/r2driLkYKCI2Dra2gHoDtvI=;
 b=itIjo/afThYHPF2GIwWuBAyRGwqOdxpRmm8UPpJFAXyUiqZhnZj97937Q2B5jJ1PFgYa
 gKYgmepUm4JmpFB6sYAbCeUgq6E008IA9GRPIsm1T765l4q6Q49LiPFDR9wrVPFq4mko
 VXsmRt1DMFi1VwJ4FOwpyXNr4BHKAeOvCZmPPiah0/akHF1fZMEpUN3ZBKGV6nHxA0l9
 kil7oVkCFw0FJEYeBW/X8hReAil5HWvO9R2teQXfYLklQkFuJ1yznXykUIhwV22nRR4X
 NafbNHwNeaGjAtyw2Ndmxuox0eSbyFhysmE9jj3Udx6yAXlsjdRIYnIu88Mww073VSVo 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sdn9fhxub-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 11:08:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31B9646;
        Mon, 13 May 2019 09:08:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 199801629;
        Mon, 13 May 2019 09:08:33 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 May
 2019 11:08:32 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 13 May 2019 11:08:32 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH v2] hwspinlock: ignore disabled device
Thread-Topic: [PATCH v2] hwspinlock: ignore disabled device
Thread-Index: AQHU1c+IbaR/OFm2ZUewPczzg3JWJaZpCbkA
Date:   Mon, 13 May 2019 09:08:32 +0000
Message-ID: <f9baeb01-5610-8a4c-c355-20beeb6d6ec7@st.com>
References: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1557BEA9C8793C47916CB14CC25127BC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQpHZW50bGUgcmVtaW5kZXINCg0KDQpGYWJpZW4NCg0KT24gMDgvMDMvMjAxOSA1OjUz
IFBNLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+IERvIG5vdCB3YWl0IGZvciBod3NwaW5sb2Nr
IGRldmljZSByZWdpc3RyYXRpb24gaWYgaXQgaXMgbm90IGF2YWlsYWJsZQ0KPiBmb3IgdXNlLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5j
b20+DQo+IC0tLQ0KPiBWMjogdXNlICdnb3RvIG91dCcgaW5zdGVhZCBvZiAncmV0dXJuJw0KPg0K
PiAgIGRyaXZlcnMvaHdzcGlubG9jay9od3NwaW5sb2NrX2NvcmUuYyB8IDUgKysrKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2h3c3BpbmxvY2svaHdzcGlubG9ja19jb3JlLmMgYi9kcml2ZXJzL2h3c3BpbmxvY2svaHdzcGlu
bG9ja19jb3JlLmMNCj4gaW5kZXggMmJhZDQwZC4uZDgwNjMwNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9od3NwaW5sb2NrL2h3c3BpbmxvY2tfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvaHdzcGlu
bG9jay9od3NwaW5sb2NrX2NvcmUuYw0KPiBAQCAtMzMzLDYgKzMzMywxMSBAQCBpbnQgb2ZfaHdz
cGluX2xvY2tfZ2V0X2lkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGludCBpbmRleCkNCj4gICAJ
aWYgKHJldCkNCj4gICAJCXJldHVybiByZXQ7DQo+ICAgDQo+ICsJaWYgKCFvZl9kZXZpY2VfaXNf
YXZhaWxhYmxlKGFyZ3MubnApKSB7DQo+ICsJCXJldCA9IC1FTk9FTlQ7DQo+ICsJCWdvdG8gb3V0
Ow0KPiArCX0NCj4gKw0KPiAgIAkvKiBGaW5kIHRoZSBod3NwaW5sb2NrIGRldmljZTogd2UgbmVl
ZCBpdHMgYmFzZV9pZCAqLw0KPiAgIAlyZXQgPSAtRVBST0JFX0RFRkVSOw0KPiAgIAlyY3VfcmVh
ZF9sb2NrKCk7
