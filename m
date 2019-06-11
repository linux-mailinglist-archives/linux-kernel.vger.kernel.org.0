Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7473CD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfFKNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfFKNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IWz7rmxRuciLtbVGhKXAvWnIWoY/90SUiu16s3M1vAk=; b=MrxNbxywR2iqrcOnj6vuLsTEy
        tWldvXIf6cyAQENNln9VVSR4c4dc4mq9iq0ZiBlYqT+NEXj/xa2UBqMPcPTLee2+C1rZtOmresAMd
        9gGkT6gOur2Qc6RC+Oxa6POW7rdb4t5F07I3FrP1nk6PNjviQYoLtMO4pfbJnHjbndylgNxjBNurw
        AW8ZdUfhyZCpgV3/X7hjLOpVeYJql4oqa8e7bCRgEFkzPOA1gkLqJbkH4EBK9DX3TjF+x/y7s3Wq6
        UklaPdSaF7ZwsqIR9r/B9v1l2jotkzYTvPMQ9ns3I4dTNnupm+/2zKFMW5t3SNRyWF4o8pIOBGPYF
        lu39j1wOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hahC8-0003JG-TH; Tue, 11 Jun 2019 13:52:12 +0000
Date:   Tue, 11 Jun 2019 06:52:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190611135212.GA4591@infradead.org>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
 <CAFgQCTur5ReVHm6NHdbD3wWM5WOiAzhfEXdLnBGRdZtf7q1HFw@mail.gmail.com>
 <2b0a65ec-4fb0-430e-3e6a-b713fb5bb28f@nvidia.com>
 <CAFgQCTtS7qOByXBnGzCW-Rm9fiNsVmhQTgqmNU920m77XyAwZQ@mail.gmail.com>
 <20190611122935.GA9919@dhcp-128-55.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611122935.GA9919@dhcp-128-55.nay.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:29:35PM +0800, Pingfan Liu wrote:
> Unable to get a NVME device to have a test. And when testing fio on the

How would a nvme test help?  FOLL_LONGTERM isn't used by any performance
critical path to start with, so I don't see how this patch could be
a problem.
