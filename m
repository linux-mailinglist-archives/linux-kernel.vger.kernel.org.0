Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBE9067C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfHPRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:11:12 -0400
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:37529
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbfHPRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxllZOQnU6Aw3flFeguQQpdO2HSDBxCM54/3QtsSJPlkmgBm085JKAYH4T5g0QnYirngaktF6T4TqYJtUWrH0zcHtFMmStVQB3A1Y05O85ZFGu314BiIW5VgaBhpCYe+OkKjY+cBjlhvsOI9LfOFJxvDmhtF580ra9P3H5GK1xXTyqDw7EKPa8wgDuIPyn1XfXhYxK9o/K5xGc1InyzPT9O3WPKSVBae/m943AyUyPHMLB5IdBDYN8sUB46xjow+hO96DH8POG5KtJB6JVw9T620AM3hkwe+d5cBp2oYEIfE1QSNbHdVUPkPdbxO01FIQC6Ge8ARInLFBxsVemmWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWdBC3FlUndlpjTnqFuWvkt45M9W/Mx5e/1DMPvIPcQ=;
 b=C1v3MkmT+Mc77VKqQ0rmOEDUdUfnZM41zoGRlHUYOUggp3xOEA3uOu4W0A6jVLTjcZqQdScQXJ74jLg5ERo/V5iem8IVNAoUfwVO0YNXLg/rWH+RgZRrfqAWz/tYqOSOxv0bVadymNwgLqyrAeagYI159EPY9BCAsdNbzZcuqc4frJisv9ttjV4jg7TLkqniG/lrtifcyEGq+OmXf5i6K9abbH1E8ETkThWSYijkYKU0UGm5TbytfFwShNBXDmS6TBe9Cv/J3mXt26O+95dTEgapDoOjdPnJ6R/sugyUwlZKv+/lvKT1srBYhv6TRbb1S7EUlcGxZrhsvrn8FpDMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWdBC3FlUndlpjTnqFuWvkt45M9W/Mx5e/1DMPvIPcQ=;
 b=flnumRk7YmFcARWxs7E2qqNRhqYcdHYL9XGFs/YL6R7yojafgvTbhAbgeEWl6JpwqU77uu/9RykeCoPBC1pYlaAE+9mxOpeETyBlpxPN/doDj/moU1yhItSiwNbMYfH1Wh7yobTQtYZNlPW470FR2JEjEj+GwDg5i88kqpC3itI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4399.eurprd05.prod.outlook.com (52.133.13.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 16 Aug 2019 17:11:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 17:11:07 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] mm: turn migrate_vma upside down
Thread-Topic: [PATCH 01/10] mm: turn migrate_vma upside down
Thread-Index: AQHVUnY4TvdvZdqG70SoVm3XhXkEbab+BjuA
Date:   Fri, 16 Aug 2019 17:11:07 +0000
Message-ID: <20190816171101.GK5412@mellanox.com>
References: <20190814075928.23766-1-hch@lst.de>
 <20190814075928.23766-2-hch@lst.de>
