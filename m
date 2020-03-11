Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B241181E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCKQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:36:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58034 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbgCKQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:36:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FB2E43B75;
        Wed, 11 Mar 2020 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583944568; bh=QY54OvyEORnwNXGGs5dbPDvosroT2dVspYOudcgf+eI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q6WzN/57/LSjKPiDNt7elhBFEzjz6qvB7rYpAyhsEDJJZfN0gZriIe1mvev+OnjI+
         hjsHS0DyqF8863mQLvNnpG/2NTu5WeIaPhd56GBK/Y8FFEfODORlsuco5ZLkxtjthW
         beBc6lGDG7oazr+CBvGagT2UugvSL+Oe9KkrZfiUfznkMqz+YPGqk9mYHvOwFvLkC1
         II+wRU1OmUcRJ3L6PgYMsb8QbjJRzjFrtrWwlQHmDZpwbzoUPGDOwQP78b5VkEmjMO
         5ieJsHDMkgSEqvoHUn+eXuuxncuKBtiyPFq5/5WMGkQeOE9XhuJ4Nf2LVH4WqYCJd3
         eD6oaexBSdEsA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 416D4A0085;
        Wed, 11 Mar 2020 16:36:03 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 09:35:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 09:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO6Tagy03tAOxzivU0gwhlPiZrjrT1rjB7siYXRTaJiLE73IeeB2WooHv4sNTQ20HnqV9eA1pnoVE2WtzO17P+jcLlgwXhds9lT+x8JVsGMikA5015uLsKH7V/4H3vPhsxCl5W451G3exVmgcptNztDuK9XelxQZoNF9KZeDB4noM+fDp79ZU7EEz/nbivciqhWI7Tpewcyh9eAMwm1aQysrQA1H+PRAUa4yG6Vf7OZbqLNazbuPUQgk9f2pU+WMvulflvJDAlsbSbKa7gmRa/EepCAyRFecCFzCtYf2QqkRSzyHyAUcUfICkUKoaPXAzNgj/df/DrvQoF20224bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY54OvyEORnwNXGGs5dbPDvosroT2dVspYOudcgf+eI=;
 b=KbiAjO0vx8eOuhf0mYjHhJz6rh5K7IGLlBf8qhT7Vg2EzhSYNijRHWarWSUDhf+qeQ1glaX31L0FX6GzNjh6zfsS4kmmxE/NNh9nhRjV7IoUDAvGG33sNbMPB5OyRlrriApAFI64/HyvFT9ZSX2zNt9LC8xuCIV3LWHXXdhLpnHTErE77wFZqyi1BIQve6xRXUjL/9+6IAqWJc+8wSCYp89cPxH3N9vP4GCt1VnDnhBRpU+1BGb88Ok+u18IuScww7fqPU783ZWs5x412PSks8bmYD4uMmcsk/3v7ttHRMzOD/yOtg4yjeGhwQTeEmBWx50BFE5YDMAo3f5iz9uRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY54OvyEORnwNXGGs5dbPDvosroT2dVspYOudcgf+eI=;
 b=mGYEb8osrknZaNr4SRieTQLfeQdc+Tc9CBQ7pBl+m0w4PD25CVyaO9BKIeKeppLsvqsRCqIOC0PnlUeRHv5diC430OIUtxDmikId2jcJMICZYGWwKPuza/4jhypSt83p5au3bWa91J/Mvi4Tqpnh7WHfGnkkbxiig1V8Ue1ykbE=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 16:35:41 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 16:35:41 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARC: define __ALIGN_STR and __ALIGN symbols for ARC
