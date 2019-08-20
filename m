Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B033896AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfHTUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:52:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14833 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:52:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5c5d7b0000>; Tue, 20 Aug 2019 13:52:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 13:52:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 13:52:11 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:52:11 +0000
Received: from [10.2.161.11] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:52:11 +0000
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
To:     Michal Hocko <mhocko@kernel.org>
CC:     Bharath Vedartham <linux.bhar@gmail.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <jglisse@redhat.com>, <ira.weiny@intel.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <william.kucharski@oracle.com>, <hch@lst.de>,
        <inux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
 <20190819125611.GA5808@hpe.com>
 <20190819190647.GA6261@bharath12345-Inspiron-5559>
 <0c2ad29b-934c-ec30-66c3-b153baf1fba5@nvidia.com>
 <20190820081820.GI3111@dhcp22.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2971c5ea-88f2-0f07-e6f5-ad4108f62816@nvidia.com>
Date:   Tue, 20 Aug 2019 13:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820081820.GI3111@dhcp22.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566334332; bh=U2KQiCj4JLeIQcZ2lUEsNC+lc/DGVG6Kl/YzkvUbakA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RRPZh68HK0DqwjIsnJkt7tPRqljVf2slouND6w1LNdDc9znsw46Ls/TkIOVAAtfn4
         FJqVWnrLJmykzlc241YG7ssQdFE9U3bahyz96+nuP90lxk+MyONdGFJUacAIus0arh
         X4rXYnxWK1S1bN8P9ZAaf5GMI2F2tk4/TSvgv9FWPQV/MFV1FtA+QBkjlTDKErIOFn
         MoPkjtJloH0xdk0Gyl3FgirR+77bJ8fgnPj3v307kjTpmVS0ftaeaIeU1lq9iKZw0j
         eZjVyM6leBWtnB7hltloYIp6rCnjszrTzcf71kiFGX97cPs4tkKSSg5sGq3DV6uTFt
         mEv0D/jx0fbsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 1:18 AM, Michal Hocko wrote:
> On Mon 19-08-19 12:30:18, John Hubbard wrote:
>> On 8/19/19 12:06 PM, Bharath Vedartham wrote:
>>> On Mon, Aug 19, 2019 at 07:56:11AM -0500, Dimitri Sivanich wrote:
...
>> Conversion of gup/put_page sites:
>>
>> Before:
>>
>> 	get_user_pages(...);
>> 	...
>> 	for each page:
>> 		put_page();
>>
>> After:
>> 	
>> 	gup_flags |= FOLL_PIN; (maybe FOLL_LONGTERM in some cases)
>> 	vaddr_pin_user_pages(...gup_flags...)
> 
> I was hoping that FOLL_PIN would be handled by vaddr_pin_user_pages.
> 

Good point: now that we've got the 4 cases summarized, it turns out
that either FOLL_PIN is required, or there is no need to call
vaddr_pin_user_pages() at all.  So we can go back to setting FOLL_PIN
inside it, which is of course much better for maintenance. Great!


>> 	...
>> 	vaddr_unpin_user_pages(); /* which invokes put_user_page() */
>>
>> Fortunately, it's not harmful for the simpler conversion from put_page()
>> to put_user_page() to happen first, and in fact those have usually led
>> to simplifications, paving the way to make it easier to call
>> vaddr_unpin_user_pages(), once it's ready. (And showing exactly what
>> to convert, too.)
> 
> If that makes the later conversion easier then no real objections from
> me. Assuming that the current put_user_page conversions are correct of
> course (I have the mlock one and potentials that falls into the same
> category in mind).
> 

Agreed: only correct conversions should be done. Not the incorrect
ones. ahem.  :)

thanks,
-- 
John Hubbard
NVIDIA