In-Reply-To: <20190814075928.23766-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d71d9bbf-6941-439b-a290-08d7226cba06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4399;
x-ms-traffictypediagnostic: VI1PR05MB4399:
x-microsoft-antispam-prvs: <VI1PR05MB43991B2F32ECF3B7D641FA44CFAF0@VI1PR05MB4399.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(6512007)(186003)(53936002)(1076003)(305945005)(316002)(7736002)(76176011)(52116002)(66446008)(2906002)(6116002)(8936002)(26005)(2616005)(6246003)(102836004)(229853002)(86362001)(71190400001)(81156014)(81166006)(36756003)(3846002)(8676002)(99286004)(25786009)(66066001)(256004)(4326008)(14454004)(6916009)(6506007)(71200400001)(54906003)(446003)(14444005)(478600001)(386003)(6486002)(6436002)(476003)(66946007)(11346002)(7416002)(66476007)(66556008)(64756008)(486006)(33656002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4399;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bZfAhx1PrhM8Qwxl1AenhVYx9SODIVCdVb5j7JpjsmYK0xydkOGfqkDf/w2L/aNxyNpSDkfcbl/RGcc1+r1xecsmurgHzJJfuIHu4PeaEPue8H4DOGMp3Mj0Mz+BXVOq3oZ8KwhYxrwETnxRNGatDIWEdF4pXLY9eXYEf6K5PC8TdV0uAfa1xTbXXkMbMHRgQBivDMl4KgIAQWvEWdeWsv29/6C2oJcxuiSjI3O7PbdSqnO+0mj5kCwtEPkpwcQTExKB/3SAjBfVG/fXpze4ngKZGed/IFik6N7Mm6h1ijakTz2E3VPD2QI15ZDQgrOQhvf9MIfIVe1mQNnsWN4NgBEYqvkd1ma8EHClWRdWNAFB4UhUqSFofz7dNaKZ/lnWWfFuvBdjuGpYcAJx94UBSFkoBbReFfZMV/S40UR9d0M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <123FCA9276F3AF499F1A0D076B4702FA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71d9bbf-6941-439b-a290-08d7226cba06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 17:11:07.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpw7z2OiF+qhp7lHU29mvPYjoS2OpUn/0Vaks9bMBDaqOfExZNfbcs+QHsrqioEhGPQdpX5x3t6EIPrjPTo5Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:59:19AM +0200, Christoph Hellwig wrote:
> There isn't any good reason to pass callbacks to migrate_vma.  Instead
> we can just export the three steps done by this function to drivers and
> let them sequence the operation without callbacks.  This removes a lot
> of boilerplate code as-is, and will allow the drivers to drastically
> improve code flow and error handling further on.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  Documentation/vm/hmm.rst               |  55 +-----
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 122 +++++++------
>  include/linux/migrate.h                | 118 ++----------
>  mm/migrate.c                           | 244 +++++++++++--------------
>  4 files changed, 195 insertions(+), 344 deletions(-)

The mechanical transformation looks OK, I squashed the below nits in,
let me know if I got it wrong

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 4f81c77059e305..0a5960beccf76d 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -339,9 +339,8 @@ Migration to and from device memory
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Because the CPU cannot access device memory, migration must use the device=
 DMA
-engine to perform copy from and to device memory. For this we need a new t=
o
-use migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
-helpers.
+engine to perform copy from and to device memory. For this we need to use
+migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize() helpe=
rs.
=20
=20
 Memory cgroup (memcg) and rss accounting
diff --git a/mm/migrate.c b/mm/migrate.c
index 993386cb53358d..0e78ebd720c0e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2622,10 +2622,9 @@ static void migrate_vma_unmap(struct migrate_vma *mi=
grate)
  * successfully migrated, and which were not.  Successfully migrated pages=
 will
  * have the MIGRATE_PFN_MIGRATE flag set for their src array entry.
  *
- * It is safe to update device page table from within the finalize_and_map=
()
- * callback because both destination and source page are still locked, and=
 the
- * mmap_sem is held in read mode (hence no one can unmap the range being
- * migrated).
+ * It is safe to update device page table after migrate_vma_pages() becaus=
e
+ * both destination and source page are still locked, and the mmap_sem is =
held
+ * in read mode (hence no one can unmap the range being migrated).
  *
  * Once the caller is done cleaning up things and updating its page table =
(if it
  * chose to do so, this is not an obligation) it finally calls
@@ -2657,10 +2656,11 @@ int migrate_vma_setup(struct migrate_vma *args)
 	args->npages =3D 0;
=20
 	migrate_vma_collect(args);
-	if (args->cpages)
-		migrate_vma_prepare(args);
-	if (args->cpages)
-		migrate_vma_unmap(args);
+	if (!args->cpages)
+		return 0;
+
+	migrate_vma_prepare(args);
+	migrate_vma_unmap(args);
=20
 	/*
 	 * At this point pages are locked and unmapped, and thus they have
