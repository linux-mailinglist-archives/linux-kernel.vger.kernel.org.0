Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732DCAEDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405387AbfIJOrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:47:00 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56276 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbfIJOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:46:40 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEfOGD011585;
        Tue, 10 Sep 2019 14:46:22 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ux8e44e4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:46:22 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 7531971;
        Tue, 10 Sep 2019 14:46:21 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 1E65A201FCF15; Tue, 10 Sep 2019 09:46:21 -0500 (CDT)
Message-Id: <20190910144609.909602978@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:46:09 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/8] x86/platform/UV: Update UV Hubless System Support
In-Reply-To: <20190905184741.256857552@stormcage.eag.rdlabs.hpecorp.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=926 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2019 11:47 AM, Mike Travis wrote:
> 
> These patches support upcoming UV systems that do not have a UV HUB.
> 
> [1/8] Save OEM_ID from ACPI MADT probe
>
> [2/8] Return UV Hubless System Type
    V2: Remove is_uv_hubless define
	Remove leading '_' from _is_uv_hubless

> [3/8] Add return code to UV BIOS Init function
>
> [4/8] Setup UV functions for Hubless UV Systems
>
> [5/8] Add UV Hubbed/Hubless Proc FS Files
    V2: Remove is_uv_hubbed define
	Remove leading '_' from _is_uv_hubbed

> [6/8] Decode UVsystab Info
    V2: Removed redundant error message after call to uv_bios_init.
	Removed redundant error message after call to decode_uv_systab.
	Clarify selection of UV4 and higher when checking for extended UVsystab
	in decode_uv_systab().

> [7/8] Check EFI Boot to set reboot type
>
> [8/8] Account for UV Hubless in is_uvX_hub Ops
    V2: Add WARNING that the is UVx supported defines will be removed.

-- 

