Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAA1683F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBUQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 11:47:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgBUQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:47:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LGigIr011113;
        Fri, 21 Feb 2020 11:47:44 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubym7gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 11:47:43 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01LGj8b7004900;
        Fri, 21 Feb 2020 16:47:42 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2y68976dqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 16:47:42 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LGlgtk50856246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:47:42 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423F6124053;
        Fri, 21 Feb 2020 16:47:42 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E774124054;
        Fri, 21 Feb 2020 16:47:42 +0000 (GMT)
Received: from localhost (unknown [9.41.179.160])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 16:47:42 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v2 3/5] powerpc/pseries: Account for SPURR ticks on idle CPUs
In-Reply-To: <1582262314-8319-4-git-send-email-ego@linux.vnet.ibm.com>
References: <1582262314-8319-1-git-send-email-ego@linux.vnet.ibm.com> <1582262314-8319-4-git-send-email-ego@linux.vnet.ibm.com>
Date:   Fri, 21 Feb 2020 10:47:41 -0600
Message-ID: <87ftf3ubte.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=879 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> +static inline void snapshot_spurr_idle_entry(void)
> +{
> +	*this_cpu_ptr(&idle_entry_spurr_snap) = mfspr(SPRN_SPURR);
> +}
> +

[...]

> +static inline void update_idle_spurr_accounting(void)
> +{
> +	u64 *idle_spurr_cycles_ptr = this_cpu_ptr(&idle_spurr_cycles);
> +	u64 in_spurr = *this_cpu_ptr(&idle_entry_spurr_snap);
> +
> +	*idle_spurr_cycles_ptr += mfspr(SPRN_SPURR) - in_spurr;
> +}

[...]

> +static inline u64 read_this_idle_spurr(void)
> +{
> +	/*
> +	 * If we are reading from an idle context, update the
> +	 * idle-spurr cycles corresponding to the last idle period.
> +	 * Since the idle context is not yet over, take a fresh
> +	 * snapshot of the idle-spurr.
> +	 */
> +	if (get_lppaca()->idle == 1) {
> +		update_idle_spurr_accounting();
> +		snapshot_spurr_idle_entry();

This samples spurr twice when it could do with just one. I don't know
the performance implications, but will the results be coherent?
