Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17BED6B06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfJNVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 17:02:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4098 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJNVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:02:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da4e2550001>; Mon, 14 Oct 2019 14:02:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 14:02:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Oct 2019 14:02:02 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 21:02:02 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 21:02:01 +0000
Subject: Re: Documentation/, SPDX tags, and checkpatch.pl
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <124ecffe-25a0-ace6-f106-d9d173c17035@nvidia.com>
 <f7ebadf988edddd423187c3a09fcc35bf69b25f6.camel@perches.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <403794f4-fc55-0591-d613-5c3d440abdbe@nvidia.com>
Date:   Mon, 14 Oct 2019 14:02:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7ebadf988edddd423187c3a09fcc35bf69b25f6.camel@perches.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571086933; bh=WhdlqgGD4WNpAO9N83U+RIExqRfkcKvyt18GI27NTV8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GHUdQAsLNy7m1gWqU+ZGUWPxpt4A2DkPxZNB2PKHXy8vOz/HIsKUTJ3ZQKFXhzPMR
         jJq3zGuSsjUIN7jF9Gcp7N/2s7EV1JfxrmuTsSFqVzF7FAGZ7yxPBMpiZUxJ75+N4U
         k0U0JB0p9QXnfkrcwkuA/N6jHf8tEQcHRdzgcmna70qvZDO/4/yy7xchyGazKyxKen
         b6h2nRveGsmyxGNZOVY6zbWs9IA+fwmD3RQLumJO+CFs/dqAorHQus7LzjSUkiYXqj
         VQ25GI8/ygXyMzOfvliTe8qWffStykfuh7lAPz2R6Drvz0jA65rVUorhxRjarOLWJJ
         46BD3tleOODpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 1:55 PM, Joe Perches wrote:
> On Mon, 2019-10-14 at 13:47 -0700, John Hubbard wrote:
>> Hi,
>>
>> When adding a new Documentation/ file, checkpatch.pl is warning me
>> that the SPDX tag is missing. Should checkpatch.pl skip those kinds
>> of warnings, seeing as how we probably don't intend on putting the
>> SPDX tags at the top of the Documentation/*.rst files?
>>
>> Or are we, after all? I'm just looking to get to a warnings-free situation 
>> here, one way or the other. :)
>>
>> The exact warning I'm seeing is:
>>
>> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>> #25: FILE: Documentation/vm/get_user_pages.rst:1:
>> +.. _get_user_pages:
>>
> 
> Looks like ~18% of the .rst files already have SPDX markers
> 
> $ git ls-files -- '*.rst' | wc -l
> 2125
> 
> $ git grep -n "SPDX-License-Identifier:" -- '*.rst'| grep ':1:' | wc -l
> 378
> 
> Likely all .rst files will have these markers eventually.
> 

hah, I had tunnel vision: none of the Documentation/vm/*.rst files that I 
was looking at as examples had the tags.

I'll add the tag, sorry about the confusion and thanks for the quick 
response!

thanks,

John Hubbard
NVIDIA
