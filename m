Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315067EF98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404452AbfHBIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:48:15 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:11238
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404364AbfHBIsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6eNdhB4pFae1GAxXzoLguI6+Zf7gMKusRdW8W7v7QoLeTHpyPRYxHc0UWEA0U27jxWUUIkMTUQhZg2NQzTMIOVRJlmcYxIsUMrxnNCiL5rGPRFJNr1fzZANyLj0FOD/COuymKw7ZvaENQUxdSYKeyAOj/S8BEPAbzeLqTyx1Ys5ziXWeb8nyW7/JO84fZ22DTLsfYIzquCrGoApygwYg6UeY1Sc5QRbxRsa98f3dBGsOzwM8ErPp+MjdQbpcGDCR4oyXIYFo7cAEMLJBapXp9mqMNUmKiDCwXNNZKiUk1vrYC+4+qOheepv9kUbTUC7Rz0CURfil5Kf4BBaNH/uuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxRdiLzB/7t67WpVjbo9iz9TYpfjet5bWNCCoQuxccM=;
 b=oeehMASACEbrfozQNN0ZEvRIxQpZGFa1vWjSfTp9McLC65AqEV6tPM5615se+mOZTYBvBT1Hirm8YSNOEA6cOcFK7oEPCI2mYXgCDRyHh5G0Zca9mBa9bm7Rnz8tHG37Ko0tBKHlSl1LMmZZ9ho1S3BJbdyO4m/b9cre/lAcRbsvyMTM0/xhQdfvQpwpw7HMab1ZVqLOBjtHJN3CoBolK9HmfNRcnsws6j+v7I6p0lqKiDmx+jl/xYsCO6/r7cR+Mbxw9wemdMZG0HGY60C0gx3oBiRkqG1GM++SAnKy3dsT72cP+A8XeR2uvkrzpFDCz9slsxdmO2W7NlJYL7K/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxRdiLzB/7t67WpVjbo9iz9TYpfjet5bWNCCoQuxccM=;
 b=MBqHuJNDnge64xFWlcdjbhSsxgw0kewMIm83XfrZGUBewgNAO61mJ8hc4DR4aK0bU2/Hg5QGj4OezlwpkSnSOTWXkJICQG07oQC/5gjqq/8Bn0KrKDDhXfvuLYlCqozEQJ9W+gmTiKXhWMGJtmfAofJ9lrVaPxYn6SkBugYYT8M=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.61.13) by
 VI1PR0401MB2638.eurprd04.prod.outlook.com (10.168.65.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Fri, 2 Aug 2019 08:48:10 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::49dc:1671:b13b:e382]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::49dc:1671:b13b:e382%9]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 08:48:10 +0000
From:   Diana Madalina Craciun <diana.craciun@nxp.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jingxiangfeng@huawei.com" <jingxiangfeng@huawei.com>,
        "fanchengyang@huawei.com" <fanchengyang@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>
