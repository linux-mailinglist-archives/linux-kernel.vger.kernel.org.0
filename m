Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9017A8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfG3Mp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:45:26 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:12097
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfG3Mp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnipSeZ1TwdqRUp/Ibef4dS5jP4UljSoyudXEEnO5tgaImHr5lHsIyRedQcyMBX4XFrMqlQiyFUI00wVe9BAzpPYSlT088BMtOdnd1SkKYI+OsrUYrqtVj7z463YpjoRkuFVlo4JMhhweqRD0o7dNbT5ZoKWqa/uncOmFLsKglUlhcJTTRsDD4pgxVaSzZ+H7ZWTfj6/zEHjwBugMFTYhuB89Luxl0Hvcybx5u34w7FxpS8RhR5yIvWgdLwuRPVeD0d7jc96nX93WBdFwjMvARTSdCUsSuY3s8XAj6xfkpLKVsN+R7oTMp+rsLJb9hHTLsGvlxNHPH4hcAgiR16qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/7vNZNyn0FFqNh/w4tptPQMmYuaBbYryJLl0cm5OSs=;
 b=GR8k4UpgU3efvLqhu8oP2HbayFELnTVwG7NIIG4dElgbsIoYa1tcvM4x6Lx1X075HaBcnh16C/BJJBVERtyA0WueBSugC+NiIy5jSz3ahY2cPKPEMZPBUo8FOdc0T1zLnz7Rgc2Z8gJAhWyiVPhUxkgmO3T1m2onejKS35fizhpwlJ4U4i71dItCrpFQm43u5is+XeMS0lM16Y6DdMraawirimrv6Pbny0quyLzBc42YqaX31CI3KPQGfKobZzlNbXdKZNK62Mj+a0dUpgRr6qUNMGMTJzoasPcPJLhLbpIVqR3Bwgo+pj7G6w3oRUtav2sfiPnIN1UOtnUAvMPCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/7vNZNyn0FFqNh/w4tptPQMmYuaBbYryJLl0cm5OSs=;
 b=lDS1eMZ7JgJr9CBXo7YnbnVEURymCctyuXe0JKzpRumJW0NXHHTTxukdVIGpzSWATMvA0ypSfms9Q9IPzQ23oN7kLO0PZ6/cGnDzfL+wFUBX1YXHvEgE6fsN9eZ/hx8sKbKpSrzJho6j/VQIiU4YaXW4iMjJnmNaPiso+y9hQM0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6079.eurprd05.prod.outlook.com (20.178.204.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 12:45:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 12:45:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/13] mm: remove the unused vma argument to
 hmm_range_dma_unmap
Thread-Topic: [PATCH 05/13] mm: remove the unused vma argument to
 hmm_range_dma_unmap
Thread-Index: AQHVRpr6u0kOQaNySU6qr8LRJOBbn6bjHBGA
Date:   Tue, 30 Jul 2019 12:45:22 +0000
Message-ID: <20190730124517.GE24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-6-hch@lst.de>
In-Reply-To: <20190730055203.28467-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55501426-92a3-498b-08b1-08d714ebc934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6079;
x-ms-traffictypediagnostic: VI1PR05MB6079:
x-microsoft-antispam-prvs: <VI1PR05MB60795EB36AC26291165643D4CFDC0@VI1PR05MB6079.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(36756003)(3846002)(6116002)(305945005)(7736002)(76176011)(2906002)(4326008)(102836004)(6436002)(186003)(6916009)(478600001)(7416002)(316002)(71190400001)(229853002)(71200400001)(26005)(14454004)(446003)(11346002)(52116002)(25786009)(54906003)(6506007)(6486002)(256004)(6512007)(33656002)(53936002)(6246003)(66946007)(66556008)(64756008)(81166006)(81156014)(8936002)(1076003)(8676002)(476003)(386003)(486006)(2616005)(5660300002)(4744005)(66476007)(66446008)(99286004)(68736007)(66066001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6079;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wApwXHSaZLo6Bej8GHUpHxofhQJqUdBaqEIIrGPYuB4TX/9bwFevZGwg5WoGakIPJh2DRaQCY1+1pqemO6g8GWj/tAV9n5OGoC65RJjgsVDRpPnMZH9FzvjI575dntSPJnyBeeAqfrsR6xbzD4DI+JYRT0jjZO511rYBO1tkL4YspouD3qDdhfzELBOdpYwc6vfJzQkP06xwQATk/C/D0MkCzu6cG9CP/Livzu7o6kHh85TvZoY/t55fuMCj3g5fWbKnLToGhgTcO4LfEJlJYRp5H8Grim9/eSB53A+OzJIHXP0C8BRmOGvAHJNBmvdEyChJgb2EvTzCmtrygnOPu2OJfclfnxZBR5JSRgcxEdH8V+wjL87n9hhnV4n/BM5kzUyUPwdZmIZLvA5idTQgmnk/2w+FJSehxJc1TEG0IK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5AEF0910AD27734B9CD8F3EB448FDE35@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55501426-92a3-498b-08b1-08d714ebc934
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 12:45:22.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:51:55AM +0300, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  include/linux/hmm.h | 1 -
>  mm/hmm.c            | 2 --
>  2 files changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Unclear what this was intended for, but I think if we need to carry
information from the dma_map to unmap it should be done in some opaque
way.

The driver should not have to care about VMAs, beyond perhaps using
VMAs to guide what VA ranges to mirror.

Jason
