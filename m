Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D16172C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 00:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgB0XyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 18:54:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729849AbgB0XyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:54:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RNou3X025692
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 18:54:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepwhhm7w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 18:54:18 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 27 Feb 2020 23:54:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 23:54:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RNs8gE58785962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 23:54:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AAE1AE053;
        Thu, 27 Feb 2020 23:54:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23141AE04D;
        Thu, 27 Feb 2020 23:54:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 23:54:08 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1B0AAA01F5;
        Fri, 28 Feb 2020 10:54:03 +1100 (AEDT)
Subject: Re: [PATCH v3 14/27] powerpc/powernv/pmem: Add support for Admin
 commands
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Date:   Fri, 28 Feb 2020 10:54:06 +1100
In-Reply-To: <cf2b3037-6436-1244-e125-c95542528823@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
         <20200221032720.33893-15-alastair@au1.ibm.com>
         <c88a3808-3ce9-ff6c-b963-ca9317092145@linux.ibm.com>
         <cf2b3037-6436-1244-e125-c95542528823@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022723-0012-0000-0000-0000038AF4A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022723-0013-0000-0000-000021C79F6E
Message-Id: <6e30afc320853cd0780643049d17c60de89165fc.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_08:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=744
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 19:27 +1100, Andrew Donnellan wrote:
> On 27/2/20 7:22 pm, Andrew Donnellan wrote:
> > > +int admin_command_request(struct ocxlpmem *ocxlpmem, u8 op_code)
> > > +{
> > > +    u64 val;
> > > +    int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, 
> > > GLOBAL_MMIO_CHI,
> > > +                     OCXL_LITTLE_ENDIAN, &val);
> > > +    if (rc)
> > > +        return rc;
> > 
> > Ignoring the value here expected, you're just trying to verify that
> > you 
> > don't see an error on the read?
> 
> I see that in the next patch, in ns_command_request() you check that 
> NSCRA is 1 - did you mean to check that ACRA = 1 here?
> 
> 

I was in one version, but that was causing problems in startup since
there was successful prior command to assert ACRA.

I should remove the NSCRA check too.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

