Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AE90872
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfHPTnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 15:43:13 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:48132 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbfHPTnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:43:06 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GJdKOY006064
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=75uUmEH4Q9NaBwE5QK1ZFzvxK4yibdNYpYfkpFIzpC4=;
 b=fypyVilnq9G8t7N2i+28/8NPA6hy/r4Fmz2ZDIRhNegLjFcZn6ULRjoi4GtkZfIkgAOr
 Lp76mtDeR5xHvZrYfbrgVdEmGSDSFVAd+dKYHtZMq4lT9LXRzhbGJyrNDPz1yxBoqxG+
 iS8oTC7icCNEpP4hGFlUb6O5VKohqLLCEGuyYJi6AFjf9LBnS0UTEsvcwabRb0dEcbW3
 ysZp3AznqukCodqVNY3ruSIIsYtr0s9owrNQV/VBlk0N6ze3xAeVLmB/k3s9tmwFuNTi
 g5GprsmqEhtv3d/bkiNnUV4mh8V9NBdFOtyCOzmvxaG/eYuZrhdaT6m9QmYsHNnn4B6Z GA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2ucytb88bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:43:05 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GJcELK046799
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:43:04 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2ue2980g9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:43:04 -0400
X-LoopCount0: from 10.166.135.95
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1454488023"
From:   <Mario.Limonciello@dell.com>
To:     <sagi@grimberg.me>, <kbusch@kernel.org>
CC:     <axboe@fb.com>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ryan.Hong@Dell.com>,
        <Crag.Wang@dell.com>, <sjg@google.com>,
        <Charles.Hyde@dellteam.com>, <Jared.Dominguez@dell.com>
Subject: RE: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Topic: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Index: AQHVUtwQRoMvFWyQNUuquaDdHeAiWqb7Z/MAgAABK4CAAWAOAIABZgWA
Date:   Fri, 16 Aug 2019 19:43:02 +0000
Message-ID: <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
 <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
In-Reply-To: <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-16T19:43:01.0419001Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160199
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDE1LCAyMDE5IDEyOjE5IFBN
DQo+IFRvOiBLZWl0aCBCdXNjaA0KPiBDYzogTGltb25jaWVsbG8sIE1hcmlvOyBKZW5zIEF4Ym9l
OyBDaHJpc3RvcGggSGVsbHdpZzsgbGludXgtDQo+IG52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
TEtNTDsgSG9uZywgUnlhbjsgV2FuZywgQ3JhZzsgc2pnQGdvb2dsZS5jb207DQo+IEh5ZGUsIENo
YXJsZXMgLSBEZWxsIFRlYW07IERvbWluZ3VleiwgSmFyZWQNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gbnZtZTogQWRkIHF1aXJrIGZvciBMaXRlT04gQ0wxIGRldmljZXMgcnVubmluZyBGVw0K
PiAyMjMwMTExMQ0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IA0KPiA+PiBNYXJp
bywNCj4gPj4NCj4gPj4gQ2FuIHlvdSBwbGVhc2UgcmVzcGluIGEgcGF0Y2ggdGhhdCBhcHBsaWVz
IGNsZWFubHkgb24gbnZtZS01LjQ/DQo+ID4NCj4gPiBUaGlzIGZpeGVzIGEgcmVncmVzc2lvbiB3
ZSBpbnRyb2R1Y2VkIGluIDUuMywgc28gaXQgc2hvdWxkIGdvIGluDQo+ID4gNS4zLXJjLiBGb3Ig
dGhpcyB0byBhcHBseSBjbGVhbmx5LCB0aG91Z2gsIHdlJ2xsIG5lZWQgdG8gcmVzeW5jIHRvIExp
bnVzJw0KPiA+IHRyZWUgdG8gZ2V0IFJhZmFlbCdzIFBDSWUgQVNQTSBjaGVjayBhZnRlciBoZSBz
ZW5kcyBoaXMgbGludXgtcG0gcHVsbA0KPiA+IHJlcXVlc3QuDQo+IA0KPiBXZSBuZWVkIHRvIGNv
b3JkaW5hdGUgd2l0aCBKZW5zLCBkb24ndCB0aGluayBpdHMgYSBnb29kIGlkZWEgaWYgSSdsbA0K
PiBqdXN0IHJhbmRvbWx5IGdldCBzdHVmZiBmcm9tIGxpbnVzJyB0cmVlIGFuZCBzZW5kIGFuIHJj
IHB1bGwgcmVxdWVzdC4NCg0KVGhlIGRlcGVuZGVudCBjb21taXQgaXMgaW4gTGludXMnIHRyZWUg
bm93Lg0KNGVhZWZlOGM2MjFjNjE5NWM5MTA0NDM5NmVkODA2MGMxNzlmN2FhZQ0KDQpBbHNvIGl0
IHdhcyByZXBvcnRlZCB0byBtZSBhZnRlciB0aGlzIHdhcyBzdWJtaXR0ZWQgdGhhdCB0aGUgY29t
bWVudA0Kd2hpdGVzcGFjZSBzaG91bGQgaGF2ZSBiZWVuIGFsaWduZWQgZHVyaW5nIHRoZSBzd2l0
Y2hvdmVyIGZyb20gdjEgdG8gdjIuDQoNClYxIHRoZSB3aGl0ZXNwYWNlIHdhcyBmdXJ0aGVyIGxl
ZnQgc2luY2UgaXQgd2FzIGFwcGx5aW5nIHRvIDMgZHJpdmVzLCBidXQgbm93DQp0aGF0IHRoZXkn
cmUgY29tYmluZWQgaW4gdjIgdGhlIHdoaXRlc3BhY2Ugd2Fzbid0IGFkanVzdGVkLg0KDQpMZXQg
bWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byByZXN1Ym1pdCB2MyB3LyB3aGl0ZXNwYWNlIG1vZGlm
aWNhdGlvbiBvcg0KaWYgeW91IHdpbGwgd2FudCB0byBhZGp1c3QgdGhhdCBsb2NhbGx5IHdoZW4g
eW91IHB1bGwgaXQgaW4uDQoNCg==