Subject: Re: [PATCH v3 00/10] implement KASLR for powerpc/fsl_booke/32
Thread-Topic: [PATCH v3 00/10] implement KASLR for powerpc/fsl_booke/32
Thread-Index: AQHVR4IOWsHaCjD120G4pOTxFRhTEA==
Date:   Fri, 2 Aug 2019 08:48:10 +0000
Message-ID: <VI1PR0401MB246349AD76C09D009BB8B5A4FFD90@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190731094318.26538-1-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8580ecb-d6a3-4e09-1fcf-08d71726259b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2638;
x-ms-traffictypediagnostic: VI1PR0401MB2638:
x-microsoft-antispam-prvs: <VI1PR0401MB2638CF4CFD18FC2D07CD8303FFD90@VI1PR0401MB2638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(99286004)(3846002)(14454004)(6116002)(305945005)(71200400001)(476003)(33656002)(478600001)(8676002)(68736007)(81166006)(7736002)(66066001)(25786009)(5660300002)(8936002)(4326008)(71190400001)(2201001)(74316002)(81156014)(86362001)(52536014)(76176011)(7696005)(14444005)(53936002)(486006)(6246003)(91956017)(256004)(26005)(316002)(2906002)(76116006)(446003)(66446008)(102836004)(66946007)(229853002)(6506007)(7416002)(53546011)(66476007)(64756008)(9686003)(110136005)(2501003)(54906003)(66556008)(55016002)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2638;H:VI1PR0401MB2463.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FBxON3gONiO0j3V98Ojb3ldPdouon7x3reTtDPguoRSMNT3+t2EwEZrC4UDa5DmR+mg8zfZZPPO1Wz/zYWuQWpJWFxv7Z+MWObi1Ia6v5eDU5rmXOcW6m05jmgAqW6A1rUXPLogYyz5XSDji36nQE8Ayi/XqWo3vt33A7BZ43CguNqDAhj/NuW+15yXidTArhwLy8jdWWOHuD/FuZrPa0+X/HgKtcanAYXYeSQ7p29xNJAkjRQORk6ulDR0ZAmJhY4ioGzp6ZpKSgbp96xquYczQnZuz9Vo8qZowyocDmEJQrvX08qm8lNy4nVRKPxeIaoekoxn0nTnj2yg4fWL0pUKJHPXbsxOUC8RD6ndCupI6sC3GoHZqe6oAm/3DBXsI2OzhW2YO4hv3IUpMELHJ3qcbMCWgbuMS1rqAEpdL/X0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8580ecb-d6a3-4e09-1fcf-08d71726259b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 08:48:10.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diana.craciun@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except for one comment in patch 06/10: Reviewed-by: Diana Craciun=0A=
<diana.craciun@nxp.com>=0A=
And also: Tested-by: Diana Craciun <diana.craciun@nxp.com>=0A=
=0A=
Regards,=0A=
Diana=0A=
=0A=
On 7/31/2019 12:26 PM, Jason Yan wrote:=0A=
> This series implements KASLR for powerpc/fsl_booke/32, as a security=0A=
> feature that deters exploit attempts relying on knowledge of the location=
=0A=
> of kernel internals.=0A=
>=0A=
> Since CONFIG_RELOCATABLE has already supported, what we need to do is=0A=
> map or copy kernel to a proper place and relocate. Freescale Book-E=0A=
> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1=0A=
> entries are not suitable to map the kernel directly in a randomized=0A=
> region, so we chose to copy the kernel to a proper place and restart to=
=0A=
> relocate.=0A=
>=0A=
> Entropy is derived from the banner and timer base, which will change ever=
y=0A=
> build and boot. This not so much safe so additionally the bootloader may=
=0A=
> pass entropy via the /chosen/kaslr-seed node in device tree.=0A=
>=0A=
> We will use the first 512M of the low memory to randomize the kernel=0A=
> image. The memory will be split in 64M zones. We will use the lower 8=0A=
> bit of the entropy to decide the index of the 64M zone. Then we chose a=
=0A=
> 16K aligned offset inside the 64M zone to put the kernel in.=0A=
>=0A=
>     KERNELBASE=0A=
>=0A=
>         |-->   64M   <--|=0A=
>         |               |=0A=
>         +---------------+    +----------------+---------------+=0A=
>         |               |....|    |kernel|    |               |=0A=
>         +---------------+    +----------------+---------------+=0A=
>         |                         |=0A=
>         |----->   offset    <-----|=0A=
>=0A=
>                               kimage_vaddr=0A=
>=0A=
> We also check if we will overlap with some areas like the dtb area, the=
=0A=
> initrd area or the crashkernel area. If we cannot find a proper area,=0A=
> kaslr will be disabled and boot from the original kernel.=0A=
>=0A=
> Changes since v2:=0A=
>  - Remove unnecessary #ifdef=0A=
>  - Use SZ_64M instead of0x4000000=0A=
>  - Call early_init_dt_scan_chosen() to init boot_command_line=0A=
>  - Rename kaslr_second_init() to kaslr_late_init()=0A=
>=0A=
> Changes since v1:=0A=
>  - Remove some useless 'extern' keyword.=0A=
>  - Replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL=0A=
>  - Improve some assembly code=0A=
>  - Use memzero_explicit instead of memset=0A=
>  - Use boot_command_line and remove early_command_line=0A=
>  - Do not print kaslr offset if kaslr is disabled=0A=
>=0A=
> Jason Yan (10):=0A=
>   powerpc: unify definition of M_IF_NEEDED=0A=
>   powerpc: move memstart_addr and kernstart_addr to init-common.c=0A=
>   powerpc: introduce kimage_vaddr to store the kernel base=0A=
>   powerpc/fsl_booke/32: introduce create_tlb_entry() helper=0A=
>   powerpc/fsl_booke/32: introduce reloc_kernel_entry() helper=0A=
>   powerpc/fsl_booke/32: implement KASLR infrastructure=0A=
>   powerpc/fsl_booke/32: randomize the kernel image offset=0A=
>   powerpc/fsl_booke/kaslr: clear the original kernel if randomized=0A=
>   powerpc/fsl_booke/kaslr: support nokaslr cmdline parameter=0A=
>   powerpc/fsl_booke/kaslr: dump out kernel offset information on panic=0A=
>=0A=
>  arch/powerpc/Kconfig                          |  11 +=0A=
>  arch/powerpc/include/asm/nohash/mmu-book3e.h  |  10 +=0A=
>  arch/powerpc/include/asm/page.h               |   7 +=0A=
>  arch/powerpc/kernel/Makefile                  |   1 +=0A=
>  arch/powerpc/kernel/early_32.c                |   2 +-=0A=
>  arch/powerpc/kernel/exceptions-64e.S          |  10 -=0A=
>  arch/powerpc/kernel/fsl_booke_entry_mapping.S |  23 +-=0A=
>  arch/powerpc/kernel/head_fsl_booke.S          |  55 ++-=0A=
>  arch/powerpc/kernel/kaslr_booke.c             | 427 ++++++++++++++++++=
=0A=
>  arch/powerpc/kernel/machine_kexec.c           |   1 +=0A=
>  arch/powerpc/kernel/misc_64.S                 |   5 -=0A=
>  arch/powerpc/kernel/setup-common.c            |  19 +=0A=
>  arch/powerpc/mm/init-common.c                 |   7 +=0A=
>  arch/powerpc/mm/init_32.c                     |   5 -=0A=
>  arch/powerpc/mm/init_64.c                     |   5 -=0A=
>  arch/powerpc/mm/mmu_decl.h                    |  10 +=0A=
>  arch/powerpc/mm/nohash/fsl_booke.c            |   8 +-=0A=
>  17 files changed, 558 insertions(+), 48 deletions(-)=0A=
>  create mode 100644 arch/powerpc/kernel/kaslr_booke.c=0A=
>=0A=
=0A=