Thread-Topic: [PATCH 1/2] ARC: define __ALIGN_STR and __ALIGN symbols for ARC
Thread-Index: AQHV98Hzr2RKMRF2AkWZBgFmQdoYxqhDlq8A
Date:   Wed, 11 Mar 2020 16:35:40 +0000
Message-ID: <e7b583c8-6189-cf4d-1df5-402fdc2e896c@synopsys.com>
References: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84284cb7-770b-40cc-6f7d-08d7c5da3cdb
x-ms-traffictypediagnostic: BYAPR12MB2949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2949E87965CDBCEE11D511C9B6FC0@BYAPR12MB2949.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:179;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(6512007)(26005)(6486002)(478600001)(186003)(4326008)(53546011)(6506007)(4744005)(64756008)(66446008)(2616005)(110136005)(316002)(8676002)(36756003)(76116006)(66476007)(5660300002)(66556008)(66946007)(31686004)(71200400001)(54906003)(86362001)(107886003)(81166006)(2906002)(81156014)(31696002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2949;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGZuq7zzyPE1dflA9gS+BCe62o/4F122ELgn+QzJhaw8d54dSkAlQdEeXwGsnTACHKNfN+CltzLI1gTktkbr9SYriSlX78jf6QI9paqFj+jF64Os0GZDqx5YZhC1y38syDtHxWpgoLuL7Gp+g2P1o9Jy83vd/lJmhxmDbiclBvQv1mUy+B2qELDreKWTHwfbpVvWgqPlFg80J4yPGAOGZx0YpChVdnolu/BMyrnpA4HNfzrO2eiNQ1zElXsfTpRHdfzi3PFeZX5Ell53v8Y+A+/GaNaSMEie5Uqyrv69a9YgkY0oOgK0XQ+2J3sZslD1ng6WxvXB6yagZJWgJRKSRVLgcRgp4KLkOtvMVqYNMQW+Cf8ZsO6qIC8f2AiFVC3iS0HgQzwISTDVX/uwXSlYKEnzzvMUytobVE3X/gDi+mt1I/8BHGyQlzacZOofdly1
x-ms-exchange-antispam-messagedata: TeDcsRzTBBc4hJU7JSStCOi4Caa7by9V9y0RLmPEs0Zb7YLlyunBAGG3zdxE4L+YFgL7dyhdfI3jKHq2crk2eyXICN0nE4IeXgvCARyjP7U1v9zzybzuS2/j+w2mAmmy9OUQHGfJ5x6Ncbf1dcL2YQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FF97FDEE15A044FA388AB0F0025DDC9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84284cb7-770b-40cc-6f7d-08d7c5da3cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 16:35:40.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dqtzltia8/GUYY2b79n8Ot+B5bVcTUAT48pvfSdnlG0J3DsskR/wgivdLVhikQpeaekFHFQ6dmg+DED2IwpM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xMS8yMCA5OjI2IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IEFzIG9mIHRvZGF5
IEFSQyB1c2VzIGdlbmVyaWMgX19BTElHTl9TVFIgYW5kIF9fQUxJR04gc3ltYm9sDQo+IGRlZmlu
aXRpb25zIGZyb20gImluY2x1ZGUvbGludXgvbGlua2FnZS5oIg0KPiBUaGV5IGFyZSBkZWZpbmVk
IHRvICIuYWxpZ24gNCwweDkwIiB3aGljaCBpbnN0cnVjdGVkIHRoZSBhc3NlbWJsZXINCj4gdG8g
dXNlIGAweDkwYCBhcyBhIGZpbGwgYnl0ZSB3aGVuIGFsaWduaW5nIGZ1bmN0aW9ucyBkZWNsYXJl
ZCB3aXRoDQo+IEVOVFJZIG9yIHNpbWlsYXIgbWFjcm9zZXMuIFRoaXMgbGVhZHMgdG8gZ2VuZXJh
dGVkIHdlaXJkIGluc3RydWN0aW9ucw0KPiBpbiBjb2RlICh3aGVuIGFsaWdubWVudCBpcyB1c2Vk
KSBsaWtlICJsZGhfcyByMTIsW3IwLDB4MjBdIiB3aGljaCBpcw0KPiBlbmNvZGVkIGFzIDB4OTA5
MCBmb3IgQVJDdjIuDQo+IA0KPiBMZXQncyB1c2UgIi5hbGlnbiA0IiB3aGljaCBpbnNlcnQgYSAi
bm9wX3MiIGluc3RydWN0aW9uIGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5
IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQoNCkFja2VkLWJ5OiBWaW5l
ZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+DQoNCi1WaW5lZXQNCg==
