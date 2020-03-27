Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56BA1957FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 14:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0N10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 09:27:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0N1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:27:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so11398374wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MiukankS2d7HoYog4uANLr+kARZRnzMZU2xCKuAVLzw=;
        b=iZo3Z5/hPxxnQ4EWWx1JJmhNk3kYv8xKiaps4ep//w5VyMNqVTuh9PiCjiYvewDmr8
         6VWBPsBnNplJbLo/E1nQlQr1VoY6ciX7nxmQ7ml6NNZ6AQFEeTa6c064Hz+uQBkMxIYb
         wXDJmgh3VB+RmSAHHnDcOHpSMifXRhmaraoK5USGFBHzIQSMwytoEKO3pC0+NhpHsSQj
         Poh0JDNIB7VKR27DgAuTneNIVNcbC48+wt4FILzJRgYgTlXJoyOrQpnKqqxSSiM40xgW
         rE/07Esi5tND2/aO3nbkV9omsfklgvrJjI7zPSC9wfb5tpNFqwNldOqwOWMGaRjIDCWj
         5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MiukankS2d7HoYog4uANLr+kARZRnzMZU2xCKuAVLzw=;
        b=WHCJbbi3NBR+9J5s/MnAVy2jsH3XXxmD7RByerlUtyx3qeVry36BBwJ8yYO//l07Jg
         ZOU8MQZT+b5SFcJUzM+EjswnpE3Pvp+lgpD61m4XfJB46dtnp0aQOaMTBHRKTDMa2DZR
         ak+ycmg/oluCae3zZR1WUw4qxKRCcXfUcu/HW8ReYarM3Z6wpjyNVvTEajLmVg0s08Em
         nDultH/vvQL2udOGLAikO1WKaaCJWEBqQf2sa/bBClo2RCtI5cLXzpStagDYB6nDLCG+
         YJpjNY+JQHwlc0mzLbTCL+iwHPu6kqWd/G2XiDPJX+Ftg4ATdfunCMJJWvTYKT4IlxT5
         LZ+Q==
X-Gm-Message-State: ANhLgQ3FdFdVVsI28JnFnvTg9WWCjrgaQRWkJWmeMoh0I+9qFtBX7odF
        EziWs2SwwN2iacyVKT4Gf7w=
X-Google-Smtp-Source: ADFU+vsnYsTAqeHpcm8tqBofCqi4JBfOXJF5rVRfuLS7F1WUtlA/PE3zXOxs67WjpxoJNi1u4gmHaQ==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr15194886wro.68.1585315643876;
        Fri, 27 Mar 2020 06:27:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y16sm8334328wrp.78.2020.03.27.06.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 06:27:23 -0700 (PDT)
Date:   Fri, 27 Mar 2020 13:27:22 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc.c: leverage compiler to zero out
 used_mask
Message-ID: <20200327132722.rovaz5hghl5vhhl7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200326222445.18781-1-richard.weiyang@gmail.com>
 <20200326223604.GP20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326223604.GP20941@ziepe.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:36:04PM -0300, Jason Gunthorpe wrote:
>On Thu, Mar 26, 2020 at 10:24:44PM +0000, Wei Yang wrote:
>> Since we always clear used_mask before getting node order, we can
>> leverage compiler to do this instead of at run time.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>  mm/page_alloc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0e823bca3f2f..2144b6ceb119 100644
>> +++ b/mm/page_alloc.c
>> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>>  {
>>  	static int node_order[MAX_NUMNODES];
>>  	int node, load, nr_nodes = 0;
>> -	nodemask_t used_mask;
>> +	nodemask_t used_mask = {.bits = {0}};
>
>If this style is to be done it should just be '= {}';
>
>This case demonstrates why the popular '= {0}' idiom is not such a
>good idea, as it only works if the first member is an integral type.
>

Thanks for your comment. I think David found a better solution.

>Jason

-- 
Wei Yang
Help you, Help me
