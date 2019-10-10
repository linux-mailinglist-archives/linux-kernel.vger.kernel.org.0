Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10BDD3160
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJJT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:28:18 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:58486 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbfJJT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:28:17 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AJLr9G025187;
        Thu, 10 Oct 2019 19:27:44 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2vj9bvsgdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 19:27:44 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id E6E475C;
        Thu, 10 Oct 2019 19:27:43 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 7E30748;
        Thu, 10 Oct 2019 19:27:42 +0000 (UTC)
Date:   Thu, 10 Oct 2019 14:27:42 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH v3 0/2] x86/boot/64: Avoid mapping reserved ranges in
 early page tables.
Message-ID: <20191010192742.GX2113@swahl-linux>
References: <cover.1569358538.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569358538.git.steve.wahl@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_06:2019-10-10,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while on this patch set; two weeks ago Kirill added acks,
no movement since.  Is there anything I need to be doing on my part to
move this forward?

Thanks!

--> Steve Wahl 

On Tue, Sep 24, 2019 at 04:03:22PM -0500, Steve Wahl wrote:
> This patch set narrows the valid space addressed by the page table
> level2_kernel_pgt to only contain ranges checked against the "usable
> RAM" list provided by the BIOS.
> 
> Prior to this, some larger than needed mappings were occasionally
> crossing over into spaces marked reserved, allowing the processor to
> access these reserved spaces, which were caught by the hardware and
> caused BIOS to halt on our platform (UV).
> 
> Changes since v1:
> 
> * Cover letter added because there's now two patches.
> 
> * Patch 1: Added comment and re-worked changelog text.
> 
> * Patch 2: New change requested by Dave Hansen to handle the case that
>   the mapping of the last PMD page for the kernel image could cross a
>   reserved region boundary.
> 
> Changes since v2:
> 
> * Patch 1: Added further inline comments.
> * Patch 2: None.
> 
> Steve Wahl (2):
>   x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area.
>   x86/boot/64: round memory hole size up to next PMD page.
> 
>  arch/x86/boot/compressed/misc.c | 25 +++++++++++++++++++------
>  arch/x86/kernel/head64.c        | 22 ++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 8 deletions(-)
> 
> -- 
> 2.21.0
> 
> 
> -- 
> Steve Wahl, Hewlett Packard Enterprise

-- 
Steve Wahl, Hewlett Packard Enterprise
