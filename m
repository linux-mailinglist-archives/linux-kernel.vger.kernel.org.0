Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF768AE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfHME4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 00:56:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfHME4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D4rD84021638
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:56:21 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubneua4ce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:56:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Tue, 13 Aug 2019 05:56:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Aug 2019 05:56:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7D4uGc161210818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 04:56:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6413FAE04D;
        Tue, 13 Aug 2019 04:56:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D03E5AE051;
        Tue, 13 Aug 2019 04:56:14 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.41.101])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Aug 2019 04:56:14 +0000 (GMT)
Date:   Tue, 13 Aug 2019 10:26:11 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 5/5] memremap: provide a not device managed memremap_pages
Reply-To: bharata@linux.ibm.com
References: <20190811081247.22111-1-hch@lst.de>
 <20190811081247.22111-6-hch@lst.de>
 <20190812145058.GA16950@in.ibm.com>
 <20190812150012.GA12700@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812150012.GA12700@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-TM-AS-GCONF: 00
x-cbid: 19081304-0016-0000-0000-0000029E0A31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081304-0017-0000-0000-000032FE1C90
Message-Id: <20190813045611.GB16950@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=344 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:00:12PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 12, 2019 at 08:20:58PM +0530, Bharata B Rao wrote:
> > On Sun, Aug 11, 2019 at 10:12:47AM +0200, Christoph Hellwig wrote:
> > > The kvmppc ultravisor code wants a device private memory pool that is
> > > system wide and not attached to a device.  Instead of faking up one
> > > provide a low-level memremap_pages for it.  Note that this function is
> > > not exported, and doesn't have a cleanup routine associated with it to
> > > discourage use from more driver like users.
> > 
> > The kvmppc secure pages management code will be part of kvm-hv which
> > can be built as module too. So it would require memremap_pages() to be
> > exported.
> > 
> > Additionally, non-dev version of the cleanup routine
> > devm_memremap_pages_release() or equivalent would also be requried.
> > With device being present, put_device() used to take care of this
> > cleanup.
> 
> Oh well.  We can add them fairly easily if we really need to, but I
> tried to avoid that.  Can you try to see if this works non-modular
> for you for now until we hear more feedback from Dan?

Yes, this patchset works non-modular and with kvm-hv as module, it
works with devm_memremap_pages_release() and release_mem_region() in the
cleanup path. The cleanup path will be required in the non-modular
case too for proper recovery from failures.

Regards,
Bharata.

