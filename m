Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E672E4ED73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFUQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:54:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbfFUQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:54:18 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5LGlGbF024252;
        Fri, 21 Jun 2019 09:53:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VvsHksNZLF+XqxtlMQ+dQRhZKiv/a1cN5esqabVTB9Y=;
 b=lJK6lFexq14EEBEl2J3u2AFuTYHWk7Fb7aRADQBbnHZQGHFoxwOynbI6NSlHeXA5VCXi
 7rgL889o28BLiMVuxVBp8LOFwEMgpJEXr3ukvaM1+WJKRPk6CuHZRa3V6An2ushdkqOM
 KvEQcPMdBNqoY95naEsQ5YMy5zJRr2xxZdw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2t8y02103r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jun 2019 09:53:50 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Jun 2019 09:53:49 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 09:53:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvsHksNZLF+XqxtlMQ+dQRhZKiv/a1cN5esqabVTB9Y=;
 b=d79jD58G7zyQ6TMp1P5BJBGyfMKd4wJtQu3VRyW5nNqHGfoykdS4RirkGTmVZge6Wi/p2+0HhCVdlk5lTkq2IBwXxwdf1IQgoH4P3ek42UdB3RK/38ZmeXnwrN8wpMZIF6UMpvR4moSVpBdpsfn4YUe8o3ftX9s42bBwEMpEw14=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1606.namprd15.prod.outlook.com (10.175.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 16:53:47 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 16:53:47 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>
CC:     Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: aspeed: fix probe error handling
Thread-Topic: [PATCH] soc: aspeed: fix probe error handling
Thread-Index: AQHVJp55uHAZkIOVpUekWsYPxJFeaaakN1kAgAGp2QA=
Date:   Fri, 21 Jun 2019 16:53:47 +0000
Message-ID: <004B5807-847B-454E-A87D-C546D2077B4D@fb.com>
References: <20190619125636.1109665-1-arnd@arndb.de>
 <CACPK8Xe0Ppr8QjPSTPyNSHEbSXvuZLjC04hqP6ATTSystY888w@mail.gmail.com>
In-Reply-To: <CACPK8Xe0Ppr8QjPSTPyNSHEbSXvuZLjC04hqP6ATTSystY888w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:63f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e4480f1-fc5a-4ff2-4671-08d6f6690781
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1606;
x-ms-traffictypediagnostic: CY4PR15MB1606:
x-microsoft-antispam-prvs: <CY4PR15MB1606DB2DD7F50084ED7CE356DDE70@CY4PR15MB1606.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(256004)(71200400001)(53936002)(71190400001)(476003)(6116002)(2616005)(446003)(11346002)(86362001)(5660300002)(6512007)(6486002)(6436002)(478600001)(229853002)(14454004)(54906003)(110136005)(316002)(99286004)(25786009)(305945005)(68736007)(46003)(76116006)(33656002)(91956017)(66556008)(66476007)(66946007)(73956011)(66446008)(186003)(486006)(6246003)(64756008)(36756003)(81156014)(6506007)(7736002)(8936002)(102836004)(76176011)(2906002)(81166006)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1606;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U6vOxUIUMKLtaqnB1/x828xHahpiOPKhy+dQZINlxjzlVRWhii0BhQfhdI1OVoE/MM1qMx3oNxAED4oc1AFrTIGrUn5l9CiuU9LYwbsS3q+vbhFe44/BKqYuO19aUEQNGlUu2wTJrKDjS19/W7ohyBIgUXcm9ZU8INqvEIzPAPOUkQtg0zXffqDlU6jvf01z8ZYCfhtQ2EUYhxH4R1IJc8bYvfQEeFfr7lTzJ4kEFBS8JgWP/8ZiK0aSqUwfGwMbQFnExHa46V3Riq6Vu+PlImEcam0bxkWM3aLGiTD3QqvdYB1MTJwFBgllQC8eSoUYT6ppxxgYpdiQ2vlAMr++6zWYldv7FkjqinqlFpFwd7iRPfpsiAd+OBrTXGwT/vE8ql7I/q/KdtEosKA2S0FzhnE/sYIXyaoLJ9L8zZGHIyM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B429E90CF7D84A4ABAEC89EFBB9E8BDC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4480f1-fc5a-4ff2-4671-08d6f6690781
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 16:53:47.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1606
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDYvMjAvMTksIDE6MjkgQU0sICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5h
dT4gd3JvdGU6DQoNCiAgICBPbiBXZWQsIDE5IEp1biAyMDE5IGF0IDEyOjU2LCBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToNCiAgICA+DQogICAgPiBnY2Mgd2FybnMgdGhhdCBh
IG1pc2luZyAiZmxhc2giIHBoYW5kbGUgbm9kZSBsZWFkcyB0byB1bmRlZmluZWQNCiAgICA+IGJl
aGF2aW9yIGxhdGVyOg0KICAgID4NCiAgICA+IGRyaXZlcnMvc29jL2FzcGVlZC9hc3BlZWQtbHBj
LWN0cmwuYzogSW4gZnVuY3Rpb24gJ2FzcGVlZF9scGNfY3RybF9wcm9iZSc6DQogICAgPiBkcml2
ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmM6MjAxOjE4OiBlcnJvcjogJyooKHZvaWQg
KikmcmVzbSs4KScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQogICAgPg0KICAgID4gVGhlIGRldmljZSBjYW5u
b3Qgd29yayB3aXRob3V0IHRoaXMgbm9kZSwgc28ganVzdCBlcnJvciBvdXQgaGVyZS4NCiAgICA+
DQogICAgPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KICAg
IA0KICAgIFRoYW5rcyBBcm5kLiBUaGlzIGxvb2tzIGxpa2UgaXQgYXBwbGllcyBvbiB0b3Agb2Yg
VmlqYXkncyByZWNlbnQgcGF0Y2g/DQogICAgDQogICAgVGhlIGludGVudCBvZiB0aGF0IGNoYW5n
ZSB3YXMgdG8gbWFrZSB0aGUgZHJpdmVyIHVzYWJsZSBmb3Igc3lzdGVtcw0KICAgIHRoYXQgZG8g
bm90IHdhbnQgdG8gZGVwZW5kIG9uIHRoZSBmbGFzaCBwaGFuZGxlLiBJIHRoaW5rIHRoZSBmaXgg
d2UNCiAgICB3YW50IGxvb2tzIGxpa2UgdGhpczoNCiAgICANCiAgICAtLS0gYS9kcml2ZXJzL3Nv
Yy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmMNCiAgICArKysgYi9kcml2ZXJzL3NvYy9hc3BlZWQv
YXNwZWVkLWxwYy1jdHJsLmMNCiAgICBAQCAtMjI0LDEwICsyMjQsMTEgQEAgc3RhdGljIGludCBh
c3BlZWRfbHBjX2N0cmxfcHJvYmUoc3RydWN0DQogICAgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQ291bGRuJ3QgYWRkcmVz
cyB0byByZXNvdXJjZSBmb3INCiAgICBmbGFzaFxuIik7DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJjOw0KICAgICAgICAgICAgICAgICAgICB9DQogICAgKw0KICAgICsgICAg
ICAgICAgICAgICBscGNfY3RybC0+cG5vcl9zaXplID0gcmVzb3VyY2Vfc2l6ZSgmcmVzbSk7DQog
ICAgKyAgICAgICAgICAgICAgIGxwY19jdHJsLT5wbm9yX2Jhc2UgPSByZXNtLnN0YXJ0Ow0KICAg
ICAgICAgICAgfQ0KICAgIA0KICAgIC0gICAgICAgbHBjX2N0cmwtPnBub3Jfc2l6ZSA9IHJlc291
cmNlX3NpemUoJnJlc20pOw0KICAgIC0gICAgICAgbHBjX2N0cmwtPnBub3JfYmFzZSA9IHJlc20u
c3RhcnQ7DQogICAgDQogICAgDQogICAgVmlqYXksIGRvIHlvdSBhZ3JlZT8NClllcyBKb2VsLiBU
aGFua3MgZm9yIHRoaXMuDQogICAgDQogICAgQ2hlZXJzLA0KICAgIA0KICAgIEpvZWwNCiAgICAN
CiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvc29jL2FzcGVlZC9hc3BlZWQtbHBjLWN0cmwuYyB8
IDEgKw0KICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KICAgID4NCiAgICA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmMgYi9kcml2
ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmMNCiAgICA+IGluZGV4IDIzOTUyMGJiMjA3
ZS4uODExMDlkMjJhZjZhIDEwMDY0NA0KICAgID4gLS0tIGEvZHJpdmVycy9zb2MvYXNwZWVkL2Fz
cGVlZC1scGMtY3RybC5jDQogICAgPiArKysgYi9kcml2ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxw
Yy1jdHJsLmMNCiAgICA+IEBAIC0yMTIsNiArMjEyLDcgQEAgc3RhdGljIGludCBhc3BlZWRfbHBj
X2N0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAgICA+ICAgICAgICAg
bm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9ub2RlLCAiZmxhc2giLCAwKTsNCiAgICA+
ICAgICAgICAgaWYgKCFub2RlKSB7DQogICAgPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhkZXYs
ICJEaWRuJ3QgZmluZCBob3N0IHBub3IgZmxhc2ggbm9kZVxuIik7DQogICAgPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTlhJTzsNCiAgICA+ICAgICAgICAgfSBlbHNlIHsNCiAgICA+ICAgICAg
ICAgICAgICAgICByYyA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2Uobm9kZSwgMSwgJnJlc20pOw0K
ICAgID4gICAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KG5vZGUpOw0KICAgID4gLS0NCiAgICA+
IDIuMjAuMA0KICAgID4NCiAgICANCg0K
