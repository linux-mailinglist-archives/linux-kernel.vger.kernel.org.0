Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535BB73EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfGXU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:28:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40273 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfGXTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:34:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so21719703pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fDn3AFXXm19Ake8tU5gjq3MWC1W7K5qFY0eF05b2Pc=;
        b=MQuSOeR9mj5QCC1q4RsYGdjizf19viLBu8D0muFmywAqDmossyMthj1BsTRNG8GwDI
         kxGHWNPIj3YJR1RWdDp7q+atj144Oxc6UttaYcUuFECwrQVyHnbjrs/T/hkRg6c2APan
         pkPDkRAUv4DyfkYuDSYr8lqe07nJw1WycUm1GdzJKL+XhWhy3CedPhbfcC/oZWDJX96Z
         HphILDBSrUAMcxlSt5OQJiUdyFQKoKLtjOWQJAoTJBz4RfW0sl5Uv3RrbHmNfO618yw6
         QFFO1qg0PjZsg8UfzVFJexHRrSi+j6VzvJ1Lix3GIyXS5Q3uM/Ng9CEbCxPzAi2ZGMlp
         fYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fDn3AFXXm19Ake8tU5gjq3MWC1W7K5qFY0eF05b2Pc=;
        b=CPt01Uck5X5NupSF8dpzNy5eLxx1kY9AoK0EvFhqwVCJVPHQm67G6ThOre22FcD6sj
         eRHxOjoDJI9PRB2kZ3y22pgCB0idH00pKW/bGjdr8GtVtZsQVFjtFkA9YG4/G5T/Unzd
         3beCjwDV7u23t2yLcK0CI6a7UB9DB/kmHoQbmXazDUEx1kGmqVky60sckhb7eMBgj8I2
         JX26pmnw7oYJ+nFDGh6grlZuQLzCz6SEODdBJy8I9PN2dZAhQoVqBf9+N551fW+yMgM6
         Onlwe4Oo4xtb+IiGyHj43ISDtq4MN9krVonokETyg3bvQwAqj5Zg8X25OOoYhdeRdSL4
         87Tg==
X-Gm-Message-State: APjAAAVCtXhe8ih34a/OJ+NLjgqFucDKJS8O8BvdTPKT47XszDx695Hp
        hi8+dCiyai10W34H6VQ0348=
X-Google-Smtp-Source: APXvYqzWJWqJ5BleMO/Ei96DUKZpyyodxYvZ1d6IP5GguMosVsO0BWc/rWyOZUkMH7b44piPkNU3oA==
X-Received: by 2002:a17:90a:cb15:: with SMTP id z21mr43431285pjt.87.1563996868963;
        Wed, 24 Jul 2019 12:34:28 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id v7sm4447177pff.87.2019.07.24.12.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:34:28 -0700 (PDT)
Date:   Thu, 25 Jul 2019 01:04:19 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com,
        ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] sgi-gru: Use __get_user_pages_fast in
 atomic_pte_lookup
Message-ID: <20190724193418.GA19421@bharath12345-Inspiron-5559>
References: <20190724160929.GA14052@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724160929.GA14052@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:09:29AM -0700, Christoph Hellwig wrote:
> I think the atomic_pte_lookup / non_atomic_pte_lookup helpers
> should simply go away.  Most of the setup code is common now and should
> be in the caller where it can be shared.  Then just do a:
> 
> 	if (atomic) {
> 		__get_user_pages_fast()
> 	} else {
> 		get_user_pages_fast();
> 	}
> 
> and we actually have an easy to understand piece of code.

That makes sense. I ll do that and send v3. I ll probably cut down on a
patch and try to fold all the changes into a single patch removing the
*pte_lookup helpers.
