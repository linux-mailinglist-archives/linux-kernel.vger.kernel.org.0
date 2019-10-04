Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8532CB88E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfJDKoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 06:44:07 -0400
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:9976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDKoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:44:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxTocZUWFfRhVVmsIHdWCmBX5tj4roruJaesk7SbLZipIXGmFN+CzlwWUtoRzPMzGGMkbV6gWMkXNQ2Dbk7xSXdqKRM30GYu1bqJFDziZrV/gO/sQiYp77wczCcZG2lPBRHOr/FGLRMs6CXQ1ye9nVVJ9nrJhORHiqr07wD9uqxCZy8rJBnW/C0sGjAAQfO/l4nlnSWJRLujFfhxP0qKBABlJhRIO/9A8/9JtW0QXq3ja7AHe1ivSZm6DJUo0TYX6k6ABgfJ8Ybm3LPlj44y39LKn1EIoels7ppLpDp2ceuw+27/T+p6/Vc3TVZQziEjYWP70PeGtQAXJQDY9bXS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/mQJO/k/rmf3893dXLk8Sa0gbRtqBcxfBT8shOowbg=;
 b=ACbAc/HRbojY93at5E04uv38dL/vBRNVtAPHwvTXTdcM+wAF+Y2xv7WJp8reWwazi1C0nUNs4sqIBSHD5uzrHklfURh4HUT9hCWtJadfd2wxspQEY09VUHTTe+fMb632tuuk5JuOSwU6KljiQGG64SlJFn8pAqElpTE+/mkZNUM6jOHqjoH0IRxhFwpsBuGcp9PLtxD/tN/nyfR4U6HqXYLqk3y3iE8X0Ru5IfWVaFwRJ8FkrYZ2NupeD+fM6EtV84FcF5SI3fEjIhEbpsGbJyjUs01mOOONL4w8c+xf6kvhIX7Z4Zz/N/PUmqrKiRWjk8PPqBYXd8ZWjSLOPw32TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/mQJO/k/rmf3893dXLk8Sa0gbRtqBcxfBT8shOowbg=;
 b=F1Z27UZTIzXIXhTBNDHbAy2xjyHm7a0buDMslwj/8JC2toQml267Xx5QrfBkR/JCzle0pAEW+YowvIJmg305cIzbyTdMFR9l8il9s/EvD3Q042mb7UxetZzQfzyB5U5ozqCheA4rOcfRwbsbRSUdmPID9iQd2uQ1pWOY/Myqnlg=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1881.namprd12.prod.outlook.com (10.175.89.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Fri, 4 Oct 2019 10:44:05 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e%10]) with mapi id 15.20.2327.023; Fri, 4 Oct 2019
 10:44:04 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Nirmoy Das <nirmoy.aiemd@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Das, Nirmoy" <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix memory leak
Thread-Topic: [PATCH] drm/amdgpu: fix memory leak
Thread-Index: AQHVepz+9tzYVi1V60uU+pu6QVo02qdKTAYA
Date:   Fri, 4 Oct 2019 10:44:04 +0000
Message-ID: <62ea397d-2847-04d7-3c50-6292255845c5@amd.com>
References: <20191004101746.19574-1-nirmoy.das@amd.com>
In-Reply-To: <20191004101746.19574-1-nirmoy.das@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:207:5::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cde7c69-ff22-470f-c266-08d748b7c6ab
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18813AC4BDBCD2DD39AAF5E1839E0@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(2616005)(102836004)(186003)(46003)(86362001)(476003)(316002)(31696002)(25786009)(31686004)(52116002)(65806001)(65956001)(76176011)(305945005)(7736002)(2906002)(6636002)(8936002)(11346002)(6116002)(386003)(110136005)(6506007)(54906003)(58126008)(99286004)(446003)(81156014)(8676002)(81166006)(66946007)(66476007)(64756008)(36756003)(66556008)(229853002)(66446008)(6512007)(6436002)(71200400001)(14444005)(71190400001)(256004)(6486002)(6246003)(5660300002)(4326008)(486006)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1881;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lD7+aUXWEMo66utYUlRgjKdOBYoewKM2RLOwo8+OMDACRRH7yXIUVHmgUHCazEm+VmuuAb3Fz7fBuF8F5+0MZaT6+97+039FwCsYfM2M/XcP9Cn+YHOftEeMYy99zMJ0BIaminjOoqDgcf5vfpYH9XmFw+3SO9x+BrAB0SHS1ln6kfCVfVqAuoM/pWmjFLYhaImmI6X6g0gZm3NVFVVP/i4JiclRM291jG5D4FYXwzTa1OhzTXsNxp8ExjGU0de4z07Ph3wOrTumCt9aeTl3tu4G5PR3SQudegDQnUTxwg1YuiOEg0nNfHGzuh4Mhv3JXtoDGa2vp011sElJODB+4uwjkUtyvnpjgiyYqB8//tGREfa5SsAaxT9Nm0E3j0REoqZfcKizthfeK6ZNw0KTBTa3AIp3Kdb8UvpVwEEXQcw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B20BF3D7B6B1D743885189EC0902ED9A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cde7c69-ff22-470f-c266-08d748b7c6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 10:44:04.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOFNjBW8LxjVzLujOqShfjNSHnVskjJLttQrQPCi9xxEq1fwlVoeyqPqNEk3u4Bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rmlyc3Qgb2YgYWxsIHBsZWFzZSBzZW5kIG1haWxzIHJlZ2FyZGluZyBhbWRncHUgdG8gdGhlIGFt
ZC1nZnggbWFpbGluZyANCmxpc3QgYW5kIG5vdCBsa21sL2RyaS1kZXZlbC4NCg0KQW0gMDQuMTAu
MTkgdW0gMTI6MTcgc2NocmllYiBOaXJtb3kgRGFzOg0KPiBJbiBhbWRncHVfYm9fbGlzdF9pb2N0
bCB3aGVuIGlkcl9hbGxvYyBmYWlscw0KPiBkb24ndCByZXR1cm4gd2l0aG91dCBmcmVlaW5nIGJv
IGxpc3QgZW50cnkuDQo+DQo+IEZpeGVzOiA5NjRkMGZiZjYzMDFkICgiZHJtL2FtZGdwdTogQWxs
b3cgdG8gY3JlYXRlIEJPIGxpc3RzIGluIENTIGlvY3RsIHYzIikNCj4NCj4gU2lnbmVkLW9mZi1i
eTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMNCj4gaW5kZXggN2JjZjg2YzYxOTk5Li5jM2U1
ZWE1NDQ4NTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9ib19saXN0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jv
X2xpc3QuYw0KPiBAQCAtMjg0LDcgKzI4NCw3IEBAIGludCBhbWRncHVfYm9fbGlzdF9pb2N0bChz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiAgIAkJbXV0ZXhfdW5sb2NrKCZm
cHJpdi0+Ym9fbGlzdF9sb2NrKTsNCj4gICAJCWlmIChyIDwgMCkgew0KPiAgIAkJCWFtZGdwdV9i
b19saXN0X3B1dChsaXN0KTsNCj4gLQkJCXJldHVybiByOw0KPiArCQkJZ290byBlcnJvcl9mcmVl
Ow0KDQpOQUssIHRoYXQgaXMgYSBkb3VibGUgZnJlZS4gVGhlIGJvIGxpc3QgZW50cmllcyBhcmUg
ZnJlZWQgYnkgDQphbWRncHVfYm9fbGlzdF9wdXQoKS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4N
Cg0KPiAgIAkJfQ0KPiAgIA0KPiAgIAkJaGFuZGxlID0gcjsNCg0K
