Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1EAE311
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 06:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfIJEfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 00:35:42 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:18520 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbfIJEfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 00:35:42 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8A4Utge018718;
        Tue, 10 Sep 2019 04:35:27 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uwhce0h5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 04:35:27 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 2440A5C;
        Tue, 10 Sep 2019 04:35:25 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id A4740201FCE44; Mon,  9 Sep 2019 23:35:25 -0500 (CDT)
Message-Id: <20190910043437.021955474@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Mon, 09 Sep 2019 23:34:37 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 0/8] x86/platform/UV: Update UV Hubless System Support
In-Reply-To: <20190905184741.256857552@stormcage.eag.rdlabs.hpecorp.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_04:2019-09-09,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=812
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100041
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

